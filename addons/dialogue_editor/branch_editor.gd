@tool
extends Control

@onready var branch_name = $PanelContainer/VBoxContainer/HBoxContainer2/BranchName
@onready var warning_dialog = $WarningDialog
@onready var file_dialog = $FileDialog
@onready var graph_edit: GraphEdit = $GraphEdit
const TOPIC_GRAPH_NODE = preload("uid://jsd763hsqsc6")
const STARTING_TOPIC_GN = preload("uid://bryusw2h5ihym")
const RESPONSE_GN = preload("uid://bb7hdwu515h3r")
var init_pos = Vector2(100,100)
var node_index = 0
var starting_topics:= []
var nodes:= []
var rows = 0
var current_branch_path: String
var topic_to_node = {}
var response_to_node = {}


func _add_topic_node() -> void:
	print_debug("adding new node")
	var node = TOPIC_GRAPH_NODE.instantiate()
	node.position_offset = init_pos + (node_index * Vector2(40, 40))
	graph_edit.add_child(node)
	nodes.append(node)
	node_index += 1
	
func _add_response_node() -> void:
	print_debug("adding new node")
	var node = RESPONSE_GN.instantiate()
	node.position_offset = init_pos + (node_index * Vector2(40, 40))
	graph_edit.add_child(node)
	nodes.append(node)
	node_index += 1

func _add_starting_topic_node():
	var node = STARTING_TOPIC_GN.instantiate()
	node.position_offset = init_pos + (node_index * Vector2(40, 40))
	graph_edit.add_child(node)
	print(node.topic_prompt)
	starting_topics.append(node)
	node_index += 1
	return(node)

func _on_button_pressed() -> void:
	print_debug("pressing button new node")
	call_deferred("_add_topic_node")



	
func create_new_branch(_response: ResponseGraphNode,_topic: DialogueTopic) -> DialogueBranch:
	var new_branch := DialogueBranch.new()
	new_branch._topics.clear()
	var connected:= []
	var connection_list = graph_edit.get_connection_list()
	for connections in connection_list:
		if connections.from_node == _response.name:
			for node in nodes:
				if node.name == connections.to_node:
					if node is TopicGraphNode:
						print("here?")
						connected.append(node)
	for connections in connected:
		new_branch._topics.append(create_topic_resource(connections))
	print(connected)
	return(new_branch)

	
	
func _on_save_branch_button_up():
	if starting_topics.is_empty():
		warning_dialog.visible = true
	else:
		file_dialog.visible = true



func _on_button_2_button_up():
	call_deferred("_add_starting_topic_node")
	
	print_debug("add new starting topic")
	pass # Replace with function body.


func reconnect_loaded_nodes():
	for key:DialogueTopic in topic_to_node:
		for response in key._responses:
			var current_pos: int = key._responses.find(response)
			var last_pos: int = key._responses.size()-1
			if current_pos == 0:
				graph_edit.connect_node(topic_to_node[key], 0, response_to_node[response], 0)
			else:
				if current_pos <= last_pos:
					graph_edit.connect_node(response_to_node[key._responses[current_pos-1]], 0, response_to_node[response], 0)
			print("last response = ", key._responses[last_pos])
			print("current response = ", response)
			if response == key._responses[last_pos]:
				print("last response")
				if key._nextBranch:
					print("Next Branch Topics: ",key._nextBranch)
					for topic:DialogueTopic in key._nextBranch._topics:
						print("topic: ", topic)
						graph_edit.connect_node(response_to_node[response], 0, topic_to_node[topic], 0)
						pass
		
		pass
	
func _on_file_dialog_file_selected(path):  ### SAVE FILE DIALOG
	current_branch_path = path
	branch_name.text = path.get_file()
	var new_branch := DialogueBranch.new()
	new_branch._topics.clear()
	#new_branch.take_over_path(path)
	var connection_list = graph_edit.get_connection_list()
	for connections in connection_list:
		for topic in starting_topics:
			if topic != null:
				if connections.from_node == topic.name:
					for node in nodes:
						if node.name == connections.to_node:
							if node is ResponseGraphNode:
								new_branch._topics.append(create_topic_resource(topic))
			
	ResourceSaver.save(new_branch,path)
	ResourceLoader.load(path, "", ResourceLoader.CACHE_MODE_REPLACE)
	print_debug("save branch")
	file_dialog.visible = false


