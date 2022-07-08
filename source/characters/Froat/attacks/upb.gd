extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
var chargeTime



# Called when the script loads or somethn #nooooooot lmao
func _init() -> void:
	
	endFrame = 999
	fastEndFrame = 60
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":10,
			"start":41,
			"end":55,
			"kb":1,
			"kbscaling":0,
			"angle":80,
			"shapes":[
				[40,40,0,0]
			]
		},
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update():
	if player.stateTimer==0:
		#player.can_walljump = false
		player._velocity.y = 0
		chargeTime = 40
		player.anim_sprite.play("upb1")
	if player.stateTimer<5:
		player.flip()
	if player.stateTimer<40:
		player._velocity.y -= 53
		player._velocity.y *= 0.8
		if player.stateTimer<10:
			player._velocity.x *= 0.9
		else:
			player._velocity.x *= 0.8
	else:
		player._velocity.x *= 0.97
	if player.stateTimer>10 and player.stateTimer<=40:
		if not player.buttons[2]:
			chargeTime = player.stateTimer
			player.stateTimer = 40
	if player.stateTimer==41:
		player.anim_sprite.play("upb2")
		hitboxes[0]["kbscaling"] = (chargeTime)*0.02 + 1.0 #1.5 to 2.1     -   charge time between 10 and 40
		hitboxes[0]["kb"] = chargeTime*0.5 + 100 # 105 to 120
		endFrame = 120 + chargeTime
	if player.stateTimer>40 and player.stateTimer<42 + chargeTime*0.5:
		player._velocity = Vector2(150*player.transform.x.x,-1000)#-chargeTime*20
	if player.stateTimer==50 + int(chargeTime*0.5):
		pass
		#player.can_walljump = true
	
	if player.is_on_ground and player.stateTimer>51:
		interrupted = true #remove hitboxes? idk
		if not endFast:
			landingLag = 20


