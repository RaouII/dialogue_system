class_name Level extends Node2D


@export var portals: Array[Teleport]
#@export var markerData: Node2D
#var characters: Array[CharacterID]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.level = self
	#Global.add_character_to_level_array.connect(_on_add_character_to_level_array)
	pass # Replace with function body.
	
	
#func _on_add_character_to_level_array(_char: CharacterID):
	#characters.append(_char)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
