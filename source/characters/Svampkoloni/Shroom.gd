extends KinematicBody2D



var explosion = load("res://source/fx/explosion.tscn")


var myAttack = load("res://source/characters/Svampkoloni/shroomAttack.gd")
var myTransform = load("res://source/characters/Svampkoloni/shroomTransform.gd")


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var gravity = 50.0
var _velocity = Vector2.ZERO
#var bounces = 1
var bannedHitboxes = []
var HitActors = []
var hitPause = 0
var nextFrameHitPause = 0
var kb_vector = Vector2(0,0)
var wasHit = false
var team = 0
var is_on_ground = false
var player_id = 0
var state = 0
var stateTimer = 0
var totalHitstun = 0
var grab_target

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer") #basically just declared in _ready func

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	z_index = -1

func inputAction():	
	
	if(nextFrameHitPause):
		hitPause=nextFrameHitPause
		nextFrameHitPause=0
	if hitPause:
		return
		
	if is_on_ground:
		if state==0:
			if Input.get_action_strength("p1_b") and player_id==0 or Input.get_action_strength("p2_b") and player_id==1:
				if get_direction() == Vector2.ZERO:
					state = 1
					stateTimer = 0
					$currentAttack.set_script(myAttack)
				elif get_direction().y > 0:
					state = 1
					stateTimer = 0
					$currentAttack.set_script(myTransform)
		if state==1:
			$currentAttack.update(self)
	
	_velocity.y += gravity
	var collision = move_and_collide(_velocity*1/60)
	if collision:
		_velocity = _velocity.slide(collision.normal)
		position += collision.get_remainder().length()*_velocity.normalized()
		if collision.normal == Vector2(0,-1) and state==0: #land from seed
			if not is_on_ground:
				resetToIdle()
				is_on_ground = true
			_velocity = Vector2(0,gravity)
	else:
		is_on_ground = false


func get_direction():
	if player_id==0:
		return Vector2(
			Input.get_action_strength("p1_right")-Input.get_action_strength("p1_left"),
			Input.get_action_strength("p1_down")-Input.get_action_strength("p1_up")
		)
	else:
		return Vector2(
			Input.get_action_strength("p2_right")-Input.get_action_strength("p2_left"),
			Input.get_action_strength("p2_down")-Input.get_action_strength("p2_up")
		)

func CheckHurtBoxes() -> Array:
	var HitActors = []
	#print($HurtBox.get_overlapping_areas())
	for hitbox in $HurtBox.get_overlapping_areas():
		var opponent=hitbox.get_parent().get_parent()
		
		if opponent.team != self.team:
			var data = opponent.get_node("currentAttack").hitboxes[int(hitbox["name"])] #invalid get index 169 on base array apparently
			if not [opponent, data["group"]] in bannedHitboxes:
				HitActors.append([data,opponent])
				bannedHitboxes.append([opponent,data["group"]])
			else:
				pass#print("banned")
	return HitActors

func hitCollision():			
	# hitting
	HitActors = CheckHurtBoxes()
	if HitActors:
		var data = HitActors[0][0]
		var opponent = HitActors[0][1]
		var kb = data["kb"]
		nextFrameHitPause += kb*0.1 #+= for trades and stuff?
		opponent.nextFrameHitPause += kb*0.1

func resetToIdle():
	state=0
	stateTimer=0
	anim_player.stop(true) #resets animation
	anim_player.play("standing")
		
func hitEffect():
	
	if state==1:
		$currentAttack.endAttack(self)
	if HitActors:
		wasHit = true
		var data = HitActors[0][0]
		var opponent = HitActors[0][1]
		
		if state == 1:
			$currentAttack.interrupted = true
			$currentAttack.endAttack(self)
		
		var angle = data["angle"]*PI/180
		var kb = (data["kb"])
		kb_vector = Vector2(cos(angle)*opponent.scale.y, -sin(angle))*10*kb
		totalHitstun = kb*0.3
		state = 2
		stateTimer = 0
		
		$"/root/Node2D/AudioStreamPlayer".playSound($"/root/Node2D/AudioStreamPlayer".punch, 100/kb)

		opponent.get_node("currentAttack").onHit(data["name"], self, false)
		#explosiin
		var blast = explosion.instance()
		blast.position = self.position
		blast.scale = Vector2(kb*0.02, kb*0.02)
		blast.z_index = -2
		get_node("/root/Node2D/fx").add_child(blast)
	
	
	if position.y>1000:
		queue_free()
	#if position.y<-750:
	#	queue_free()
	if position.x>1500:
		queue_free()
	if position.x<-1500:
		queue_free()
	
	
	#progress states
	if hitPause==0:
		stateTimer+=1
		if state == 2:
			if stateTimer >= totalHitstun:
				queue_free()
	if hitPause>0:
		hitPause-=1
		if hitPause<=0:
			hitPause=0
			anim_player.play()
			if state==2:
				anim_player.play("stunned")
				_velocity = kb_vector
				wasHit = false
