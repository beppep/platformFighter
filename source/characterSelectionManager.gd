extends Node


var charNum = 3
var chosenCharacters = [null, null]

var selectableCharacters = {
	"froat" : preload("res://source/characters/Froat/Froat2.tscn"),
	"godtest" : preload("res://source/characters/Godtest/Godtest.tscn"),
	"noxh" : preload("res://source/characters/Noxh/Noxh.tscn"),
	"svamp" : preload("res://source/characters/Svampkoloni/Svampkoloni.tscn"),
	"random" : preload("res://source/characters/Svampkoloni/Svampkoloni.tscn"),
}

func hitpauseFormula(kb):
	return kb*0.06+2
