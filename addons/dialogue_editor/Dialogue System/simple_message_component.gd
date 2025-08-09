@icon("uid://c688tq47vlke4")
class_name SimpleMessageComponent extends Node
@export var _responses: Array[DialogueResponse]
@export var _functions: Array[Function]
# Called when the node enters the scene tree for the first time.


@export var range: float = 25
func _process(delta):
	var dis = get_parent().global_position.distance_to(Global.player.global_position)
	if dis < range and Input.is_action_just_pressed("interact"):
		_start()



func _start():
	var _tree = DialogueTree.new()
	var _branch = DialogueSegment.new()
	var _topic = DialogueTopic.new()
	_topic._responses = _responses
	_topic._functions = _functions
	_topic._goodbye = true
	_topic._exclusive = true
	_tree._greeting = _branch
	_tree._greeting._topics.append(_topic)
	var v2 = Vector2.ZERO ## This isn't currently being used in this script so I just set it to VectorZERO for now
	Dialogue.start_dialogue(v2, _tree)
	pass
