@icon("res://Quest System/ICO_Quest.png")
class_name Event extends Resource

@export var name: StringName
@export var current_stage: EventStage
@export var current_index: int
@export var stages: Array[EventStage]



func resetQuest():
	setQuestStageIndex(0)

func setQuestStageIndex(_index: int):
	current_stage = stages[_index]
	current_index = _index
	
func setQuestStage(_stage: EventStage):
	if stages.has(_stage):
		current_stage = _stage
		current_index = stages.find(_stage)
	else:
		printerr("Tried to set '%s' stage to a Event that doesnt have it in its stages list" % [_stage])

func advanceStage():
	if current_stage == null:
		setQuestStageIndex(0)
	else:
		if current_index != stages.size()-1:
			current_index = current_index+1
			current_stage = stages[current_index]
			print_rich("[color=yellow]Advance Event Stage to '%s'" % [current_stage.resource_name])
		else:
			print_rich("[color=red]Event already completed!")
