extends Attack

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var tpTarget = false

# Called when the node enters the scene tree for the first time.

func _init() -> void:
	endFrame = 77
	fastEndFrame = 70
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"damage":14,
			"start":22,
			"end":25,
			"kb":150,
			"kbscaling":2.0,
			"angle":40,
			"shapes":[
				[50,26,95,-25]
			]
		},
		{
			"name":"1",
			"group":2,
			"damage":5,
			"start":54,
			"end":62,
			"kb":100,
			"kbscaling":0.3,
			"angle":70,
			"shapes":[
				[20,40,34,-30]
			]
		},
	]

func update():
	if player.stateTimer==0:
		player.anim_sprite.play("fsmash")
	if player.stateTimer>53 and (not tpTarget or not is_instance_valid(tpTarget)):
		interrupted = true
	if player.stateTimer==40 and tpTarget:
		player.anim_sprite.play("fsmash2")
	if player.stateTimer==52 and tpTarget and is_instance_valid(tpTarget):
		player.position = tpTarget.position + tpTarget._velocity*0.15 + Vector2(0,100)
		player.transform.x.x *= -1
	if player.stateTimer>50 and player.stateTimer<55 and tpTarget and is_instance_valid(tpTarget):
		player._velocity = Vector2(400*player.transform.x.x, -1000)
		
		
func onHit(name, target, shielded=false):
	if name=="0" and not shielded:
		tpTarget = target

	if not shielded:
		endFast = true
