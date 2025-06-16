class_name SetStageOnSceneLoad extends Node

@export var event: Event
@export var stage: EventStage
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if event.current_stage != stage:
		event.setQuestStage(stage)
