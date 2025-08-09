
class_name Teleport extends Area2D

signal teleport_triggered()
@export var scene: String
@export var destination_portal_id: int

@export var spawnPoint: Node2D
@export var id: int
@export_enum("Door", "Path") var type: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("body_entered",_on_body_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:

	pass # Replace with function body.


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		teleport_triggered.emit()
		Global.door_sfx.emit(type)
		Global.main.load_new_scene(scene, destination_portal_id)
		
		print("player entered")
	pass # Replace with function body.
