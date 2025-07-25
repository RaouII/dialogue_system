class_name Player extends CharacterBody2D


@export var move_spd : float = 500
var character_direction : Vector2
@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
var lock_input: bool = false

func _ready():
	Global.player = self
	Global.cutscene_started.connect(_on_cutscene_started)
	Global.cutscene_ended.connect(_on_cutscene_ended)

func _on_cutscene_ended():
	lock_input = false
func _on_cutscene_started():
	animation_player.play("Idle")
	lock_input = true
func _physics_process(delta):
	if lock_input:
		return
	character_direction.x = Input.get_axis("move_left","move_right")
	character_direction.y = Input.get_axis("move_up","move_down")
	character_direction = character_direction.normalized()
	#flip
	if character_direction.x > 0: sprite.flip_h = false
	elif character_direction.x < 0: sprite.flip_h = true

	if character_direction:
		velocity = character_direction * move_spd
		if animation_player.current_animation != "Walk": animation_player.play("Walk")
	else:
		velocity = velocity.move_toward(Vector2.ZERO,move_spd)
		if animation_player.current_animation != "Idle": animation_player.play("Idle")

	move_and_slide()
