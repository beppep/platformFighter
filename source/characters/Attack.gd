extends Node


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var hitboxes = []
var endFrame = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func autoAttack(stateTimer):
	for h in hitboxes:
		if h["start"] == stateTimer:
			createHitBox(h)
		if h["end"] == stateTimer:
			get_node("../HitBoxes/"+h["name"]).queue_free()
	if stateTimer == endFrame:
		get_parent().state = 0
		for player in get_node("/root/Node2D/Players").get_children():
			var replacementList = []
			for i in player.bannedHitboxes:
				if i[0] != get_parent():
					replacementList.append(i)
			player.bannedHitboxes = replacementList

func update(player):
	#print("htr")
	pass


func onHit():
	pass


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
