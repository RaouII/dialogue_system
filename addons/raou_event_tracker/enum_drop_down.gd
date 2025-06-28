@tool
extends OptionButton

var initialized = false

func feed_items(array):
	if !initialized:
		var _array:Array[String]
		_array.append_array(array)
		for i in _array:
			add_item(i)
	initialized = true
