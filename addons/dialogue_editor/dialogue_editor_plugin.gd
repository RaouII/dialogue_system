@tool
extends EditorPlugin

var dialogue_editor_dock

func _enter_tree():
	# Load your custom editor dock
	dialogue_editor_dock = preload("res://addons/dialogue_editor/BranchEditor.tscn").instantiate()
	# Add it to the right dock slot in the editor
	add_control_to_dock(DOCK_SLOT_LEFT_UR, dialogue_editor_dock)
	# Optional: Set the dock's name (visible in the editor)
	dialogue_editor_dock.name = "Dialogue Editor"

func _exit_tree():
	# Remove the dock when plugin is disabled
	remove_control_from_docks(dialogue_editor_dock)
	dialogue_editor_dock.free()
