extends KinematicBody2D
class_name Character

var explosion = load("res://source/things/explosion.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var gravity = 80.0 #per second squared
export var airspeed = 20.0
export var groundspeed = 100.0
export var jumpspeed = 1000.0
export var groundfriction = 0.8
export var airfriction = 0.98
var player_id = 0
var _velocity: = Vector2(0,-100) #pixels per second
var direction: = Vector2.ZERO
var released_jump = false
var double_jump = true
var state = 0 #0: actionable, 1:attacking, 2:hitstun 3:shield
var currentAttack = "error"
var stateTimer = 0
var totalHitstun = 0
var hitPause = 0 #descends
var nextFrameHitPause = 0
var bannedHitboxes = []
var HitActors = []
var percentage = 0
var shieldHealthMax = 150.0
var shieldHealth = shieldHealthMax
var shieldStun = 0

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer") #basically just declared in _ready func

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func inputAction():
	# input 
	direction = get_direction()
	# movement
	if(nextFrameHitPause):
		hitPause=nextFrameHitPause
		nextFrameHitPause=0
	if hitPause:
		return
	
	# options
	if state==0:
		if Input.get_action_strength("p1_a") and player_id==0 or Input.get_action_strength("p2_a") and player_id==1:
			attack()
		elif Input.get_action_strength("p1_shield") and player_id==0 or Input.get_action_strength("p2_shield") and player_id==1:
			shield()
	if state==1:
		#print(currentAttack.get_script_method_list())
		#print(ClassDB.class_exists("jab"))
		$currentAttack.update(self)
	if state==3 and shieldStun < 1:
		if not (Input.get_action_strength("p1_shield") and player_id==0 or Input.get_action_strength("p2_shield") and player_id==1):
			shieldEnd()
	calculate_move_velocity()
	if state==2:
		var collision = move_and_collide(_velocity*1/60)
		if collision:
			_velocity = _velocity.bounce(collision.normal)
			print("BOUNCE!")
			if collision.collider.has_method("tech"):
				collision.collider.tech()
	else:
		_velocity = move_and_slide(_velocity, Vector2.UP)
				
func attack():
	pass
func shield():
	state = 3
	stateTimer = 0
	$Shield.visible = true
func shieldEnd():
	state = 0
	stateTimer = 0
	$Shield.visible = false
func hitCollision():			
	# hitting
	HitActors = CheckHurtBoxes()
	if HitActors:
		var data = HitActors[0][0]
		var opponent = HitActors[0][1]
		var kb = data["kb"] + data["kbscaling"]*percentage
		nextFrameHitPause += kb*0.1 #+= for trades and stuff?
		opponent.nextFrameHitPause += kb*0.1
func hitEffect():
	
	if state==1:
		$currentAttack.endAttack(self)
	if HitActors:
		
		var data = HitActors[0][0]
		var opponent = HitActors[0][1]
		
		if state == 1:
			$currentAttack.interrupted = true
			$currentAttack.endAttack(self)
		var angle = data["angle"]*PI/180
		var kb = data["kb"] + data["kbscaling"]*percentage
		if(not state==3):
			_velocity = Vector2(cos(angle)*opponent.scale.y, -sin(angle))*kb*10
			totalHitstun = kb*0.2
			state = 2
			stateTimer = 0
			anim_player.stop(true) #resets animation
			anim_player.play("standing")
			anim_player.stop()
			anim_player.play("shake")
			percentage += data["damage"]
			$Label.text = str(percentage)+"%"
		else:
			shieldHealth -= data["damage"]*3
			shieldStun = data["damage"]*2
		#explosiin
		var blast = explosion.instance()
		blast.position = self.position
		blast.scale = Vector2(kb*0.02, kb*0.02)
		get_node("/root/Node2D/fx").add_child(blast)
	
		
	if state==3:
		if(shieldStun > 0):
			shieldStun-= 1
		else:
			shieldHealth-=1
		if(shieldHealth<1):
			shieldStun=0
			shieldHealth=0
			$Shield.visible = false
			state=2
			totalHitstun=60*3
		print(shieldHealth/(2*shieldHealthMax))
		$Shield.scale=Vector2(shieldHealth/(2*shieldHealthMax),shieldHealth/(2*shieldHealthMax))
		print($Shield.scale)
	else:
		if(shieldHealth<shieldHealthMax):
			shieldHealth+=0.5
			
	#progress states
	if hitPause==0:
		stateTimer+=1
		if state == 2:
			if stateTimer >= totalHitstun:
				state = 0
				anim_player.stop(true)
				#useless to remove bans here
	if hitPause>0:
		hitPause-=1
		#position+=direction #asdi
		#_velocity+=direction #this is not di this is just weird
		if hitPause<=0:
			hitPause=0
			anim_player.play()

func get_direction():
	if player_id==0:
		return Vector2(
			Input.get_action_strength("p1_right")-Input.get_action_strength("p1_left"),
			-Input.get_action_strength("p1_up") #is_on_floor updated by moveandslide
		)
	else:
		return Vector2(
			Input.get_action_strength("p2_right")-Input.get_action_strength("p2_left"),
			-Input.get_action_strength("p2_up") #is_on_floor updated by moveandslide
		)
	
func calculate_move_velocity():
	var new_velocity = _velocity
	if is_on_floor():
		double_jump = true
		if state==0:
			anim_player.play("standing")
			
	
	# FLIP
	if state==0 and is_on_floor():
		if direction.x>0:
			scale.x = scale.y * 1
		if direction.x<0:
			scale.x = scale.y * -1
	
	# MOVE X
	if is_on_floor():
		if state == 0:
			new_velocity.x += direction.x * groundspeed
	else:
		if state !=2:
			new_velocity.x += direction.x * airspeed

	#friction
	#velocity.y*=c
	if not is_on_floor() or state==2: #the game thinks you are grounded when sent flying
		new_velocity *= airfriction
	else:
		new_velocity *= groundfriction
	new_velocity.y += gravity
	
	
	# MOVE Y
	if direction.y == -1.0 and state == 0:
		if is_on_floor():
			new_velocity.y = -jumpspeed
			anim_player.stop() #resets animation
			anim_player.play("jump")
			released_jump = false
		elif released_jump == true and double_jump == true:
			new_velocity.y = -jumpspeed
			anim_player.stop(true) #resets animation
			anim_player.play("double_jump")
			double_jump = false
	if not is_on_floor() and not direction.y == -1.0:
		released_jump = true
		
	if position.y>1000:
		respawn()
	_velocity = new_velocity
	

func respawn():
	percentage = 0
	$Label.text = str(percentage)+"%"
	position = Vector2(0,0)
	_velocity = Vector2(0,0)
	state = 0
	stateTimer = 0

func CheckHurtBoxes() -> Array:
	var HitActors = []
	#print($HurtBox.get_overlapping_areas())
	for hitbox in $HurtBox.get_overlapping_areas():
		var opponent=hitbox.get_parent().get_parent()
		
		if opponent != self:
			var data = get_node("../"+opponent.name+"/currentAttack").hitboxes[int(hitbox["name"])] #invalid get index 169 on base array apparently
			if not [opponent, data["group"]] in bannedHitboxes:
				print(data, opponent.stateTimer)
				HitActors.append([data,opponent])
				bannedHitboxes.append([opponent,data["group"]])
			else:
				pass#print("banned")
	#print(HitActors)
	return HitActors
