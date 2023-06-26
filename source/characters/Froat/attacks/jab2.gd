extends Attack


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 18
	fastEndFrame = 11
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":4,
			"start":4,
			"end":6,
			"kb":30,
			"kbscaling":0.3,
			"angle":60,
			"shapes":[
				[28,15,48,0]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("jab")
		player.anim_sprite.set_frame(0)
	if not player.is_on_ground:
		interrupted = true

	if player.stateTimer == 9 and player.buttons[1] and player.direction == Vector2.ZERO:
		interrupted = true
		endAttack()
		
		player.attackWith("jab3")
		player.stateTimer = -1
