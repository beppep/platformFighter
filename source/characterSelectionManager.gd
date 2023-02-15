extends Node


var charNum = 4
var chosenCharacters = [null, null]

var selectableCharacters = {
	"froat" : preload("res://source/characters/Froat/Froat2.tscn"),
	"noxh" : preload("res://source/characters/Noxh/Noxh.tscn"),
	"cline" : preload("res://source/characters/Cline/Cline.tscn"),
	"svamp" : preload("res://source/characters/Svampkoloni/Svampkoloni.tscn"),
	"shark" : preload("res://source/characters/Godtest/Godtest.tscn"),
	"random" : preload("res://source/characters/Svampkoloni/Svampkoloni.tscn"),
}

func pickCharacter(index, name):
	if name=="random":
		#randomize()
		chosenCharacters[index] = selectableCharacters[selectableCharacters.keys()[randi() % (selectableCharacters.size()-1)]]
	else:
		chosenCharacters[index] = selectableCharacters[name]

func hitpauseFormula(kb):
	return kb*0.06+2