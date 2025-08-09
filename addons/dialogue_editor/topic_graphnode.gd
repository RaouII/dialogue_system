@tool
class_name TopicGraphNode extends GraphNode

const CONDITION_CONTAINER = preload("uid://brcs06hnkrc38")
const FUNCTION_CONTAINER = preload("uid://wgt14ibhh8uf")
@onready var topic_prompt : TextEdit = %TopicPrompt
@onready var goodbye : CheckBox = %Goodbye
@onready var random : CheckBox = %Random

@onready var topic_prompt_container = %TopicPromptContainer

@onready var is_greeting_toggle = %IsGreeting
var is_greeting: bool = false
@onready var startingTopic_flags = %StartingTopic_Flags
@onready var greeting_flags = %Greeting_Flags
@onready var exclusive = %Exclusive
@onready var spin_box = %PriorityNumber


@onready var condition_list_container = $"Conditions Container/ConditionListContainer"
@onready var function_list_container = $"Functions Container/FunctionListContainer"

@export var starting: bool = false

var condition_list: Array[ConditionContainer] = []
var function_list: Array[FunctionContainer] = []
var resource_edit: Resource
var inspector_list: Array = []
var condition_container : ConditionContainer
var function_container : FunctionContainer
var greeting: bool = false

func _on_button_button_up():
	
	queue_free()
	pass # Replace with function body.


########################
func _on_add_condition_pressed():
	condition_container = CONDITION_CONTAINER.instantiate()
	condition_list_container.add_child(condition_container)
	condition_list.append(condition_container)
	condition_container.deleted.connect(_on_condition_deleted)

func _on_condition_deleted(_name: ConditionContainer):
	condition_list.erase(_name)
	pass
########################	
func _on_add_function_pressed():
	function_container = FUNCTION_CONTAINER.instantiate()
	function_list_container.add_child(function_container)
	function_list.append(function_container)
	function_container.deleted.connect(_on_function_deleted)

func _on_function_deleted(_name: FunctionContainer):
	function_list.erase(_name)
	pass

func _reload_info():
	if starting:
		if is_greeting:
			startingTopic_flags.visible = false
			topic_prompt_container.visible = false
			greeting_flags.visible = true
		else:
			startingTopic_flags.visible = true
			topic_prompt_container.visible = true
			greeting_flags.visible = false

func _on_is_greeting_pressed():
	is_greeting = !is_greeting
	if is_greeting:
		startingTopic_flags.visible = false
		topic_prompt_container.visible = false
		greeting_flags.visible = true
	else:
		startingTopic_flags.visible = true
		topic_prompt_container.visible = true
		greeting_flags.visible = false
	pass # Replace with function body.
