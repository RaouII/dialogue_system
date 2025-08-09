class_name StageBetweenCondition extends Condition

@export var event1: Event
@export var eventStage1: EventStageList

@export var event2: Event
@export var eventStage2: EventStageList


func check():
	if eventStage1 == null:
		eventStage1 = EventStageList.new()
	if eventStage2 == null:
		eventStage2 = EventStageList.new()
	if event1.stages[eventStage1.selected_index].completed == true:
		if event2.stages[eventStage2.selected_index].completed == false:
			return true
	return false
