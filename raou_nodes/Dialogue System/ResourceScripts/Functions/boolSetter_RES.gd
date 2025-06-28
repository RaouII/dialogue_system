class_name SetBool extends VariableSetter

@export var _value: bool

func run():
	Global.set_switch(_name,_value)
