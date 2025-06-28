class_name Switch_Condition extends Condition

@export var _name: String
@export var _value: bool

func check() -> bool:
	if Global.get_switch(_name) == _value:
		return true
	else:
		return false
