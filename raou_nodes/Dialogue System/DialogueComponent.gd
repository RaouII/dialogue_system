@icon("uid://wg1qboo21dbf")
class_name DialogueComponent extends Node
@export var _dialogueTree: DialogueTree
# Called when the node enters the scene tree for the first time.

func _start():
	Dialogue.start_dialogue(get_parent().global_position, _dialogueTree)
	pass
