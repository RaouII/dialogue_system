class_name FloatSetter extends VariableSetter

@export var _value: float

func run():
	Global.set_variable(_name,_value)
