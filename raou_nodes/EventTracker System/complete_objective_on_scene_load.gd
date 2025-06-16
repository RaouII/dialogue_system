class_name CompleteObjectiveOnSceneLoad extends Node

@export var event: Event
@export var required_stage: EventStage
@export var stage_objective: EventObjective
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if event.current_stage == required_stage:
		var objective = event.current_stage._objectives.find(stage_objective)
		event.current_stage._objectives[objective].completed = true
		for i in event.current_stage._objectives.size():
			if event.current_stage._objectives[i].completed == false:
				return
		
		event.advanceStage()
	else:
		queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
