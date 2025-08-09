class_name CharacterID extends Resource

### This stores any character-exclusive data. 
### It can be the portrait that will be displayed in the textbox
### Or maybe each character has a unique text-box color, like in the game Silver(1999)
### Whatever you put here is up to you

@export var name: String
@export var portrait: Texture2D
@export var color: Color
