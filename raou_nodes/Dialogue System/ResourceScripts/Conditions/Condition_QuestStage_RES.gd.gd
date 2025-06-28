class_name EventStageCondition extends Condition

@export var event: Event
@export var eventStage: EventStage

func check():
	if event.current_stage == eventStage:
		return true
	return false
