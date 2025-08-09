@icon("uid://uhf41n34eehk")
class_name EntityComponent extends Node

@export var characterID: CharacterID
@export var animation_player: AnimationPlayer



func _ready() -> void:
	DialogueController.set_character_idle_animation.connect(_on_set_idle_animation)


func _on_set_idle_animation(_char: CharacterID,_anim: String) -> void:
	if _char == characterID:
		animation_player.play(_anim)