func create_topic_resource(_node: TopicGraphNode) -> DialogueTopic:
	var new_topic := DialogueTopic.new()
	new_topic._topicText = _node.topic_prompt.text
	new_topic._goodbye = _node.goodbye.button_pressed
	new_topic._random = _node.random.button_pressed
	for condition:ConditionContainer in _node.condition_list:
		new_topic._conditions.append(condition.current_resource)
	for function:FunctionContainer in _node.function_list:
		new_topic._functions.append(function.current_resource)
	
	var response_chain := get_response_chain_from_topic(_node,new_topic)
	for response in response_chain:
		var current_pos: int = response_chain.find(response)
		var last_pos: int = response_chain.size()-1
		var new_response := DialogueResponse.new()
		new_response._responseText = response.topic_prompt.text
		new_response.character_id = response.characterID
		new_response._idleAnimation = response.animation
		new_topic._responses.append(new_response)

			
	return(new_topic)

func get_response_chain_from_topic(_topic: TopicGraphNode, topic: DialogueTopic) ->Array:
	var chain:= []
	var current_node = _topic
	while current_node:
		var next_node: GraphNode = null
		var connection_list = graph_edit.get_connection_list()
		for connections in connection_list:
			if connections.from_node == current_node.name:
				print("current node: ",connections.from_node)
				for node in nodes:
					if node.name == connections.to_node:
						print("connected node: ",connections.to_node)
						if node is ResponseGraphNode:
							print("found response graph node connection")
							var target = node
							if target and target not in chain:
								next_node = target
								chain.append(next_node)
						elif node is TopicGraphNode:
							print("found topic graph node connection")
							topic._nextBranch = create_new_branch(current_node,topic)
							return(chain)
		current_node = next_node
	
	return(chain)





func _on_button_3_button_up():
	call_deferred("_add_response_node")
	pass # Replace with function body.



func _on_graph_edit_connection_request(from_node, from_port, to_node, to_port):
	$GraphEdit.connect_node(from_node,from_port,to_node,to_port)
	pass # Replace with function body.


func _on_graph_edit_disconnection_request(from_node, from_port, to_node, to_port):
	$GraphEdit.disconnect_node(from_node,from_port,to_node,to_port)
	pass # Replace with function body.


func _on_graph_edit_connection_drag_started(from_node, from_port, is_output):
	$GraphEdit.connection_drag_started(from_node,from_port,is_output)
	pass # Replace with function body.


func _on_load_branch_button_up():
	$"PanelContainer/VBoxContainer/HBoxContainer/Load Branch/LoadFileDialog".visible = true
	pass # Replace with function body.

func _create_response_node_from_file(_init_pos, _index):
	print_debug("adding new node. rows:", rows)
	var node = RESPONSE_GN.instantiate()
	var padding = 50
	var width = node.size.x+padding
	var height = node.size.y+padding
	var y_offset = height*rows
	node.position_offset = _init_pos + Vector2(0,y_offset) + (_index * Vector2(width,0)) 
	graph_edit.add_child(node)
	nodes.append(node)
	node_index += 1
	return(node)

	
func _load_topic_node_from_file(_init_pos, _index,_startingTopic: bool):
	var node
	if _startingTopic:
		node = STARTING_TOPIC_GN.instantiate()
	else: 
		node = TOPIC_GRAPH_NODE.instantiate()
	var height = node.size.y+50
	var y_offset = height*rows
	node.position_offset = _init_pos + Vector2(0,y_offset)
	graph_edit.add_child(node)
	print(node.topic_prompt)
	if _startingTopic:
		starting_topics.append(node)
	else:
		nodes.append(node)
	node_index += 1
	return(node)

