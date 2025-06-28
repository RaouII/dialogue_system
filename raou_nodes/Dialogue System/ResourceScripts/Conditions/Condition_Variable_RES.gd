class_name Variable_Condition extends Condition

@export var _name: String
@export var _value: float
@export_enum("==","!=","<","<=",">=",">") var comparison: String = "=="

func check():
	var val = Global.get_variable(_name)
	if val is int:
		val = float(val)
	
	match comparison:
		"==":
			if val == _value:
				return true
		"!=":
			if val != _value:
				return true
		"<":
			if val < _value:
				return true
		"<=":
			if val <= _value:
				return true
		">=":
			if val >= _value:
				return true
		">":
			if val > _value:
				return true
	return false
