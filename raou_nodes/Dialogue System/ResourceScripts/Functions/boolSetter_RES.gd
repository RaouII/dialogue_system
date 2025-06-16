class_name BoolSetter extends VariableSetter

@export var _value: bool

func run():
	Global.set_switch(_name,_value)
