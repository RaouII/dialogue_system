extends Camera2D

@export var character : CharacterBody2D 

func _process(delta):
	global_position = character.global_position
