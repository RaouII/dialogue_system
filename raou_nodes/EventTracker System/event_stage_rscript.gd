class_name EventStage extends Resource

#@export var _index: int = 0
@export var _name: String = "New Event Stage"
@export var _designer_notes: String
@export var completed: bool
@export var _objectives: Array[EventObjective]


func is_objective_complete()-> bool:
	for i in _objectives:
		if _objectives[i].completed != true:
			return false
	return true