func _load_responses(topic:DialogueTopic, offset, parent_offset,parent):
	var _i = 0
	for response in topic._responses:
		var new_init_pos = init_pos+Vector2(parent_offset.x,0) + offset
		var response_node:ResponseGraphNode = _create_response_node_from_file(new_init_pos,_i)
		response_to_node[response] = response_node.name
		response_node.topic_prompt.text = response._responseText
		if _i == topic._responses.size()-1:
			if topic._nextBranch:
				print("adding topics")
				new_init_pos = response_node.position_offset + Vector2(response_node.size.x+50,0)
				load_topics(topic,response,offset, response_node.position_offset)
			return
			#response_node:ResponseGraphNode = _create_response_node_from_file(new_init_pos,ii)
			#response_node.topic_prompt.text = response._responseText
			#ii += 1
		_i += 1

func load_topics(parent_topic: DialogueTopic, response: DialogueResponse,offset, parent_offset):
	var _i = 0
	for topic in parent_topic._nextBranch._topics:
		var new_init_pos = init_pos+Vector2(parent_offset.x,0) + offset
		var new_topic: TopicGraphNode =  _load_topic_node_from_file(new_init_pos, _i,false)
		topic_to_node[topic] = new_topic.name
		new_topic.topic_prompt.text = topic._topicText
		new_topic.goodbye.set_pressed_no_signal(topic._goodbye)
		new_topic.random.set_pressed_no_signal(topic._random)
		for condition : Condition in topic._conditions:
			new_topic._on_add_condition_pressed()
			new_topic.condition_container.current_resource = condition
			new_topic.condition_container.condition_picker.edited_resource = condition
			new_topic.condition_container.resource_editor.edit(condition)
		for function : Function in topic._functions:
			new_topic._on_add_function_pressed()
			new_topic.function_container.current_resource = function
			new_topic.function_container.function_picker.edited_resource = function
			new_topic.function_container.resource_editor.edit(function)
		var ii = 0
		_load_responses(topic,offset, new_topic.position_offset, new_topic)
		rows +=1
		print(rows)


func load_starting_topics(path):
	topic_to_node = {}
	response_to_node = {}
	rows = 1
	var branch_data: DialogueBranch = load(path)
	branch_name.text = path.get_file()
	var i = 0
	for topic in branch_data._topics:
		var new_topic: TopicGraphNode =  _load_topic_node_from_file(init_pos, i,true)
		topic_to_node[topic] = new_topic.name
		new_topic.topic_prompt.text = topic._topicText
		new_topic.goodbye.set_pressed_no_signal(topic._goodbye)
		new_topic.random.set_pressed_no_signal(topic._random)
		for condition : Condition in topic._conditions:
			new_topic._on_add_condition_pressed()
			new_topic.condition_container.current_resource = condition
			new_topic.condition_container.condition_picker.edited_resource = condition
			new_topic.condition_container.resource_editor.edit(condition)
		for function : Function in topic._functions:
			new_topic._on_add_function_pressed()
			new_topic.function_container.current_resource = function
			new_topic.function_container.function_picker.edited_resource = function
			new_topic.function_container.resource_editor.edit(function)
		var ii = 0
		var offset = Vector2(new_topic.size.x+50,0)
		_load_responses(topic,offset,new_topic.position_offset,new_topic)
		i+=1
		rows +=1
		print(rows)
		#new_topic.set_position(init_pos + starting_topics.size()*new_topic.size.y)
	for topics in starting_topics:
		print(topics.goodbye.toggle_mode)
	reconnect_loaded_nodes()


func _on_load_file_dialog_file_selected(path):
	current_branch_path = path
	node_index = 0
	starting_topics.clear()
	nodes.clear()
	for child in graph_edit.get_children():
		if child is GraphNode:
			child.queue_free()
	pass # Replace with function body.
	$"PanelContainer/VBoxContainer/HBoxContainer/Load Branch/LoadFileDialog".visible = false
	load_starting_topics(path)
	pass # Replace with function body.




func _on_clear_graph_button_up():
	node_index = 0
	starting_topics.clear()
	nodes.clear()
	for child in graph_edit.get_children():
		if child is GraphNode:
			child.queue_free()
	pass # Replace with function body.


func _on_warning_dialog_confirmed():
	warning_dialog.visible = false
	pass # Replace with function body.


func _on_reload_branch_pressed():
	if current_branch_path:
		_on_load_file_dialog_file_selected(current_branch_path)
	pass # Replace with function body.


func _on_save_as_topic_pressed():
	pass # Replace with function body.
