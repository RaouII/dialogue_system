extends DialogueComponent

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		_start()
