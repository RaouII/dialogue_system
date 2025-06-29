extends Node
class_name Main

@export var world_2d : Node2D
@export var first_scene: String
var current_2d_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.main = self
	change_2d_scene(first_scene)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_new_scene(new_scene: String, portal_id: int, delete: bool = true, keep_running: bool = false):
	if current_2d_scene != null:
		if delete:
			current_2d_scene.queue_free()
		elif keep_running:
			current_2d_scene.visible = false
		else:
			pass
	var new: Level = load(new_scene).instantiate()
	world_2d.add_child(new)
	current_2d_scene = new
	Global.player.global_position = new.portals[portal_id].spawnPoint.global_position
	pass
	
	
func change_2d_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_2d_scene != null:
		if delete:
			current_2d_scene.queue_free()
		elif keep_running:
			current_2d_scene.visible = false
		else:
			pass
	var new = load(new_scene).instantiate()
	world_2d.add_child(new)
	current_2d_scene = new
