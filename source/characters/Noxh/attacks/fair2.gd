extends Attack
class_name Dair

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 40
	fastEndFrame = 30
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":2,
			"start":5,
			"end":7,
			"kb":50,
			"kbscaling":0.5,
			"angle":-1,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[32,28,28,0]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":2,
			"start":8,
			"end":10,
			"kb":50,
			"kbscaling":0.5,
			"angle":-1,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[32,28,28,0]
			]
		},
		{
			"name":"2",
			"group":3,
			"damage":2,
			"start":11,
			"end":13,
			"kb":50,
			"kbscaling":0.5,
			"angle":-1,
			"autolinkX":0.9,
			"autolinkY":1,
			"shapes":[
				[32,28,28,0]
			]
		},
		{
			"name":"3",
			"group":4,
			"damage":3,
			"start":15,
			"end":18,
			"kb":60,
			"kbscaling":1.5,
			"angle":40,
			"shapes":[
				[32,28,28,0]
			]
		},
	]

func update():
	if player.stateTimer==0:
		#player.cant_hitfall = true
		player.anim_sprite.play("fair2")
		
		#player._velocity.y*=0.5
		#player._velocity.y-=170
		#player._velocity.x*=0.5
		#player._velocity.x+=170*player.transform.x.x
		
		
	#if player.stateTimer<30 and true:
		#player._velocity.y*=0.92
		#player._velocity.y-=40
		#player._velocity.x*=0.92
		#player._velocity.x+=40*player.transform.x.x
		
		
	if player.is_on_ground:
		interrupted = true
		if not endFast:
			landingLag = 15


func onHit(name, target, shielded=false):
	player._velocity.y*=0.5
	player._velocity.y-=170
	player._velocity.x*=0.5
	player._velocity.x+=170*player.transform.x.x
	if not shielded:
		endFast = true
