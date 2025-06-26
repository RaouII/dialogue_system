@tool
class_name TopicGraphNode extends GraphNode

const CONDITION_CONTAINER = preload("uid://brcs06hnkrc38")
const FUNCTION_CONTAINER = preload("uid://wgt14ibhh8uf")
@onready var topic_prompt : TextEdit = $"Topic Container/HFlowContainer/Topic Prompt"
@onready var goodbye : CheckBox = $"Flag Container/MarginContainer2/VBoxContainer/Goodbye"
@onready var random : CheckBox = $"Flag Container/MarginContainer2/VBoxContainer/Random"
@onready var condition_list_container = $"Conditions Container/ConditionListContainer"
@onready var function_list_container = $"Functions Container/FunctionListContainer"

@export var starting: bool = false

var condition_list: Array[ConditionContainer] = []
var function_list: Array[FunctionContainer] = []
var resource_edit: Resource
var inspector_list: Array = []
var condition_container : ConditionContainer
var function_container : FunctionContainer
func _on_button_button_up():
	queue_free()
	pass # Replace with function body.


########################
func _on_add_condition_pressed():
	condition_container = CONDITION_CONTAINER.instantiate()
	condition_list_container.add_child(condition_container)
	condition_list.append(condition_container)
	condition_container.deleted.connect(_on_condition_deleted)

func _on_condition_deleted(_name: String):
	pass
########################	
func _on_add_function_pressed():
	function_container = FUNCTION_CONTAINER.instantiate()
	function_list_container.add_child(function_container)
	function_list.append(function_container)
	function_container.deleted.connect(_on_function_deleted)

func _on_function_deleted(_name: String):
	pass
