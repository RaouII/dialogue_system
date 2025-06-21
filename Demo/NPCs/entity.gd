class_name Entity extends Node




@export var characterID: CharacterID
@export var animationPlayer: AnimationPlayer

func _ready():
	Global.set_character_idle_animation.connect(_on_idle_animation)
	
func _on_idle_animation(_char: CharacterID,_anim: String):
	if _char == characterID and animationPlayer != null:
		if _anim:
			animationPlayer.play(_anim)
