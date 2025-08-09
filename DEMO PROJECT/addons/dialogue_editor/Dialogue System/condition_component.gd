class_name ConditionComponent extends Node

@export var _conditions: Array[Condition]

func _ready():
	if _conditions.size() > 0:
		for condition in _conditions:
			if !condition.check():
				get_parent().queue_free()
