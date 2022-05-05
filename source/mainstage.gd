extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var puncherScene = load("res://source/characters/Puncher/Puncher.tscn")
var ninjaScene = load("res://source/characters/Ninja/Ninja.tscn")
var lizardScene = load("res://source/characters/Lizard/Lizard.tscn")
var froatScene = load("res://source/characters/Froat/Froat2.tscn")
var godtestScene = load("res://source/characters/Godtest/Godtest.tscn")
var svampScene = load("res://source/characters/Svampkoloni/Svampkoloni.tscn")
var monkScene = load("res://source/characters/Monk/Monk.tscn")
var chosenCharacters = []
var stockCounts = []

#onready var audioPlayer: AudioStreamPlayer = get_node("AudioStreamPlayer") 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	chosenCharacters = [froatScene,godtestScene,]
	chosenCharacters = [froatScene,froatScene,]

	stockCounts = [40,40]
	
	var new
	for i in range(0,2):
		new = chosenCharacters[i].instance()
		$Players.add_child(new)
		new.player_id = i
		new.team = i
		new.position = Vector2(-300+600*i, 0)
		if i==1:
			new.transform.x.x = -1
		new._ready2()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var players = $Players.get_children()
	var articles = $Articles.get_children()
	for player in players+articles:
		player.inputAction() #never check opponents here
	for player in players+articles:
		player.hitCollision() #only check things here
	for player in players+articles:
		player.hitEffect() #never check opponents here
	
	var representedPlayers = []
	for player in players:
		if not player.player_id in representedPlayers:
			representedPlayers.append(player.player_id)
	for i in range(0,2):
		if not i in representedPlayers:
			stockCounts[i]-=1
			if stockCounts[i]>0:
				var new = chosenCharacters[i].instance()
				$Players.add_child(new)
				new.player_id = i
				new.team = i
				new._ready2()
