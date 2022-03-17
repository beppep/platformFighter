extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
var chargeTime



# Called when the script loads or somethn #nooooooot lmao
func _init() -> void:
	
	endFrame = 999
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
	if player.stateTimer<50:
		player._velocity.y -= 50
		player._velocity.y *= 0.95
		player._velocity.x *= 0.95
	if player.stateTimer==0:
		player._velocity.y = 0
		player._velocity.y *= 0.5
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
		player._velocity = Vector2(0,-chargeTime*30-1000)
		hitboxes[0]["kbscaling"] = (chargeTime)*0.04 + 1.5
		hitboxes[0]["kb"] = chargeTime*0.5 + 100
		endFrame = 90 + chargeTime
	if player.stateTimer==56:
		player.can_walljump = true


