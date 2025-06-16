class_name AdvanceStageOnSceneLoad extends Node

@export var event: Event
@export var required_stage: EventStage
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var size = event.stages.size()-1
	if required_stage != null:
		if event.current_stage == required_stage:
			if event.current_index < size:
				print_rich("[color=yellow]Set New Stage")
				event.advanceStage()
				return
	else:
		if event.current_index < size:
			print_rich("[color=yellow]Set New Stage. No stage waas required for the change")
			event.advanceStage()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
