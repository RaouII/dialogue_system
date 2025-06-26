@tool
class_name FunctionContainer extends VBoxContainer

var resource_editor : EditorInspector
var function_picker: EditorResourcePicker
var current_resource
@onready var h_box_container = $HBoxContainer
@onready var check_box = $HBoxContainer/CheckBox

signal deleted(_string: String)

func _on_delete_pressed():
	deleted.emit(name)
	queue_free()
	

func _on_resource_changed(_resource: Resource):
	resource_editor.edit(_resource)
	current_resource = _resource
	if _resource:
		check_box.set_pressed_no_signal(true)
		check_box.text = "▼"
		resource_editor.visible = true
	else:
		check_box.text = "▶"
		check_box.set_pressed_no_signal(false)
		resource_editor.visible = false
	pass
func _ready():
	function_picker = EditorResourcePicker.new()
	var delete_button = Button.new()
	delete_button.text = "x"
	delete_button.custom_minimum_size = Vector2(16,16)
	delete_button.pressed.connect(_on_delete_pressed)
	function_picker.base_type = "Function"
	function_picker.resource_changed.connect(_on_resource_changed)
	function_picker.custom_minimum_size= Vector2(200,20)
	function_picker.editable = true
	function_picker.toggle_mode = true
	h_box_container.add_child(function_picker)
	h_box_container.add_child(delete_button)
	
	resource_editor = EditorInspector.new()
	resource_editor.visible = false
	resource_editor.draw_focus_border = true
	resource_editor.custom_minimum_size= Vector2(100,200)
	self.add_child(resource_editor)


func _on_check_box_toggled(toggled_on):
	if current_resource:
		function_picker.set_toggle_pressed(toggled_on)
		resource_editor.visible = toggled_on
		if toggled_on:
			check_box.text = "▼"
		else:
			check_box.text = "▶"
	else:
		check_box.set_pressed_no_signal(false)
		pass # Replace with function body.
