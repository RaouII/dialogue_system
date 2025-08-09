extends Node

signal started_dialogue() ## started dialogue signal: sends a signal saying a dialogue has started
signal closed_dialogue() ## close dialogue signal: sends a signal saying a dialogue has ended
signal cutscene_dialogue_closed()
signal set_character_idle_animation(_char: CharacterID,_anim: String) ## set idle animation signal: it sends a signal with a variety of useful information to animate characters during dialogue.
signal dialogue_active(_b: bool)
signal display_text(string: String)
signal advance_line()
signal show_topic(topic: DialogueTopic)
signal select_topic(topic: DialogueTopic)
signal can_advance_line_signal(bool)


var dialogue_lines: Array[DialogueResponse] = []
var current_line_index = 0

var current_branch: DialogueSegment
var current_topic: DialogueTopic
var current_greeting: DialogueTopic
var current_tree: DialogueTree

var is_dialogue_active = false
var can_advance_line = false
var option_available = false

func _ready():
	closed_dialogue.connect(reset_vars)
	show_topic.connect(_on_create_topic)
	select_topic.connect(_on_topic_selected)
	can_advance_line_signal.connect(_on_can_advance_line)

func _on_can_advance_line(_b: bool):
	can_advance_line = _b
func _on_topic_selected(_topic: DialogueTopic):
	if option_available == true:
		option_available = false
	show_responses(_topic)
	
func _on_create_topic(_topic: DialogueTopic):
	if !option_available:
		option_available = true

#### FIRST STEP: START THE DIALOGUE
func start_dialogue(_tree: DialogueTree):
	if is_dialogue_active:
		return
	started_dialogue.emit()
	current_tree = _tree
	choose_greeting(current_tree._greeting)
	#show_greeting() ### THIS FUNCTION WILL CALL THE FIRST DIALOGUE WINDOW
	is_dialogue_active = true



func choose_greeting(greeting: DialogueSegment):
	var best_pick: DialogueTopic # This variable is used to store the highest priority greeting topic
	var available_greetings: Array[DialogueTopic] = [] # This holds all greeting topics that met their conditions
	var best_pick_array: Array[DialogueTopic] = [] # If the greetings are randomized, this will hold the ones with the highest priority
	
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
	current_greeting = best_pick
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
		#Dialogue.set_character_idle_animation.emit(_greeting.character_id, _greeting._idleAnimation)

	#if current_greeting._nextBranch == null:
		#if current_tree._segments != null: ## this will check if there are branches set
			#display_maintree_topics()
		##text_box.position = text_box_position
		#can_advance_line = false

func display_maintree_topics():
	for segment in current_tree._segments:
		print("Display MainTree Topics")
		for topic in segment._topics: 
			### IF THERE ARE TOPICS TO BE DISPLAYED, INSTANTIATE THE TOPIC COMPONENT OF THE DIALOGUE BOX
			check_topic_availability(topic)



func show_responses(_topic: DialogueTopic):
	if _topic._responses.is_empty(): ### IF THERE ARE NO DIALOGUE RESPONSES IN THE CURRENT TOPIC, CLOSE IT
		close_dialogue()
		return
	
	current_topic = _topic
	
	var _responses = _topic._responses
	if _topic._random:
		var i = randi_range(0, _responses.size()-1)
		var _response = _responses[i]
		#print(i)
		display_text.emit(_response._responseText)
		DialogueController.set_character_idle_animation.emit(_response.character_id, _response._idleAnimation)
		
		if current_topic._nextBranch != null and !current_topic._nextBranch._topics.is_empty():
			for topic in current_topic._nextBranch._topics:
				check_topic_availability(topic)
				current_line_index = 0
		can_advance_line_signal.emit(false)
		return

	if _responses[current_line_index] != null:
		var _response = _responses[current_line_index]
		display_text.emit(_response._responseText)
		DialogueController.set_character_idle_animation.emit(_response.character_id, _response._idleAnimation)
	else:
		push_error("No response found at current_line_index")

	if current_line_index == _responses.size()-1 and current_topic._nextBranch != null and !current_topic._nextBranch._topics.is_empty():
		for topic in current_topic._nextBranch._topics:
			check_topic_availability(topic)
			current_line_index = 0
			
	if current_line_index == _responses.size()-1 and current_topic == current_greeting and current_greeting._exclusive == false:
		display_maintree_topics()
		current_line_index = 0
	can_advance_line_signal.emit(false)
	for f in current_topic._functions:
		f.run() ## Runs the function if there is one


func check_topic_availability(topic: DialogueTopic):
	print("TOPIC:::", topic)
	if topic == null:
		return
	if topic._conditions.is_empty():
		show_topic.emit(topic)
		return
	for condition in topic._conditions:
		print(condition)
		if condition.check() != true:
			push_warning("Topic skipped: conditions not met")
			return
	show_topic.emit(topic)



func _unhandled_input(event):
	if !is_dialogue_active:
		return
	if event.is_action_pressed("escape"):
		close_dialogue()
		return
	if 	event.is_action_pressed("mouse_left") && can_advance_line && option_available == false:
		advance_dialogue()
		

func advance_dialogue():
	print("Dialogue advanced")
	advance_line.emit()
	current_line_index += 1
	if current_topic != null and !current_topic._random:
		if current_line_index >= current_topic._responses.size():
			if current_topic._goodbye:
				close_dialogue()
			else:
				current_line_index = 0
				choose_greeting(current_tree._greeting)
		else:
			show_responses(current_topic)
	else:
		close_dialogue()


func cutscene_close_dialogue():
	cutscene_dialogue_closed.emit()
	reset_vars()
	
func close_dialogue():
	closed_dialogue.emit()
	reset_vars()
	
func reset_vars():
	is_dialogue_active = false
	current_line_index = 0
	current_topic = null
	current_branch = null
	current_tree = null
