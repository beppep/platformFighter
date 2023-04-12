extends KinematicBody2D



var explosion = load("res://source/fx/explosion.tscn")

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var gravity = 40.0
export var fallspeed = 1000
var _velocity = Vector2(400,400)
var bannedHitboxes = []
var HitActors = []
var hitPause = 0
var nextFrameHitPause = 0
var kb_vector = Vector2(0,0)
var wasHit = false
var team = 0
var state = 1
var currentAttack

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	currentAttack = load("res://source/characters/Froat/rockAttack.gd").new()
	currentAttack.player = self

func onHit(name, target, shielded=false):
	pass
	
func inputAction():	
	
	if(nextFrameHitPause):
		hitPause=nextFrameHitPause
		nextFrameHitPause=0
	if hitPause:
		return
		
	if _velocity.y<fallspeed:
		_velocity.y += gravity
	var collision = move_and_collide(_velocity*1/60)
	if collision:
		_velocity = (_velocity.bounce(collision.normal)*3 + _velocity)*0.25
		position += collision.remainder.bounce(collision.normal)
	
	currentAttack.update()
	
	if position.y>1000:
		queue_free()
	if position.y<-750:
		queue_free()
	if position.x>1250:
		queue_free()
	if position.x<-1250:
		queue_free()

func CheckHurtBoxes() -> Array:
	var HitActors = []
	#print($HurtBox.get_overlapping_areas())
	for hitbox in $HurtBox.get_overlapping_areas():
		var opponent=hitbox.get_parent().get_parent()
		
		if (opponent.team != self.team or opponent != self) and not opponent.name=="rock":
			var data = opponent.currentAttack.hitboxes[int(hitbox["name"])] #invalid get index 169 on base array apparently
			if not [opponent, data["group"]] in bannedHitboxes:
				HitActors.append([data,opponent])
				bannedHitboxes.append([opponent,data["group"]])
			else:
				pass#print("banned")
	#print(HitActors)
	return HitActors

func hitCollision():			
	# hitting
	HitActors = CheckHurtBoxes()
	if HitActors:
		var data = HitActors[0][0]
		var opponent = HitActors[0][1]
		var kb = data["kb"]
		nextFrameHitPause = max(nextFrameHitPause, hitpauseFormula(kb)) #+= for trades and stuff?
		opponent.nextFrameHitPause = max(opponent.nextFrameHitPause, hitpauseFormula(kb))
		
func hitEffect():

	if HitActors:
		wasHit = true
		
		
		var data = HitActors[0][0]
		var opponent = HitActors[0][1]
		#team = opponent.team
		
		var angle = data["angle"]*PI/180
		var kb = (data["kb"])
		if kb:
			kb_vector = Vector2(0,-1)*2*pow(kb,0.9) + Vector2(cos(angle)*opponent.transform.x.x, -sin(angle))*2.7 *pow(kb,1.2)
			if "autolinkX" in data and data["autolinkX"]>0:
				kb_vector.x += data["autolinkX"]
			if "autolinkY" in data and data["autolinkY"]>0:
				kb_vector.y += data["autolinkY"]
			
			$"/root/Node2D/AudioStreamPlayerLow".playSound($"/root/Node2D/AudioStreamPlayerLow".punch, 100/kb)

			opponent.currentAttack.onHit(data["name"], self, false)
			#explosiin
			var blast = explosion.instance()
			blast.position = self.position
			blast.scale = Vector2(kb*0.02, kb*0.02)
			blast.z_index = -2
			get_node("/root/Node2D/fx").add_child(blast)
		
		# make opponent own the ball
		for player in get_node("/root/Node2D/Players").get_children()+get_node("/root/Node2D/Articles").get_children(): #remove opponents bans
			var replacementList = []
			for i in player.bannedHitboxes:
				if i[0] != self:
					replacementList.append(i)
			player.bannedHitboxes = replacementList
		team = opponent.team #opponent.bannedHitboxes.append([self,1])
		
		
	#progress states
	if hitPause==0:
		pass
	if hitPause>0:
		hitPause-=1
		if hitPause<=0:
			hitPause=0
			if wasHit:
				_velocity = kb_vector
				wasHit = false
			else:
				pass#_velocity *= -1
				#_velocity.y -= 500
func getGrabbed():
	return true
	
func hitpauseFormula(kb):
	return kb*0.06+2
