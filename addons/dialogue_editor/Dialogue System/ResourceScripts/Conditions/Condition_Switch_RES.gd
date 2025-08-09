class_name Switch_Condition extends Condition

@export var _name: String
@export var _value: bool

func check() -> bool:
	if !Global.switch.has(_name):
		print("Global.Switch doesnt have ", _name, ". Creating Variable")
		Global.switch[_name] = false
	if Global.get_switch(_name) == _value:
		print("switch ",_name, " :" ,Global.switch[_name])
		return true
	else:
		return false
