extends KinematicBody2D



var explosion = load("res://source/fx/explosion.tscn")

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var gravity = 5.0
var _velocity = Vector2(50,0)

var bannedHitboxes = []
var HitActors = []
var hitPause = 0
var nextFrameHitPause = 0
var kb_vector = Vector2(0,0)
var team = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func onHit(name, target, shielded=false):
	pass
	
func inputAction():	
	
	if(nextFrameHitPause):
		hitPause=nextFrameHitPause
		nextFrameHitPause=0
	if hitPause:
		return
		
	_velocity.y += gravity
	_velocity = move_and_slide(_velocity)
	_velocity.x*=0.99
	_velocity.y*=0.98
		
	var attracted = false
	for other in $"/root/Node2D/Players".get_children():
		if other.team == team:
			if other.state == 3:
				var hyp2 = other.position.distance_squared_to(position)+10
				if hyp2<pow((35+other.shieldHealth*0.3),2):
					queue_free()
					other.shieldHealth=other.shieldHealth*0.5+150
				else:
					other._velocity += (position - other.position)/hyp2*1000
					_velocity += (other.position - position)/hyp2*1000
					attracted = true
	if attracted:
		_velocity.y-=gravity
		
	
	if position.y>1000:
		queue_free()
	#if position.y<-750:
		#queue_free()
	if position.x>1500:
		queue_free()
	if position.x<-1500:
		queue_free()

func CheckHurtBoxes() -> Array:
	var HitActors = []
	#print($HurtBox.get_overlapping_areas())
	for hitbox in $HurtBox.get_overlapping_areas():
		var opponent=hitbox.get_parent().get_parent()
		
		if opponent.team != self.team or true:
			var data = opponent.get_node("currentAttack").hitboxes[int(hitbox["name"])] #invalid get index 169 on base array apparently
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
		nextFrameHitPause = kb*0.05+2 #+= for trades and stuff?
		opponent.nextFrameHitPause = kb*0.05+2
		
func hitEffect():

	if HitActors:
		
		
		var data = HitActors[0][0]
		var opponent = HitActors[0][1]
		team = opponent.team
		
		var angle = data["angle"]*PI/180
		var kb = (data["kb"])
		if kb:
			kb_vector = Vector2(cos(angle)*opponent.scale.y, -sin(angle))*5*kb
			
			$"/root/Node2D/AudioStreamPlayer".playSound($"/root/Node2D/AudioStreamPlayer".punch, 100/kb)

			opponent.get_node("currentAttack").onHit(data["name"], self, false)
			#explosiin
			var blast = explosion.instance()
			blast.position = self.position
			blast.scale = Vector2(kb*0.02, kb*0.02)
			blast.z_index = -3
			get_node("/root/Node2D/fx").add_child(blast)
			
	#progress states
	if hitPause==0:
		pass
	if hitPause>0:
		hitPause-=1
		if hitPause<=0:
			hitPause=0
			_velocity = kb_vector
