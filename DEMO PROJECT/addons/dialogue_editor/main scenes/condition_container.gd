@tool
class_name ConditionContainer extends VBoxContainer

var resource_editor : EditorInspector
var condition_picker : EditorResourcePicker
var current_resource

@onready var h_box_container = $HBoxContainer
@onready var check_box = $HBoxContainer/CheckBox

signal deleted()

func _on_delete_pressed():
	deleted.emit(self)
	queue_free()
	
	
func _update_resource_editor(is_visible):
	if resource_editor != null:
		resource_editor.queue_free()
	resource_editor = EditorInspector.new()
	resource_editor.draw_focus_border = true
	resource_editor.custom_minimum_size= Vector2(100,200)
	self.add_child(resource_editor)
	resource_editor.edit(current_resource)
	resource_editor.visible = is_visible

func _on_resource_changed(_resource: Resource):
	if _resource:
		check_box.set_pressed_no_signal(true)
		check_box.text = "▼"
		_update_resource_editor(true)
	else:
		check_box.text = "▶"
		check_box.set_pressed_no_signal(false)
		_update_resource_editor(false)
	resource_editor.edit(_resource)
	current_resource = _resource
	pass
func _ready():
	condition_picker = EditorResourcePicker.new()
	var delete_button = Button.new()
	delete_button.text = "x"
	delete_button.custom_minimum_size = Vector2(24,16)
	delete_button.pressed.connect(_on_delete_pressed)
	condition_picker.base_type = "Condition"
	condition_picker.resource_changed.connect(_on_resource_changed)
	condition_picker.custom_minimum_size= Vector2(200,6)
	condition_picker.editable = true
	condition_picker.toggle_mode = true
	h_box_container.add_child(condition_picker)
	h_box_container.add_child(delete_button)
	
	_update_resource_editor(false)


func _on_check_box_toggled(toggled_on):
	if current_resource:
		condition_picker.set_toggle_pressed(toggled_on)
		_update_resource_editor(toggled_on)
		if toggled_on:
			check_box.text = "▼"
		else:
			check_box.text = "▶"
	else:
		check_box.set_pressed_no_signal(false)
		pass # Replace with function body.
