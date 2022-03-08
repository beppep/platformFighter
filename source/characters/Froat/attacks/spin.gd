extends "res://source/characters/Attack.gd"



# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

#var rng = RandomNumberGenerator.new()



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	
	
	endFrame = 33
	fastEndFrame = 22
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":7,
			"start":4,
			"end":9,
			"kb":100,
			"kbscaling":0.2,
			"angle":90,
			"shapes":[
				[40,40,0,0]
			]
		},
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	#rng.randomize()
	#var my_random_number = rng.randf_range(0.0, 360.0)
	#hitboxes[0]["angle"] = my_random_number
	autoAttack(player)
	if player.stateTimer==0:
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("nair")
	if player.is_on_ground:
		interrupted = true


func onHit(name, target, shielded=false):
	if not shielded:
		endFast = true
		if "percentage" in target:
			target.kb_vector += get_parent()._velocity*(100+target.percentage)/100
		else:
			target.kb_vector += get_parent()._velocity*(100)/100
