extends KinematicBody2D
class_name Character


var explosion = load("res://source/things/explosion.tscn")
var explosion2 = load("res://source/things/explosion2.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var gravity = 80.0 #per second squared
export var airspeed = 20.0
export var groundspeed = 100.0
export var jumpspeed = 1000.0
export var groundfriction = 0.8
export var airfriction = 0.98
export var yfriction = 0.95
export var player_id = 0
var _velocity = Vector2(0,-100) #pixels per second
var direction = Vector2.ZERO
var c_direction = Vector2.ZERO
var released_jump = false
var double_jump = 1
var can_walljump = false
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
	if player_id==1:
		$sprite.modulate=Color(0.8,0.8,2.5)
	$Label.text = str(percentage)+"%"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func inputAction():
	# input 
	direction = get_direction()
	c_direction = get_c_direction()
	# movement
	if(nextFrameHitPause):
		hitPause=nextFrameHitPause
		nextFrameHitPause=0
	if hitPause:
		return
	
	# options
	if state==0:
		if Input.get_action_strength("p1_a") and player_id==0 or Input.get_action_strength("p2_a") and player_id==1 or c_direction!=Vector2(0,0):
			attack()
		if Input.get_action_strength("p1_b") and player_id==0 or Input.get_action_strength("p2_b") and player_id==1:
			special()
		elif Input.get_action_strength("p1_shield") and player_id==0 or Input.get_action_strength("p2_shield") and player_id==1:
			shield()
	if state==1:
		#print(currentAttack.get_script_method_list())
		#print(ClassDB.class_exists("jab"))
		$currentAttack.update(self)
	if state==3 and shieldStun < 1:
		if not (Input.get_action_strength("p1_shield") and player_id==0 or Input.get_action_strength("p2_shield") and player_id==1):
			shieldEnd()
		elif (Input.get_action_strength("p1_jump") and player_id==0 or Input.get_action_strength("p2_jump") and player_id==1):
			_velocity.y-=gravity+20
			_velocity.x*=0.95
			shieldHealth-=1
			released_jump = false
	calculate_move_velocity()
	if state==2:
		z_index=0
		var collision = move_and_collide(_velocity*1/60)
		if collision:
			_velocity = _velocity.bounce(collision.normal)
			print("BOUNCE!")
			
			var blast = explosion2.instance()
			#explosiin
			blast.position = self.position
			blast.scale = Vector2(2, 2)
			get_node("/root/Node2D/fx").add_child(blast)
			if Input.get_action_strength("p1_shield") and player_id==0 or Input.get_action_strength("p2_shield") and player_id==1:
				tech()
	else:
		z_index=1
		_velocity = move_and_slide(_velocity, Vector2.UP)
	
	
	if position.y>1000:
		respawn()
	if position.y<-750:
		respawn()
	if position.x>1500:
		respawn()
	if position.x<-1500:
		respawn()

func get_direction():
	if player_id==0:
		return Vector2(
			Input.get_action_strength("p1_right")-Input.get_action_strength("p1_left"),
			Input.get_action_strength("p1_down")-Input.get_action_strength("p1_up") #is_on_floor updated by moveandslide
		)
	else:
		return Vector2(
			Input.get_action_strength("p2_right")-Input.get_action_strength("p2_left"),
			Input.get_action_strength("p2_down")-Input.get_action_strength("p2_up") #is_on_floor updated by moveandslide
		)
func get_c_direction():
	if player_id==0:
		return Vector2(0,0)
	else:
		return Vector2(
			Input.get_action_strength("p2_c_right")-Input.get_action_strength("p2_c_left"),
			Input.get_action_strength("p2_c_down")-Input.get_action_strength("p2_c_up") #is_on_floor updated by moveandslide
		)

func calculate_move_velocity():
	if is_on_floor():
		double_jump = 1
		if state==0:
			anim_player.play("standing")
			
	
	# FLIP
	if state==0 and is_on_floor():
		flip()
	
	# MOVE X
	if is_on_floor():
		if state == 0:
			_velocity.x += direction.x * groundspeed
	else:
		if state !=2:
			_velocity.x += direction.x * airspeed

	#friction
	if not is_on_floor() or state==2: #the game thinks you are grounded when sent flying
		_velocity.x *= airfriction
		_velocity.y *= yfriction
	else:
		_velocity *= groundfriction
	_velocity.y += gravity
	
	
	# MOVE Y
	if (Input.get_action_strength("p1_jump") and player_id==0 or Input.get_action_strength("p2_jump") and player_id==1):
		if state == 0:
			if is_on_floor():
				_velocity.y = -jumpspeed
				anim_player.stop() #resets animation
				anim_player.play("jump")
				released_jump = false
			elif is_on_wall():
				wallJump()
			elif released_jump == true and double_jump == 1:
				_velocity.y = -jumpspeed
				anim_player.stop(true) #resets animation
				anim_player.play("double_jump")
				double_jump -= 1
				released_jump = false
		if state == 1 and can_walljump and is_on_wall():
			wallJump()
	elif not is_on_floor():
		released_jump = true

func flip():
	if direction.x>0:
		scale.x = scale.y * 1
	if direction.x<0:
		scale.x = scale.y * -1

func wallJump():
	if state==1:
		$currentAttack.interrupted = true
		$currentAttack.endAttack(self)
		state=0
	_velocity.y = -jumpspeed
	if position.x>0:
		_velocity.x = 500
	else:
		_velocity.x = -500
	anim_player.stop() #resets animation
	anim_player.play("double_jump")
	released_jump = false
	
func respawn():
	percentage = 0
	shieldHealth = shieldHealthMax
	$Label.text = str(percentage)+"%"
	position = Vector2(0,0)
	_velocity = Vector2(0,0)
	if state==1:
		$currentAttack.interrupted = true
		$currentAttack.endAttack(self)
	state = 0
	stateTimer = 0
	anim_player.stop(true) #resets animation
	anim_player.play("standing")
	$Shield.visible = false
	
func tech():
	_velocity = Vector2(0,0)
	state = 0
	stateTimer = 0
				
func attack():
	pass
func special():
	pass
func shield():
	_velocity.y=-100
	state = 3
	stateTimer = 0
	$Shield.visible = true
func shieldEnd():

	state = 0
	stateTimer = 0
	$Shield.visible = false

func CheckHurtBoxes() -> Array:
	var HitActors = []
	#print($HurtBox.get_overlapping_areas())
	for hitbox in $HurtBox.get_overlapping_areas():
		var opponent=hitbox.get_parent().get_parent()
		
		if opponent != self:
			var data = get_node("../"+opponent.name+"/currentAttack").hitboxes[int(hitbox["name"])] #invalid get index 169 on base array apparently
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
		var blast
		if(not state==3):
			_velocity = Vector2(cos(angle)*opponent.scale.y, -sin(angle))*kb*10
			totalHitstun = kb*0.2
			state = 2
			stateTimer = 0
			percentage += data["damage"]
			$Label.text = str(percentage)+"%"
			anim_player.stop(true) #resets animation
			anim_player.play("standing")
			anim_player.stop()
			anim_player.play("shake")
			$"/root/Node2D/AudioStreamPlayer".playSound($"/root/Node2D/AudioStreamPlayer".punch, 100/kb)
			blast = explosion.instance()
		else:
			shieldHealth -= data["damage"]*3
			shieldStun = data["damage"]*2
			$"/root/Node2D/AudioStreamPlayer".playSound($"/root/Node2D/AudioStreamPlayer".shieldHit, 100/kb)
			blast = explosion2.instance()
		get_node("../"+opponent.name+"/currentAttack").onHit(data["name"], self, (state==3))
		#explosiin
		blast.position = self.position
		blast.scale = Vector2(kb*0.02, kb*0.02)
		blast.z_index = -2
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
			stateTimer=0
			totalHitstun=180
			_velocity = Vector2(0,-1000)
			
			anim_player.stop(true) #resets animation
			anim_player.play("standing")
			anim_player.stop()
			anim_player.play("stunned")
			
		$Shield.scale=Vector2(shieldHealth/(2*shieldHealthMax),shieldHealth/(2*shieldHealthMax))
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
		#position+=direction #asdi #test_move ( 
		#_velocity+=direction #this is not di this is just weird
		if hitPause<=0:
			hitPause=0
			anim_player.play()
			if state==2:
				anim_player.play("stunned")
