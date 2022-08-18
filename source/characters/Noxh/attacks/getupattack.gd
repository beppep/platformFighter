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
			"start":20,
			"end":22,
			"kb":70,
			"kbscaling":0.6,
			"angle":45,
			"shapes":[
				[37,17,33,0]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":3,
			"start":25,
			"end":27,
			"kb":70,
			"kbscaling":0.6,
			"angle":135,
			"shapes":[
				[37,17,-33,0]
			]
		},
	]

func update():
	if player.stateTimer==1:
		player.anim_sprite.modulate = player.sprite_color+Color(0.5,0.5,0.5,0)
		player.intangible = true
		player.anim_sprite.play("getupattack")
	if player.stateTimer==30:
		player.anim_sprite.modulate = player.sprite_color
		player.intangible = false
	if not player.is_on_ground:
		pass
		#interrupted = true
