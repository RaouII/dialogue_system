@icon("uid://wg1qboo21dbf")
class_name DialogueComponent extends Node
@export var _dialogueTree: DialogueTree
# Called when the node enters the scene tree for the first time.


@export var range: float = 25
func _process(delta):
	### This is an edited version of the Dialogue Component
	### I created it specifically for this demo to handle the interaction between player and NPCs
	### Your project will probably handle interactions differently
	### in that case, you can delete the contents of this [_process()] and just call the [_start()] function
	var dis = get_parent().global_position.distance_to(Global.player.global_position)
	if dis < range and Input.is_action_just_pressed("interact"):
		_start()



func _start():
	var v2 = Vector2.ZERO ## This isn't currently being used in this script so I just set it to VectorZERO for now
	Dialogue.start_dialogue(v2, _dialogueTree)
	pass
