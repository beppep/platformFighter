extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var uiScene = load("res://source/ui.tscn")

# archaic? 

#var puncherScene = load("res://source/characters/Puncher/Puncher.tscn")
#var ninjaScene = load("res://source/characters/Ninja/Ninja.tscn")
#var lizardScene = load("res://source/characters/Lizard/Lizard.tscn")
var froatScene = load("res://source/characters/Froat/Froat2.tscn")
var godtestScene = load("res://source/characters/Godtest/Godtest.tscn")
var NoxhScene = load("res://source/characters/Noxh/Noxh.tscn")
var svampScene = load("res://source/characters/Svampkoloni/Svampkoloni.tscn")
var monkScene = load("res://source/characters/Monk/Monk.tscn")
var clineScene = load("res://source/characters/Cline/Cline.tscn")
var chosenCharacters = []


var blastzoneX = 1200 # should be stage specifics
var blastzoneUp = -600
var blastzoneDown = 750


var rightHog = false
var rightHogger = null
var leftHog = false
var leftHogger = null


func _ready() -> void:
	var playerNum = CharacterSelectionManager.playerCount
	
	chosenCharacters = CharacterSelectionManager.chosenCharacters
	#chosenCharacters = [froatScene,godtestScene,]
	
	for i in range(0,playerNum):
		var uiThing = uiScene.instantiate()
		uiThing.anchor_left = i*1.0/playerNum
		uiThing.anchor_right = (i+1)*1.0/playerNum
		uiThing.set_name("ui"+str(i))
		$uiElements.add_child(uiThing)
		
	
	var new
	for i in range(0,playerNum):
		new = chosenCharacters[i].instantiate()
		$Players.add_child(new)
		new.player_id = i
		new.team = i
		new.position = Vector2(-300+600/(playerNum-1)*i, 0)
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
	if rightHog:
		if not (rightHogger and is_instance_valid(rightHogger) and rightHogger.state == rightHogger.states.wallHogging):
			rightHog = false
	if leftHog:
		if not (leftHogger and is_instance_valid(leftHogger) and leftHogger.state == leftHogger.states.wallHogging):
			leftHog = false
