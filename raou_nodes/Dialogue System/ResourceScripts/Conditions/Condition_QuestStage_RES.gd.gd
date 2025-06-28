class_name EventStageCondition extends Condition

@export var event: Event
@export var eventStage: EventStageList


func check():
	if eventStage == null:
		eventStage = EventStageList.new()
	if event.current_index == eventStage.selected_index:
		return true
	return false
