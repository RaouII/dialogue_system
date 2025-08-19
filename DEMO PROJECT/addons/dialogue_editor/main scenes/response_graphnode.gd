@tool
class_name ResponseGraphNode extends GraphNode

const CONDITION_CONTAINER = preload("uid://brcs06hnkrc38")
const FUNCTION_CONTAINER = preload("uid://wgt14ibhh8uf")
@onready var topic_prompt : TextEdit = %TextEdit
@onready var character_id_label = %CharacterIDLabel
@onready var characterIDFilePicker = %characterIDFilePicker
var characterID: CharacterID
var animation: String
var colapsed: bool = false
@onready var response_connection_container = %response_connection_container
@onready var button = %Button
@onready var data_container = %DataContainer
@onready var animation_container = %AnimationContainer
@onready var condition_list_container = %ConditionListContainer
@onready var function_list_container = %FunctionListContainer

@onready var timer = $Timer
var condition_container : ConditionContainer
var function_container : FunctionContainer
var condition_list: Array[ConditionContainer] = []
var function_list: Array[FunctionContainer] = []

func _on_text_edit_text_changed():
	#title = topic_prompt.text
	pass # Replace with function body.


func _on_file_dialog_file_selected(path):
	var id: CharacterID = load(path)
	character_id_label.text = id.name
	characterID = id
	characterIDFilePicker.visible = false
	if id != null:
		animation_container.visible = true
	pass # Replace with function body.


func _on_animation_label_text_changed():
	animation = $HBoxContainer/AnimationLabel.text
	pass # Replace with function body.


func _on_select_id_button_up():
	characterIDFilePicker.visible = true
	pass # Replace with function body.


func _on_button_button_up():
	colapsed = !colapsed
	if colapsed:
		button.text = "expand"
		response_connection_container.visible = false
		data_container.visible  = false
		size.y = 150
	else:
		button.text = "colapse"
		response_connection_container.visible = true
		data_container.visible  = true
	pass # Replace with function body.


func _on_add_condition_pressed():
	condition_container = CONDITION_CONTAINER.instantiate()
	condition_list_container.add_child(condition_container)
	condition_list.append(condition_container)
	condition_container.deleted.connect(_on_condition_deleted)
	pass # Replace with function body.
func _on_condition_deleted(_name: ConditionContainer):
	condition_list.erase(_name)
	timer.start()

func _on_add_function_pressed():
	function_container = FUNCTION_CONTAINER.instantiate()
	function_list_container.add_child(function_container)
	function_list.append(function_container)
	function_container.deleted.connect(_on_function_deleted)
	pass # Replace with function body.
func _on_function_deleted(_name: FunctionContainer):
	function_list.erase(_name)
	timer.start()

func _on_timer_timeout():
	size = Vector2(100,0)
	pass # Replace with function body.
