@tool
extends EditorPlugin

var dialogue_editor_dock
var dialogue_autoload_path = "res://addons/dialogue_editor/Dialogue System/dialogue.gd"
var dialogue_controller_autoload_path = "res://addons/dialogue_editor/Dialogue System/dialogue_controller.gd"
var dialogue_ui_autoload_path = "res://addons/dialogue_editor/Dialogue System/dialogue_ui.gd"
func _enter_tree():
	# Load your custom editor dock
	dialogue_editor_dock = preload("res://addons/dialogue_editor/main scenes/SegmentEditor.tscn").instantiate()
	# Add it to the right dock slot in the editor
	add_control_to_dock(DOCK_SLOT_RIGHT_UL, dialogue_editor_dock)
	#if not ProjectSettings.has_setting("autoload/" + "Dialogue"):
		#add_autoload_singleton("Dialogue", dialogue_autoload_path)
	if not ProjectSettings.has_setting("autoload/" + "DialogueController"):
		add_autoload_singleton("DialogueController", dialogue_controller_autoload_path)
	if not ProjectSettings.has_setting("autoload/" + "DialogueUI"):
		add_autoload_singleton("DialogueUI", dialogue_ui_autoload_path)
	# Optional: Set the dock's name (visible in the editor)
	dialogue_editor_dock.name = "Dialogue Editor"

func _exit_tree():
	# Remove the dock when plugin is disabled
	remove_control_from_docks(dialogue_editor_dock)
	#remove_autoload_singleton("Dialogue")
	remove_autoload_singleton("DialogueController")
	remove_autoload_singleton("DialogueUI")
	dialogue_editor_dock.free()
