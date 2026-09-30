# Godot editor integration checks

Run these checks only in a disposable Godot 4.7+ project. They create and close
terminal sessions, resize the test editor, and quit when finished.

1. Build Godotty and install `addons/godotty`, including its platform binary, in
   the test project as described in the main README.
2. Create `addons/grid_validation/` in that project. Copy either
   `tests/bottom_grid.gd` (real bottom panel) or `tests/terminal_grid.gd`
   (main screen, resizing, tab order, titles, and lifecycle) there as `plugin.gd`.
3. Create `addons/grid_validation/plugin.cfg`:

   ```ini
   [plugin]
   name="Grid validation"
   description="Disposable Godotty integration checks"
   author="Godotty"
   version="1"
   script="plugin.gd"
   ```

4. Enable this temporary plugin in the test project's `project.godot`:

   ```ini
   [editor_plugins]
   enabled=PackedStringArray("res://addons/grid_validation/plugin.cfg")
   ```

5. Launch `godot --editor --path /path/to/test-project`. A successful run prints
   `PASS` and exits with code 0. Failures print their reasons and exit with code 1.
   On Unix, `SHELL=/bin/sh` gives the tests a shell without personal zsh startup
   configuration. The bottom-panel check also dispatches a mouse click through
   the real editor viewport and verifies pane focus and tab selection.

The bottom-panel check saves `bottom-columns.png` and `bottom-grid.png` in the
test project's `user://` directory. Set `GODOTTY_TEST_ARTIFACT_DIR` to an absolute
directory outside the test project to choose another destination. Keeping
captures outside `res://` avoids asset-import dialogs interrupting input tests.

The pure layout boundary tests run with `cargo test --lib`.
