class_name EventStageCondition extends Condition

@export var event: Event
@export var eventStage: EventStageList


func check():
	Global.create_event_info(event)
	if eventStage == null:
		eventStage = EventStageList.new()
	var _event: Event = Global.events[event]
	if _event.current_index >= eventStage.selected_index:
		return true
	return false
