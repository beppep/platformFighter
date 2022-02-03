extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var hitboxes = []
var endFrame = 100
var fastEndFrame = 80
var interrupted = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func autoAttack(player):
	for h in hitboxes:
		if h["start"] == player.stateTimer:
			createHitBox(h)
		if h["end"] == player.stateTimer:
			var i = get_node("../HitBoxes/"+h["name"])
			if(not i.is_queued_for_deletion()):
				i.queue_free()

func endAttack(player):
	if player.stateTimer == endFrame or interrupted:
		autoEndAttack(player)

func autoEndAttack(player):
	player.state = 0
	interrupted = false
	player.anim_player.stop(true)
	for box in get_node("../HitBoxes").get_children():
		if(not box.is_queued_for_deletion()):
			box.queue_free()
	for other in get_node("/root/Node2D/Players").get_children():
		if not other == player:
			var replacementList = []
			for i in other.bannedHitboxes:
				if i[0] != player:
					replacementList.append(i)
			other.bannedHitboxes = replacementList

func update(player):
	#print("htr")
	pass


func onHit(name, target, shielded=false):
	if not shielded:
		endFrame = fastEndFrame


func createHitBox(h):
	var hitbox = Area2D.new()
	get_node("../HitBoxes").add_child(hitbox)
	hitbox.set_collision_layer(4)
	hitbox.set_collision_mask(0)
	hitbox.set_name(h["name"])
	for i in h["shapes"]:
		var _bs = RectangleShape2D.new()
		_bs.extents.x = i[0]
		_bs.extents.y = i[1]
		
		var _sp = CollisionShape2D.new()
		_sp.shape = _bs
		_sp.transform.origin.x = i[2]
		_sp.transform.origin.y = i[3]
		#_sp.rotation_degrees.z = 0
		hitbox.add_child(_sp)
		_sp.set_owner(self)
