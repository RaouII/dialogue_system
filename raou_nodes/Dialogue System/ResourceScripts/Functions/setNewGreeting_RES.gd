class_name SetNewGreeting extends Function

@export var new_greeting: DialogueTopic

func run():
	
	print(Dialogue.current_tree._greeting)
	Dialogue.current_tree._greeting = new_greeting
	print(Dialogue.current_tree)
	print(Dialogue.current_tree._greeting)
	
