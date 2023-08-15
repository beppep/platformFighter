extends Node

var playerCount = 2

var charNum = 6
var legalCharNum = 3
var chosenCharacters = []

var selectableCharacters = {
	"froat" : preload("res://source/characters/Froat/Froat2.tscn"),
	"goad" : preload("res://source/characters/Goad/Goad.tscn"),
	"noxh" : preload("res://source/characters/Noxh/Noxh.tscn"),
	"cline" : preload("res://source/characters/Cline/Cline.tscn"),
	"oculus" : preload("res://source/characters/Oculus/Oculus.tscn"),
	"svamp" : preload("res://source/characters/Svampkoloni/Svampkoloni.tscn"),
	"shark" : preload("res://source/characters/Godtest/Godtest.tscn"),
	#"random" : preload("res://source/characters/Svampkoloni/Svampkoloni.tscn"),
}

func _ready():
	pass
	#for i in range(playerCount):
	#	chosenCharacters.append(null)

func pickCharacter(index, name):
	if name=="random":
		randomize()
		chosenCharacters[index] = selectableCharacters[selectableCharacters.keys()[randi() % legalCharNum]]
	else:
		chosenCharacters[index] = selectableCharacters[name]

func hitpauseFormula(kb):
	return kb*0.06+2
