extends Attack


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 50
	fastEndFrame = 40
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":3,
			"start":18,
			"end":20,
			"kb":110,
			"kbscaling":0.6,
			"angle":50,
			"shapes":[
				[37,17,53,0]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":3,
			"start":25,
			"end":27,
			"kb":110,
			"kbscaling":0.6,
			"angle":130,
			"shapes":[
				[37,17,-53,0]
			]
		},
	]

func update():
	if player.stateTimer==1:
		player.anim_sprite.modulate = player.sprite_color+Color(0.5,0.5,0.5,0)
		player.intangibleFrames = 30
		player.anim_sprite.play("getupattack")
	if player.stateTimer==30:
		player.anim_sprite.modulate = player.sprite_color
		player.intangibleFrames = 0
	if not player.is_on_ground:
		pass
		#interrupted = true
