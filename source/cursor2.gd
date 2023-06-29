extends Sprite2D

# Object Array
var characters = []          # Array to store all the characters the player can select

# Integer
var currentSelected = 0      # Spot of the cursor within the characters[]

# Exports 
@export var cursorTexture : Texture2D    # Cursor Texture2D for when Player 1 is making a decision    
@export var selectedTexture : Texture2D    # Cursor Texture2D for when Player 1 is making a decision    
@export var amountOfColumns : int = 4      # The total amount of rows the character select is able to show 
@export var portraitOffset : Vector2 = Vector2(256,256)    # The distance between the portraits

# Objects
@onready var gridContainer = get_parent().get_node("GridContainer")   # Get the Gridcontainer

func _ready():
# Get all of the characters stored within the group "Characters" and place them in the Array characters
	for nameOfCharacter in get_tree().get_nodes_in_group("Characters"):
		characters.append(nameOfCharacter)
#	print(characters)
	texture = cursorTexture

# This whole _process(delta) function is used to allow scrolling through all the characters
func _process(delta):
	if(Input.is_action_just_pressed("p2_right") and CharacterSelectionManager.chosenCharacters[1]==null and currentSelected<CharacterSelectionManager.charNum):
		currentSelected += 1
		position.x = 128 + portraitOffset.x*(currentSelected%amountOfColumns)
		position.y = 128 + portraitOffset.x*int(currentSelected/amountOfColumns)
	elif(Input.is_action_just_pressed("p2_left") and CharacterSelectionManager.chosenCharacters[1]==null and currentSelected>0):
		currentSelected -= 1
		position.x = 128 + portraitOffset.x*(currentSelected%amountOfColumns)
		position.y = 128 + portraitOffset.x*int(currentSelected/amountOfColumns)

# If a selection is made send it to the Signleton CharacterSelectionManager.gd to store that value
	if(Input.is_action_just_pressed("p2_a")):
		if(CharacterSelectionManager.chosenCharacters[1]==null):
			CharacterSelectionManager.pickCharacter(1,characters[currentSelected].name)
			texture = selectedTexture
		else:
			if(CharacterSelectionManager.chosenCharacters[0]!=null and CharacterSelectionManager.chosenCharacters[1]!=null):
				get_tree().change_scene_to_file("res://source/mainstage.tscn")
	if(Input.is_action_just_pressed("p2_b")):
		CharacterSelectionManager.chosenCharacters[1] = null
		texture = cursorTexture

