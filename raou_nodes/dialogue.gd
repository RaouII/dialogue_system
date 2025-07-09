extends Node

const textbox_prefab = preload("uid://ciworq5pvrgnj")
const RESPONSE_CONTAINER = preload("uid://8v136rihlugn")
const TOPIC_CONTAINER = preload("uid://diejsi3sdvvcw")
const CHOICE_BUTTON = preload("uid://dbxh37k37eypu")

var dialogue_lines: Array[DialogueResponse] = []
var current_line_index = 0

var current_branch: DialogueBranch
var current_topic: DialogueTopic
var current_greeting: DialogueTopic

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



func choose_greeting(greeting: DialogueBranch):
	var best_pick: DialogueTopic # This variable is used to store the highest priority greeting topic
	var available_greetings: Array[DialogueTopic] # This holds all greeting topics that met their conditions
	var best_pick_array: Array[DialogueTopic] # If the greetings are randomized, this will hold the ones with the highest priority
	
	for topic in greeting._topics:
		print("There are topics in the Greeting Branch")
		if topic._conditions.is_empty():
			print("Topic", topic._topicText," Conditions is empty")
			available_greetings.append(topic)
		else:
			print("Topic", topic._topicText," Conditions is not empty")
			var last_entry = topic._conditions.size()-1
			var check = false
			for condition in topic._conditions:
				print("loop start")
				if condition.check() != true:
					print("Conditions from ", topic._topicText, " wasnt met")
					push_warning("Topic skipped: conditions not met")
					print("loop break")
					break
				print("loop continue")
				check = true
				print("Conditions from ", topic._topicText, " was met")
				print(topic._responses[0]._responseText)
				current_greeting = topic
				if condition == topic._conditions[last_entry]:
					print("Show Responses")
					available_greetings.append(topic)
	for i in available_greetings:
		if !best_pick:
			best_pick = i # If "best pick" wasnt set yet, i.e. this is the first loop, set it to [i]
			best_pick_array.append(best_pick) # append to the array to be used with the "random" flag
		elif best_pick._priority < i._priority:
				best_pick = i # if the current [i] has higher priority than the current best_pick, set best_pick to [i]
		elif best_pick._priority == i._priority:
				best_pick_array.append(i) # if [i] has the same priority as the current best_pick, add them to the array
	if greeting._random:
		var picked = randi_range(0,best_pick_array.size()-1)
		best_pick = best_pick_array[picked] # if the "random" flag is on, this will choose one of the entries here at random. Otherwise, it'll keep the first pick. Theres probably room for improving this code, maybe checking this *before* looping through all of the entries, but I'll do that later if I feel like it.
	show_responses(best_pick)

			
#### SECOND STEP:	SHOW THE FIRST DIALOGUE WINDOW, IT'LL SHOW:
#################	1) A GREETING TEXT,
#################	2) A LIST OF AVAILABLE TOPICS TO TALK ABOUT,
#################	3) BOTH
func show_greeting():
	print("show greeting")
	choose_greeting(current_tree._greeting)
	#if current_tree._greeting != null: ## this will check if there is a greeting text set
		
		#var _greeting = current_tree._greeting
		#init_responseContainer() ### IF THERE IS A GREETING TO BE DISPLAYED, INSTANTIATE THE TEXT COMPONENT OF THE DIALOGUE BOX
		#text_box.display_text(_greeting._responseText) #### THIS FUNCTION WILL DISPLAY THE TEXT ON THE DIALOGUE BOX
		#Global.set_character_idle_animation.emit(_greeting.character_id, _greeting._idleAnimation)

	#if current_greeting._nextBranch == null:
		#if current_tree._branches != null: ## this will check if there are branches set
			#display_maintree_topics()
		##text_box.position = text_box_position
		#can_advance_line = false

func display_maintree_topics():
	for branch in current_tree._branches:
		print("Display MainTree Topics")
		for topic in branch._topics: 
			### IF THERE ARE TOPICS TO BE DISPLAYED, INSTANTIATE THE TOPIC COMPONENT OF THE DIALOGUE BOX
			display_topic(topic) 



#### THIRD STEP:	HANDLES EVERY TEXT MESSAGE AFTER THE INITIAL GREETING 
func show_responses(_topic: DialogueTopic):
	if _topic._responses.is_empty(): ### IF THERE ARE NO DIALOGUE RESPONSES IN THE CURRENT TOPIC, CLOSE IT
		close_dialogue()
		return
	
	current_topic = _topic	
	instantiate_text_box()
	init_responseContainer()
	#text_box.global_position = text_box_position
	
	var _responses = _topic._responses
	if _topic._random:
		var i = randi_range(0, _responses.size()-1)
		var _response = _responses[i]
		#print(i)
		text_box.display_text(_response._responseText)
		Global.set_character_idle_animation.emit(_response.character_id, _response._idleAnimation)
		
		if current_topic._nextBranch != null:
			for topic in current_topic._nextBranch._topics:
				display_topic(topic)
				current_line_index = 0
		can_advance_line = false
		return

	if _responses[current_line_index] != null:
		var _response = _responses[current_line_index]
		text_box.display_text(_response._responseText)
		Global.set_character_idle_animation.emit(_response.character_id, _response._idleAnimation)
	else:
		push_error("No response found at current_line_index")

	if current_line_index == _responses.size()-1 and current_topic._nextBranch != null:
		for topic in current_topic._nextBranch._topics:
			display_topic(topic)
			current_line_index = 0
			
	if current_line_index == _responses.size()-1 and current_topic == current_greeting and current_greeting._exclusive == false:
		display_maintree_topics()
		current_line_index = 0
	can_advance_line = false
	for f in current_topic._functions:
		f.run() ## Runs the function if there is one

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
		print(condition)
		if condition.check() != true:
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
	print("Dialogue advanced")
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
	print("finished displaying text")
	can_advance_line = true

func cutscene_close_dialogue():
	text_box.queue_free()
	reset_vars()
	
func close_dialogue():
	Global.closed_dialogue.emit()
	if text_box:
		text_box.queue_free()
	reset_vars()
	
func reset_vars():
	text_box = null
	is_dialogue_active = false
	current_line_index = 0
	current_topic = null
	current_branch = null
	current_tree = null
