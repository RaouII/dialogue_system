extends Node


const textbox_prefab = preload("uid://ciworq5pvrgnj")
const RESPONSE_CONTAINER = preload("uid://8v136rihlugn")
const TOPIC_CONTAINER = preload("uid://diejsi3sdvvcw")
const CHOICE_BUTTON = preload("uid://dbxh37k37eypu")

var dialogue_lines: Array[DialogueResponse] = []
var current_line_index = 0

var current_branch: DialogueSegment
var current_topic: DialogueTopic
var current_greeting: DialogueTopic

var text_box
var text_box_position: Vector2
var current_tree: DialogueTree

var is_dialogue_active = false
var can_advance_line = false

func _ready():
	DialogueController.display_text.connect(_on_display_text)
	DialogueController.show_topic.connect(_on_show_topic)
	DialogueController.closed_dialogue.connect(_on_closed_dialogue)
	DialogueController.cutscene_dialogue_closed.connect(cutscene_close_dialogue)
	
func _on_closed_dialogue():
	if text_box:
		text_box.queue_free()
	reset_vars()
	
func _on_show_topic(topic: DialogueTopic):
	create_topic(topic)
	pass
	
func _on_display_text(text: String):
	instantiate_text_box()
	text_box.display_text(text)
	pass

func create_topic(topic: DialogueTopic):
	if text_box.choice_container == null:
		init_topicContainer()
	var choice = CHOICE_BUTTON.instantiate()
	choice.text = topic._topicText
	choice._dialogueTopic = topic
	text_box.choice_container.v_box_container.add_child(choice)

func init_topicContainer():
	if text_box.choice_container == null:
		text_box.choice_container = TOPIC_CONTAINER.instantiate()
		text_box.container.add_child(text_box.choice_container)
		

func clear_topicContainer():
	if text_box.choice_container != null:
		text_box.choice_container.queue_free()

func clear_responseContainer():
	if text_box.response_container != null:
		text_box.response_container.queue_free()

func instantiate_text_box():
	if text_box != null:
		text_box.queue_free()
	text_box = textbox_prefab.instantiate()
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	Global.canvas.add_child(text_box)
	if text_box.response_container == null:
		text_box.response_container = RESPONSE_CONTAINER.instantiate()
		text_box.container.add_child(text_box.response_container)


func _on_text_box_finished_displaying():
	print("finished displaying text")
	DialogueController.can_advance_line_signal.emit(true)

func cutscene_close_dialogue():
	text_box.queue_free()
	reset_vars()

func reset_vars():
	text_box = null
