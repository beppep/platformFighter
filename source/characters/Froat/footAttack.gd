extends "res://source/characters/Attack.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
func _init() -> void:
	endFrame = 16
	fastEndFrame = 16
	hitboxes = [
		{
			"name":"0",
			"group":1,
			"start":3,
			"end":15,
			"damage":14,
			"kb":200,
			"kbscaling":2,
			"angle":90,
		},
	]

func update(player):
	if player.stateTimer<15:
		for other in $"/root/Node2D/Players".get_children():
			if other.team == player.team:
				if player.get_node("HitBoxes/0").overlaps_body(other):
					other._velocity = Vector2(0,-2000)
					#maybe not reset idk...
					#other.currentAttack.interrupted = true
					#other.currentAttack.endAttack()
					#other.resetToIdle()
					break

func endAttack(player):
	if player.stateTimer == endFrame or interrupted:
		autoEndAttack(player)

func autoEndAttack(player):
	player._velocity = Vector2(0,200)
	for box in get_node("../HitBoxes").get_children(): #remove hitboxes
		if(not box.is_queued_for_deletion()):
			box.queue_free()
	
	#this is pointless maybe
	for other in get_node("/root/Node2D/Players").get_children(): #remove opponents bans
		if not other == player:
			var replacementList = []
			for i in other.bannedHitboxes:
				if i[0] != player:
					replacementList.append(i)
			other.bannedHitboxes = replacementList
