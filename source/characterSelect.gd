extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	CharacterSelectionManager.chosenCharacters = []
	for i in range( CharacterSelectionManager.playerCount):
		CharacterSelectionManager.chosenCharacters.append(null)
