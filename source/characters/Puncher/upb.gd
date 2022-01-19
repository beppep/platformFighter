extends "../Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	endFrame = 60
	hitboxes = [
	]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(player):
	autoAttack(player)
	if player.stateTimer==20:
		player.position.y-=300
		player._velocity.y = -1000
	if player.stateTimer==0:
		player._velocity.y = -1000
		player.anim_player.stop(true) #resets animation
		player.anim_player.play("upb")


func onHit():
	pass
