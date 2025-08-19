class_name CutscenePlayer extends AnimationPlayer


var is_dialogue_active: bool = false
@export var scene: String = ""
@export var auto_play: bool = false
@export var auto_play_range: Area2D
@export var parallel_process: bool = false
@export var conditions: Array[Condition]
var finished: bool = false
const RESPONSE_CONTAINER = preload("uid://8v136rihlugn")

func _ready() -> void:
	if !Global.check_all_conditions(conditions):
		queue_free()
	connect("animation_finished",_on_animation_finished)
	if auto_play_range:
		auto_play_range.body_entered.connect(_on_body_entered)
	pass # Replace with function body.

func _on_body_entered(_body: Node2D):
	if !finished:
		if _body is CharacterBody2D:
			if auto_play:
				play(scene)
				finished = true
				if !parallel_process:
					Global.cutscene_started.emit()
	pass


#region ############ DIALOGUE FUNCTIONS ##################


func show_message(_message: DialogueResponse) -> void:
	DialogueUI.instantiate_text_box()
	DialogueUI.text_box_position.x = 1000
	DialogueUI.text_box_position.y = 600
	#Dialogue.text_box.global_position = pos
	DialogueUI.text_box.display_text(_message._responseText)
	DialogueController.set_character_idle_animation.emit(_message.character_id, _message._idleAnimation)
	is_dialogue_active = true
	pause()

func set_character_animation(_data: DialogueResponse) -> void:
		DialogueController.set_character_idle_animation.emit(_data.character_id, _data._idleAnimation)

func _unhandled_input(event):
	#print("dialogue unhandled input")
	if event.is_action_pressed("mouse_left") && is_dialogue_active:
		DialogueController.cutscene_close_dialogue()
		is_dialogue_active = false
		play()

#endregion

func run_function(_func: Function):
	_func.run()
	pass

func _on_animation_finished(anim_name: StringName) -> void:
	Global.cutscene_ended.emit()
	pass # Replace with function body.
