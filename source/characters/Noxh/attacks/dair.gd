extends Attack
#class_name Fair



# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 35
	fastEndFrame = 26
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":2,
			"start":5,
			"end":7,
			"kb":35,
			"kbscaling":0.1,
			"angle":-100,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[28,28,0,40]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":2,
			"start":8,
			"end":10,
			"kb":35,
			"kbscaling":0.1,
			"angle":-70,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[28,28,0,40]
			]
		},
		{
			"name":"2",
			"group":3,
			"damage":2,
			"start":11,
			"end":13,
			"kb":35,
			"kbscaling":0.1,
			"angle":-100,
			"autolinkX":0.9,
			"autolinkY":0.9,
			"shapes":[
				[28,28,0,40]
			]
		},
		{
			"name":"3",
			"group":4,
			"damage":3,
			"start":15,
			"end":18,
			"kb":30,
			"kbscaling":0.8,
			"angle":-70,
			"shapes":[
				[28,28,0,40]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.cant_hitfall = true
		player.anim_sprite.play("dair")
	if player.is_on_ground:
		interrupted = true
		if not endFast:
			landingLag = 15


func onHit(name, target, shielded=false):
	player._velocity.y*=0.5
	if not shielded:
		endFast = true
	if name=="3" and not shielded:
		player.cant_hitfall = false
