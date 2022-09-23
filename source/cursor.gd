extends Sprite

# Object Array
var characters = []          # Array to store all the characters the player can select

# Integer
var currentSelected = 0      # Spot of the cursor within the characters[]

# Exports 
export (Texture) var cursorTexture    # Cursor Texture for when Player 1 is making a decision    
export (Texture) var selectedTexture    # Cursor Texture for when Player 1 is making a decision    
export (int) var amountOfColumns = 4      # The total amount of rows the character select is able to show 
export (Vector2) var portraitOffset = Vector2(256,256)    # The distance between the portraits

# Objects
onready var gridContainer = get_parent().get_node("GridContainer")   # Get the Gridcontainer

func _ready():
# Get all of the characters stored within the group "Characters" and place them in the Array characters
	for nameOfCharacter in get_tree().get_nodes_in_group("Characters"):
		characters.append(nameOfCharacter)
#	print(characters)
	texture = cursorTexture

# This whole _process(delta) function is used to allow scrolling through all the characters
func _process(delta):
	if(Input.is_action_just_pressed("p1_right") and CharacterSelectionManager.chosenCharacters[0]==null and currentSelected<CharacterSelectionManager.charNum):
		currentSelected += 1
		position.x = 128 + portraitOffset.x*(currentSelected%amountOfColumns)
		position.y = 128 + portraitOffset.x*int(currentSelected/amountOfColumns)
	elif(Input.is_action_just_pressed("p1_left") and CharacterSelectionManager.chosenCharacters[0]==null and currentSelected>0):
		currentSelected -= 1
		position.x = 128 + portraitOffset.x*(currentSelected%amountOfColumns)
		position.y = 128 + portraitOffset.x*int(currentSelected/amountOfColumns)

# If a selection is made send it to the Signleton CharacterSelectionManager.gd to store that value
	if(Input.is_action_just_pressed("p1_a")):
		if(CharacterSelectionManager.chosenCharacters[0]==null):
			CharacterSelectionManager.chosenCharacters[0] = CharacterSelectionManager.selectableCharacters[characters[currentSelected].name]
			texture = selectedTexture
		else:
			if(CharacterSelectionManager.chosenCharacters[0]!=null and CharacterSelectionManager.chosenCharacters[1]!=null):
				get_tree().change_scene("res://source/mainstage.tscn")
	if(Input.is_action_just_pressed("p1_b")):
		CharacterSelectionManager.chosenCharacters[0] = null
		texture = cursorTexture

