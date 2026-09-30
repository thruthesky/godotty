@tool
extends EditorPlugin
## Enable as a temporary editor plugin in a disposable test project.
## Unlike --script, this runs inside Godot's normal editor main loop.

var failures := 0

func _enter_tree() -> void:
    _run.call_deferred()

func _check(condition: bool, message: String) -> void:
    if not condition:
        failures += 1
        push_error(message)

func _settle() -> void:
    await get_tree().create_timer(0.4).timeout

func _find_bottom(node: Node) -> Control:
    if node == EditorInterface.get_editor_main_screen():
        return null
    if node.get_class() == "TerminalTabs":
        return node
    for child in node.get_children():
        var found := _find_bottom(child)
        if found != null:
            return found
    return null

func _capture(name: String) -> void:
    if DisplayServer.get_name() != "headless":
        await RenderingServer.frame_post_draw
        # Keep captures outside res:// so importing them cannot open a modal
        # progress dialog in the middle of the mouse-input checks.
        var output := OS.get_environment("GODOTTY_TEST_ARTIFACT_DIR")
        if output.is_empty():
            output = ProjectSettings.globalize_path("user://")
        DirAccess.make_dir_recursive_absolute(output)
        get_tree().root.get_texture().get_image().save_png(output.path_join(name))

func _run() -> void:
    await get_tree().create_timer(2.0).timeout
    get_tree().root.size = Vector2i(1600, 1000)
    var bottom := _find_bottom(EditorInterface.get_base_control())
    if bottom == null:
        push_error("Godotty's bottom panel is missing")
        get_tree().quit(1)
        return
    var bar: TabBar = bottom.get_child(0).get_child(0)
    var grid: GridContainer = bottom.get_child(1).get_child(0)
    make_bottom_panel_item_visible(bottom)
    await _settle()
    while bar.tab_count < 2:
        bottom.call("add_terminal")
    await _settle()
    var panes := grid.get_children()
    print("Bottom layout: scale=", EditorInterface.get_editor_scale(), ", width=", grid.size.x, ", columns=", grid.columns)
    _check(bottom.is_visible_in_tree(), "The real bottom panel is not visible")
    _check(grid.columns == 2, "Two bottom terminals are not arranged in columns")
    _check(panes[0].is_visible_in_tree() and panes[1].is_visible_in_tree(), "A bottom terminal is hidden")
    _check(is_equal_approx(panes[0].position.y, panes[1].position.y), "Two terminals are not on the same row")
    _check(panes[1].position.x >= panes[0].position.x + panes[0].size.x, "Bottom terminals overlap")
    await _capture("bottom-columns.png")

    bottom.call("add_terminal")
    bottom.call("add_terminal")
    await _settle()
    panes = grid.get_children()
    _check(grid.columns == 2 and panes.size() == 4, "Four terminals did not form a two-column grid")
    _check(panes.all(func(pane): return pane.is_visible_in_tree()), "The bottom grid hid a terminal")
    _check(panes[2].position.y >= panes[0].position.y + panes[0].size.y, "Additional terminals did not wrap to the next row")
    await _capture("bottom-grid.png")

    # Send a mouse event through the editor viewport's GUI dispatch.
    var click := InputEventMouseButton.new()
    click.button_index = MOUSE_BUTTON_LEFT
    click.position = panes[0].global_position + Vector2(20, 20)
    click.global_position = click.position
    click.pressed = true
    get_tree().root.push_input(click, true)
    click = click.duplicate()
    click.pressed = false
    get_tree().root.push_input(click, true)
    await _settle()
    _check(panes[0].has_focus() and bar.current_tab == 0, "Clicking a bottom pane did not focus/select it")
    bar.current_tab = 3
    await _settle()
    _check(panes[3].has_focus(), "A bottom tab did not focus its terminal")

    bar.tab_close_pressed.emit(3)
    await _settle()
    _check(grid.get_child_count() == 3 and bar.tab_count == 3, "Closing a bottom pane did not update the grid")
    while bar.tab_count > 0:
        bar.tab_close_pressed.emit(0)
        await _settle()
    _check(grid.get_child_count() == 0, "Closing all bottom panes recreated a terminal")
    _check(bottom.get_child(1).get_child(1).visible, "The bottom empty state is missing")
    hide_bottom_panel()
    print("Bottom panel columns/grid checks: ", "PASS" if failures == 0 else "FAIL (%d)" % failures)
    get_tree().quit(0 if failures == 0 else 1)
