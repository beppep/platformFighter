extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
var chargeTime



# Called when the script loads or somethn #nooooooot lmao
func _init() -> void:
	
	endFrame = 90
	fastEndFrame = 70
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":10,
			"start":51,
			"end":65,
			"kb":100,
			"kbscaling":5,
			"angle":80,
			"shapes":[
				[40,40,0,0]
			]
		},
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player)
	if player.stateTimer==0:
		chargeTime = 50
		player.anim_player.stop(true) #resets animation (noot
		player.anim_player.play("upb")
	if player.stateTimer>10 and player.stateTimer<=50:
		if not player.buttons[2]:
			chargeTime = player.stateTimer
			player.stateTimer = 50
	if player.stateTimer==51:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("nair")
		player._velocity = Vector2(0,-chargeTime*50-1000)
		hitboxes[0]["kbscaling"] = (chargeTime)*0.08 + 3
		hitboxes[0]["kb"] = chargeTime*1.2 + 200
	if player.stateTimer==56:
		player.can_walljump = true
