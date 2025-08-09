extends AudioStreamPlayer

const DOOR_OPEN_2 = preload("uid://cv6yju58nvwt8")
const CLOTH_4 = preload("uid://beto422ut85m2")

func _ready():
	Global.door_sfx.connect(_on_door_sfx)
	
func _on_door_sfx(type: int):
	match type:
		0: 
			stream = DOOR_OPEN_2
			pitch_scale = 1
			play()
			pass
		1:
			stream = CLOTH_4
			#aapitch_scale = 0.6
			play()
			pass
			
