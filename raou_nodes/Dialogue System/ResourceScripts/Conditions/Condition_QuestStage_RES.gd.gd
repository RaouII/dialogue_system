class_name EventStage_C extends Condition

@export var event: Event
@export var eventStage: EventStage

func check():
	if event.current_stage == eventStage:
		return true
	return false
