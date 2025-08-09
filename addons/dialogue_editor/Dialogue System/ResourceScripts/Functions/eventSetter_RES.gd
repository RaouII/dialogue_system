class_name SetEventStage extends VariableSetter

@export var _event: Event
@export var _stage: EventStageList

func run():
	if _stage == null:
		_stage = EventStageList.new()
		_stage.selected_index = 0
	_event.setQuestStageIndex(_stage.selected_index)
	pass
