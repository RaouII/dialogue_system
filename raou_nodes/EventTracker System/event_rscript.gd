class_name Event extends Resource

@export var name: StringName
@export var current_stage: EventStageList
var current_index: int
@export var stages: Array[EventStage]



func resetQuest():
	setQuestStageIndex(0)

func setQuestStageIndex(_index: int):
	if current_stage == null:
		current_stage = EventStageList.new()
	current_stage.selected_index = _index
	current_index = _index


func setQuestStage(_stage: EventStage):
	if stages.has(_stage):
		current_stage.selected_index = stages.find(_stage)
		current_index = stages.find(_stage)
	else:
		printerr("Tried to set '%s' stage to a Event that doesnt have it in its stages list" % [_stage])

func advanceStage(_completed: bool):
	if current_stage == null:
		setQuestStageIndex(0)
	else:
		if current_index != stages.size()-1:
			current_index = current_index+1
			current_stage.completed = _completed
			current_stage.selected_index = current_index
		#	current_stage = stages[current_index]
			print_rich("[color=yellow]Advance Event Stage to '%s'" % [current_stage.resource_name])
		else:
			print_rich("[color=red]Event already completed!")
