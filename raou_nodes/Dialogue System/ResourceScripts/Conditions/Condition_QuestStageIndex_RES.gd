class_name EventStageIndex_C extends Condition

@export var event: Event
@export var eventStage: int
@export_enum("==","!=","<","<=",">=",">") var comparison: String = "=="

func check():
	match comparison:
		"==":
			if event.current_index == eventStage:
				return true
		"!=":
			if event.current_index != eventStage:
				return true
		"<":
			if event.current_index < eventStage:
				return true
		"<=":
			if event.current_index <= eventStage:
				return true
		">=":
			if event.current_index >= eventStage:
				return true
		">":
			if event.current_index > eventStage:
				return true
	return false
