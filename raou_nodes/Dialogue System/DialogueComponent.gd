@icon("uid://wg1qboo21dbf")
class_name DialogueComponent extends Node
@export var _dialogueTree: DialogueTree
# Called when the node enters the scene tree for the first time.

func _start():
	var v2 = Vector2.ZERO ## This isn't currently being used in this script so I just set it to VectorZERO for now
	Dialogue.start_dialogue(v2, _dialogueTree)
	pass
