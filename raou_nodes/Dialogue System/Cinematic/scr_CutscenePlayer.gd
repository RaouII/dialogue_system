class_name CutscenePlayer extends AnimationPlayer

var is_dialogue_active: bool = false
const RESPONSE_CONTAINER = preload("uid://8v136rihlugn")

func _ready() -> void:
	connect("animation_finished",_on_animation_finished)
	pass # Replace with function body.

#region ############ DIALOGUE FUNCTIONS ##################


func show_message(_message: DialogueResponse, pos: Vector2 ) -> void:
	print("show_message")
	Dialogue.instantiate_text_box()
	Dialogue.init_responseContainer()
	Dialogue.text_box_position.x = 1000
	Dialogue.text_box_position.y = 600
	Dialogue.text_box.global_position = pos
	Dialogue.text_box.display_text(_message._responseText)
	Global.set_character_idle_animation.emit(_message.character_id, _message._idleAnimation)
	print("show_message_end")
	is_dialogue_active = true
	pause()

func set_character_animation(_data: DialogueResponse) -> void:
		Global.set_character_idle_animation.emit(_data.character_id, _data._idleAnimation)

func _unhandled_input(event):
	#print("dialogue unhandled input")
	if event.is_action_pressed("interact") && is_dialogue_active:
		Dialogue.cutscene_close_dialogue()
		is_dialogue_active = false
		play()

#endregion

func _on_animation_finished(anim_name: StringName) -> void:
	pass # Replace with function body.
