extends "../Attack.gd"



# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

var rng = RandomNumberGenerator.new()



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	endFrame = 33
	fastEndFrame = 22
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":7,
			"start":2,
			"end":8,
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
	if player.is_on_floor():
		interrupted = true


func onHit(name, target, shielded=false):
	endFrame = fastEndFrame
	if not shielded:
		target._velocity += get_parent()._velocity*(1+target.percentage)/50