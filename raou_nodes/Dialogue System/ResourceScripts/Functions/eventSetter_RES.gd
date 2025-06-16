class_name EventSetStage extends VariableSetter

@export var _event: Event
@export var _stage: EventStage

func run():
	_event.setQuestStage(_stage)
