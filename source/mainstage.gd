extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var uiScene = load("res://source/ui.tscn")
#var puncherScene = load("res://source/characters/Puncher/Puncher.tscn")
#var ninjaScene = load("res://source/characters/Ninja/Ninja.tscn")
#var lizardScene = load("res://source/characters/Lizard/Lizard.tscn")
var froatScene = load("res://source/characters/Froat/Froat2.tscn")
var godtestScene = load("res://source/characters/Godtest/Godtest.tscn")
var NoxhScene = load("res://source/characters/Noxh/Noxh.tscn")
var svampScene = load("res://source/characters/Svampkoloni/Svampkoloni.tscn")
var monkScene = load("res://source/characters/Monk/Monk.tscn")
var chosenCharacters = []


var blastzoneX = 1250
var blastzoneUp = 750
var blastzoneDown = -750


func _ready() -> void:
	var playerNum = 2
	
	chosenCharacters = [svampScene,froatScene,]
	#chosenCharacters = [froatScene,froatScene,]
	
	for i in range(0,playerNum):
		var uiThing = uiScene.instance()
		uiThing.anchor_left = i*1.0/playerNum
		uiThing.anchor_right = (i+1)*1.0/playerNum
		uiThing.set_name("ui"+str(i))
		$uiElements.add_child(uiThing)
		
	
	var new
	for i in range(0,playerNum):
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
		
		
	for player in players:
		get_node("uiElements/ui"+str(player.player_id)+"/Label").text = str(player.percentage)+"%"
