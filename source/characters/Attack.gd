extends Node
class_name Attack

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var hitboxes = []
var endFrame = 100
var fastEndFrame = 80
var endFast = false
var interrupted = false
var can_grabcancel = true
var landingLag = 0
var player


# Called when the script loads or somethn
func _init():
	pass

func manageHitboxes():
	print(player.stateTimer)
	for hitboxData in hitboxes:
		if hitboxData["start"] == player.stateTimer:
			createHitBox(hitboxData)
			print("ffh")
		print("h2")
		if hitboxData["end"] == player.stateTimer:
			var i = player.get_node("HitBoxes/"+hitboxData["name"])
			if(not i.is_queued_for_deletion()):
				i.queue_free()

func endAttack():
	if player.stateTimer == endFrame or (player.stateTimer == fastEndFrame and endFast) or interrupted:
		autoEndAttack()

func autoEndAttack():
	for box in player.get_node("HitBoxes").get_children(): #remove hitboxes
		if(not box.is_queued_for_deletion()):
			box.queue_free()
	for other in player.get_node("/root/Node2D/Players").get_children()+player.get_node("/root/Node2D/Articles").get_children(): #remove opponents bans
		if not other == player:
			var replacementList = []
			for i in other.bannedHitboxes:
				if i[0] != player:
					replacementList.append(i)
			other.bannedHitboxes = replacementList
	if player.grab_target and is_instance_valid(player.grab_target) and player.grab_target.state==5: # i dragged a player out with grab
		print("grab released?!")
		player.grab_target.state=2
		player.grab_target.stateTimer = 0
		player.grab_target._velocity = Vector2(500*player.transform.x.x,-500)
		player.grab_target.totalHitstun = 20
	if player.is_on_ground:
		if not endFast and landingLag!=0: #landinglag
			if landingLag == -1:
				player.state = 7
				player.stateTimer = 0
				player.anim_sprite.play("lying")
			else:
				player.state = 6
				player.stateTimer = 0
				player.totalLandingLag = landingLag
				player.anim_sprite.play("land")
		else:
			player.state=0 #grounded
	else:
		player.state=0
		player.anim_sprite.play("jump")
	onEnd()

func update():
	#print("htr")
	pass


func onHit(name, target, shielded=false):
	if not shielded:
		endFast = true

func onEnd():
	pass

func createHitBox(hitboxData):
	var hitbox = Area2D.new()
	player.get_node("HitBoxes").add_child(hitbox)
	hitbox.set_collision_layer(4)
	hitbox.set_collision_mask(0)
	hitbox.set_name(hitboxData["name"])
	for i in hitboxData["shapes"]:
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
