@tool
extends EditorPlugin
## Enable as a temporary editor plugin in a disposable test project.
## See tests/README.md for setup.

var failures := 0

func _enter_tree() -> void:
    _run.call_deferred()

func _check(condition: bool, message: String) -> void:
    if not condition:
        failures += 1
        push_error(message)

func _settle() -> void:
    for i in range(10):
        await get_tree().process_frame
    await get_tree().create_timer(0.15).timeout

func _find_tabs(node: Node) -> Control:
    if node.get_class() == "TerminalTabs":
        return node
    for child in node.get_children():
        var found := _find_tabs(child)
        if found != null:
            return found
    return null

func _run() -> void:
    await get_tree().create_timer(2.0).timeout
    var root := get_tree().root
    await _settle()
    if not ClassDB.class_exists("TerminalTabs"):
        push_error("Godotty is not loaded. Install the built addon in the test project first.")
        get_tree().quit(1)
        return

    # TerminalTabs is internal; exercise the real main-screen view registered
    # by the editor plugin instead of constructing a script-visible substitute.
    var tabs := _find_tabs(EditorInterface.get_editor_main_screen())
    if tabs == null:
        push_error("Godotty's main-screen view was not registered")
        get_tree().quit(1)
        return
    var original_parent := tabs.get_parent()
    var original_index := tabs.get_index()
    tabs.hide()
    var host := Control.new()
    root.add_child(host)
    tabs.reparent(host)
    var scale := EditorInterface.get_editor_scale()
    tabs.size = Vector2(1120, 600) * scale
    var bar: TabBar = tabs.get_child(0).get_child(0)
    var panel: PanelContainer = tabs.get_child(1)
    var grid: GridContainer = panel.get_child(0)
    var empty: Control = panel.get_child(1)
    _check(bar.tab_count == 0 and empty.visible, "Initial empty state is missing")

    tabs.show()
    await _settle()
    _check(bar.tab_count == 1, "Showing an empty view should create exactly one terminal")
    for i in range(3):
        tabs.call("add_terminal")
    await _settle()
    _check(grid.get_child_count() == 4, "Adding terminals lost a pane")
    _check(grid.columns == 3, "Wide views should fill columns before wrapping")
    _check(not empty.visible, "Empty overlay is covering open terminals")
    var panes := grid.get_children()
    for pane in panes:
        _check(pane.visible and pane.size.x > 0 and pane.size.y > 0, "Every pane must be visible and have space")
    for i in range(panes.size()):
        for j in range(i + 1, panes.size()):
            _check(not panes[i].get_rect().intersects(panes[j].get_rect()), "Terminal panes overlap")
    _check(panes[3].position.y > panes[0].position.y, "Fourth terminal should wrap to a new row")
    if "--capture-grid" in OS.get_cmdline_user_args():
        await get_tree().create_timer(0.5).timeout
        await RenderingServer.frame_post_draw
        root.get_texture().get_image().save_png("user://terminal-grid.png")

    panes[0].grab_focus()
    await _settle()
    _check(bar.current_tab == 0 and panes[0].has_focus(), "Pane focus did not select its tab")
    bar.current_tab = 2
    await _settle()
    _check(panes[2].has_focus(), "Selecting a tab did not focus its pane")
    bar.grab_focus()
    bar.tab_clicked.emit(2)
    await _settle()
    _check(panes[2].has_focus(), "Clicking the selected tab did not restore terminal focus")
    _check(panes.all(func(pane): return pane.visible), "Focus changes hid a terminal")

    bar.move_tab(0, 3)
    bar.active_tab_rearranged.emit(3)
    await _settle()
    for i in range(bar.tab_count):
        _check(bar.get_tab_metadata(i) == grid.get_child(i).get_instance_id(), "Tab and pane order diverged")
    var first: Control = grid.get_child(0)
    tabs.call("on_title_changed", "Grid test", first)
    _check(bar.get_tab_title(0) == "Grid test", "Title updates targeted the wrong pane")

    tabs.size.x = 750 * scale
    await _settle()
    _check(grid.columns == 2, "Resizing did not recalculate columns")
    tabs.size.x = 500 * scale
    await _settle()
    _check(grid.columns == 1, "Narrow views should fall back to one column")
    tabs.size.x = 1120 * scale
    await _settle()

    bar.tab_close_pressed.emit(1)
    await _settle()
    _check(bar.tab_count == 3 and grid.get_child_count() == 3, "Closing a tab lost the wrong number of panes")
    tabs.call("on_exited", 0, grid.get_child(0))
    await _settle()
    _check(bar.tab_count == 2 and grid.columns == 2, "Process exit did not remove its pane and refill the grid")
    while bar.tab_count > 0:
        bar.tab_close_pressed.emit(0)
    await _settle()
    _check(grid.get_child_count() == 0 and empty.visible, "Closing the last pane did not restore the empty state")
    tabs.call("add_terminal")
    await _settle()
    _check(grid.get_child_count() == 1 and grid.columns == 1 and not empty.visible, "Reopening from the empty state failed")

    # The bottom panel shares the same implementation but has a different
    # parent/layout. Check registration, creation, and closing there as well.
    var bottom := _find_tabs(EditorInterface.get_base_control())
    _check(bottom != null, "Godotty's bottom-panel view was not registered")
    if bottom != null:
        var bottom_bar: TabBar = bottom.get_child(0).get_child(0)
        var bottom_grid: GridContainer = bottom.get_child(1).get_child(0)
        while bottom_bar.tab_count > 0:
            bottom_bar.tab_close_pressed.emit(0)
        await _settle()
        bottom.call("add_terminal")
        bottom.call("add_terminal")
        await _settle()
        _check(bottom_bar.tab_count == 2 and bottom_grid.get_child_count() == 2, "Bottom panel did not retain multiple panes")
        for pane in bottom_grid.get_children():
            _check(pane.visible, "Bottom panel hid a terminal")
        while bottom_bar.tab_count > 0:
            bottom_bar.tab_close_pressed.emit(0)
        await _settle()
        _check(bottom_grid.get_child_count() == 0, "Bottom panel recreated a terminal after closing all panes")

    # The plugin owns the view and frees it during editor shutdown.
    tabs.hide()
    tabs.reparent(original_parent)
    original_parent.move_child(tabs, original_index)
    host.queue_free()
    await _settle()
    print("Terminal grid integration checks: ", "PASS" if failures == 0 else "FAIL (%d)" % failures)
    get_tree().quit(0 if failures == 0 else 1)
