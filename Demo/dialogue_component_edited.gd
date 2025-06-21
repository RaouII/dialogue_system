extends DialogueComponent

### This is an edited version of the Dialogue Component
### I created it specifically for this demo to handle the interaction between player and NPCs
### Your project will probably handle interactions differently
### in that case, you can ignore this and just call the _start() function through there



@export var range: float = 25
func _process(delta):
	var dis = get_parent().global_position.distance_to(Global.player.global_position)
	if dis < range and Input.is_action_just_pressed("interact"):
		_start()
