extends Node

const textbox_prefab = preload("uid://ciworq5pvrgnj")
const RESPONSE_CONTAINER = preload("uid://8v136rihlugn")
const TOPIC_CONTAINER = preload("uid://diejsi3sdvvcw")
const CHOICE_BUTTON = preload("uid://dbxh37k37eypu")

var dialogue_lines: Array[DialogueResponse] = []
var current_line_index = 0

var current_branch: DialogueBranch
var current_topic: DialogueTopic

var text_box
var text_box_position: Vector2
var current_tree: DialogueTree

var is_dialogue_active = false
var can_advance_line = false



#### FIRST STEP: START THE DIALOGUE
func start_dialogue(position: Vector2, _tree: DialogueTree):
	if is_dialogue_active:
		return
	Global.started_dialogue.emit()
	current_tree = _tree
	text_box_position = position
	print(position)
	show_greeting() ### THIS FUNCTION WILL CALL THE FIRST DIALOGUE WINDOW
	is_dialogue_active = true

#### SECOND STEP:	SHOW THE FIRST DIALOGUE WINDOW, IT'LL SHOW:
#################	1) A GREETING TEXT,
#################	2) A LIST OF AVAILABLE TOPICS TO TALK ABOUT,
#################	3) BOTH
func show_greeting():
	instantiate_text_box()
	if current_tree._greeting != null: ## this will check if there is a greeting text set
		var _greeting = current_tree._greeting
		init_responseContainer() ### IF THERE IS A GREETING TO BE DISPLAYED, INSTANTIATE THE TEXT COMPONENT OF THE DIALOGUE BOX
		text_box.display_text(_greeting._responseText) #### THIS FUNCTION WILL DISPLAY THE TEXT ON THE DIALOGUE BOX
		Global.set_character_idle_animation.emit(_greeting.character_id, _greeting._idleAnimation,_greeting._emotionType)
	
	if current_tree._branches != null: ## this will check if there are branches set
		for branch in current_tree._branches:
			for topic in branch._topics: 
				### IF THERE ARE TOPICS TO BE DISPLAYED, INSTANTIATE THE TOPIC COMPONENT OF THE DIALOGUE BOX
				display_topic(topic) 
	#text_box.position = text_box_position
	can_advance_line = false

func display_greeting_topics():
	for i in current_tree._branches:
		for ii in i._topics: 
			### IF THERE ARE TOPICS TO BE DISPLAYED, INSTANTIATE THE TOPIC COMPONENT OF THE DIALOGUE BOX
			display_topic(ii) 


#### THIRD STEP:	HANDLES EVERY TEXT MESSAGE AFTER THE INITIAL GREETING 
func show_responses(_topic: DialogueTopic):
	if _topic._responses.is_empty():
		close_dialogue()
		return
	current_topic = _topic
	for f in current_topic._functions:
		f.run() ## Runs the function if there is one
	
	instantiate_text_box()
	init_responseContainer()
	#text_box.global_position = text_box_position
	
	var _responses = _topic._responses
	if _topic._random:
		var i = randi_range(0, _responses.size()-1)
		var _response = _responses[i]
		#print(i)
		text_box.display_text(_response._responseText)
		Global.set_character_idle_animation.emit(_response.character_id, _response._idleAnimation,_response._emotionType)
		
		if current_topic._nextBranch != null:
			for topic in current_topic._nextBranch._topics:
				display_topic(topic)
				current_line_index = 0
		can_advance_line = false
		return

	if _responses[current_line_index] != null:
		var _response = _responses[current_line_index]
		text_box.display_text(_response._responseText)
		Global.set_character_idle_animation.emit(_response.character_id, _response._idleAnimation,_response._emotionType)
	else:
		push_error("No response found at current_line_index")

	if current_line_index == _responses.size()-1 and current_topic._nextBranch != null:
		for topic in current_topic._nextBranch._topics:
			display_topic(topic)
			current_line_index = 0
	can_advance_line = false

func create_topic(topic: DialogueTopic):
	if text_box.choice_container == null:
		init_topicContainer()
	var choice = CHOICE_BUTTON.instantiate()
	choice.text = topic._topicText
	choice._dialogueTopic = topic
	text_box.choice_container.v_box_container.add_child(choice)

func display_topic(topic: DialogueTopic):
	if text_box == null:
		return
	if topic._conditions.is_empty():
		create_topic(topic)
		return
	for condition in topic._conditions:
		if topic._conditions[condition].check() != true:
			push_warning("Topic skipped: conditions not met")
			return
	create_topic(topic)


func init_topicContainer():
	if text_box.choice_container == null:
		text_box.choice_container = TOPIC_CONTAINER.instantiate()
		text_box.container.add_child(text_box.choice_container)
		
func init_responseContainer():
	if text_box.response_container == null:
		text_box.response_container = RESPONSE_CONTAINER.instantiate()
		text_box.container.add_child(text_box.response_container)
		#text_box.label = text_box.response_container.label

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



func _unhandled_input(event):
	if !is_dialogue_active:
		return
	if event.is_action_pressed("escape"):
		close_dialogue()
		return
	if 	event.is_action_pressed("mouse_left") && can_advance_line && text_box.choice_container == null:
		advance_dialogue()
		

func advance_dialogue():
	text_box.queue_free()
	current_line_index += 1

	if current_topic != null and !current_topic._random:
		if current_line_index >= current_topic._responses.size():
			if current_topic._goodbye:
				close_dialogue()
			else:
				current_line_index = 0
				show_greeting()
		else:
			show_responses(current_topic)
	else:
		close_dialogue()


func _on_text_box_finished_displaying():
	can_advance_line = true

func cutscene_close_dialogue():
	text_box.queue_free()
	reset_vars()
	
func close_dialogue():
	Global.closed_dialogue.emit()
	text_box.queue_free()
	reset_vars()
	
func reset_vars():
	text_box = null
	is_dialogue_active = false
	current_line_index = 0
	current_topic = null
	current_branch = null
	current_tree = null
