class_name SayOnce_Condition extends Condition

@export var _name: String
@export var _value: bool


func check() -> bool:
	if !Global.switch.has(_name):
		Global.switch[_name] = true
	if Global.get_switch(_name) == _value:
		print("switch ",_name, " :" ,Global.switch[_name])
		
		return true
	else:
		Global.switch[_name] = true
		return false
