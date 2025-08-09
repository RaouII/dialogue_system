class_name RunFunctionOnTeleport extends Node

@onready var parent: Teleport = $".."
@export var function: Function
@export var conditions: Array[Condition]
func _ready():
	parent.teleport_triggered.connect(on_teleport_trigger)
	
func on_teleport_trigger():
	if Global.check_all_conditions(conditions):
		function.run()
