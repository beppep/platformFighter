extends KinematicBody2D
class_name Character

#tech timing
#finite downb froat
#side b bakåt i luften
#respawn time
var rng = RandomNumberGenerator.new()

var explosion = load("res://source/fx/explosion.tscn")
var explosion2 = load("res://source/fx/explosion2.tscn")
var jump_ring = load("res://source/fx/jump_ring.tscn")
var sparks = load("res://source/fx/sparks.tscn")
var sparks2 = load("res://source/fx/sparks2.tscn")

var grab
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
export var team = 0
var sprite_color = Color(1,1,1)
var _velocity = Vector2(0,-100) #pixels per second
var direction = Vector2.ZERO
var c_direction = Vector2.ZERO
var released_jump = false
var double_jump = 1
var can_walljump = false
var state = 0 #0: actionable, 1:attacking, 2:hitstun 3:shield, 4:dodge, 5:grabbed?
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
var kb_vector = Vector2(0,0)
var intangible = false
var is_on_ground = true
var dontShield = true
var grab_target

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer") #basically just declared in _ready func

# Called when the node enters the scene tree for the first time.
func _ready():
	if player_id==1:
		sprite_color=Color(0.8,0.8,2.5)
		$sprite.modulate=sprite_color
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
		if direction.y>0:
			_velocity.y = gravity*20
	if hitPause:
		return
	
	if not (state==4 and stateTimer<8):
		calculate_move_velocity()
	# options
	if state==0:
		if Input.get_action_strength("p1_shield") and player_id==0 or Input.get_action_strength("p2_shield") and player_id==1:
			if not dontShield:
				shield()
		else:
			dontShield = false
			if Input.get_action_strength("p1_a") and player_id==0 or Input.get_action_strength("p2_a") and player_id==1 or c_direction!=Vector2(0,0):
				attack()
			elif Input.get_action_strength("p1_b") and player_id==0 or Input.get_action_strength("p2_b") and player_id==1:
				special()
	if state==3 and shieldStun < 1:
		if not (Input.get_action_strength("p1_shield") and player_id==0 or Input.get_action_strength("p2_shield") and player_id==1):
			shieldEnd()
		elif Input.get_action_strength("p1_a") and player_id==0 or Input.get_action_strength("p2_a") and player_id==1:
			shieldEnd()
			grab()
		elif (Input.get_action_strength("p1_jump") and player_id==0 or Input.get_action_strength("p2_jump") and player_id==1):
			if not is_on_ground:
				_velocity.y-=50
				shieldHealth-=1
				released_jump = false
		if is_on_ground:
			if direction.y>0 or direction.x!=0:
				dodge()
			elif direction.y<0: #shield drop
				set_collision_mask_bit(4,0)
				shieldEnd()
				dontShield=true
		else:
			_velocity*=0.95
			_velocity.y-=50
	if state==1:
		#print(currentAttack.get_script_method_list())
		#print(ClassDB.class_exists("jab"))
		$currentAttack.update(self)
	if state == 4:
		# roll cancel wavedash
		if stateTimer < 3:
			if (Input.get_action_strength("p1_jump") and player_id==0 or Input.get_action_strength("p2_jump") and player_id==1):
				if is_on_ground and not direction.y<0:
					intangible = false
					$sprite.modulate = sprite_color
					resetToIdle()
					_velocity = direction.normalized()*1000
					dontShield = true
					released_jump = false
					$"/root/Node2D/AudioStreamPlayer".playSound($"/root/Node2D/AudioStreamPlayer".waveland)
		if stateTimer == 8:
			_velocity=Vector2.ZERO
		if stateTimer == 20:
			$sprite.modulate = sprite_color
			intangible = false
		if stateTimer>30:
			resetToIdle()
	if state==4 and stateTimer<8:
		z_index=0
		if not is_on_ground:
			#waveland
			var collision = move_and_collide(_velocity*1/60)
			if not collision:# and _velocity.y>=0: #land snap
				move_and_collide(Vector2(0,-50))
				collision = move_and_collide(Vector2(0,100))
				if not collision:
					move_and_collide(Vector2(0,-50))
			if collision:
				#print("waveland")
				$sprite.modulate = sprite_color
				intangible = false
				released_jump = false
				dontShield = true
				if collision.normal==Vector2.UP:
					is_on_ground = true
				resetToIdle()
				$"/root/Node2D/AudioStreamPlayer".playSound($"/root/Node2D/AudioStreamPlayer".waveland)
		else:
			move_and_slide(_velocity)
	elif state==2:
		z_index=0
		var collision = move_and_collide(_velocity*1/60)
		if collision:
			var prev_vel = _velocity
			var bounce_vel = _velocity.bounce(collision.normal)
			if bounce_vel.distance_to(prev_vel) > 600:
				_velocity = bounce_vel
				
				#explosiin
				var spark
				if Input.get_action_strength("p1_shield") and player_id==0 or Input.get_action_strength("p2_shield") and player_id==1:
					if collision.normal==Vector2(0,-1):
						is_on_ground = true
					tech()
					spark = sparks2.instance()
				else:
					spark = sparks.instance()
				spark.position = self.position
				spark.scale = Vector2(2, 2)
				get_node("/root/Node2D/fx").add_child(spark)
			else:
				_velocity = _velocity.slide(collision.normal)
				position += collision.get_remainder().length()*_velocity.normalized()
				is_on_ground = true
		else:
			is_on_ground=false
	else:
		z_index=1
		_velocity = move_and_slide(_velocity, Vector2.UP)
		is_on_ground = is_on_floor()
	

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
		return Vector2(
			Input.get_action_strength("p1_c_right")-Input.get_action_strength("p1_c_left"),
			Input.get_action_strength("p1_c_down")-Input.get_action_strength("p1_c_up") #is_on_floor updated by moveandslide
		)
	else:
		return Vector2(
			Input.get_action_strength("p2_c_right")-Input.get_action_strength("p2_c_left"),
			Input.get_action_strength("p2_c_down")-Input.get_action_strength("p2_c_up") #is_on_floor updated by moveandslide
		)

func calculate_move_velocity(): #basically do movement input stuff
	if is_on_ground:
		double_jump = 1
		if state==0:
			anim_player.play("standing")
			
	
	# FLIP
	if state==0 and is_on_ground and not direction.y>0:
		flip()
	
	# MOVE X
	if is_on_ground:
		if state == 0:
			_velocity.x += direction.x * groundspeed
	else:
		if state !=2:
			_velocity.x += direction.x * airspeed

	#friction
	if is_on_ground:
		_velocity *= groundfriction
	else:#if not state==2:
		_velocity.x *= airfriction
		_velocity.y *= yfriction
	if state==2:
		_velocity.y += gravity*0.6
		#if _velocity.y>gravity*10:
		#	_velocity.y = gravity*10
	else:
		_velocity.y += gravity
	
	
	# MOVE Y
	#if not direction.y>0:
	set_collision_mask_bit(4,1)
	
	if (Input.get_action_strength("p1_jump") and player_id==0 or Input.get_action_strength("p2_jump") and player_id==1):
		if released_jump == true and (state == 0):
			if is_on_ground:
				_velocity.y = -jumpspeed
				anim_player.stop(true) #resets animation
				anim_player.play("jump")
				released_jump = false
				is_on_ground = false
			elif released_jump == true and is_on_wall():
				wallJump()
				released_jump = false
			elif released_jump == true and double_jump == 1:
				_velocity.y = -jumpspeed
				anim_player.stop(true) #resets animation
				anim_player.play("double_jump")
				double_jump -= 1
				released_jump = false
				#effect
				var ring = jump_ring.instance()
				ring.position = self.position
				ring.z_index = -2
				get_node("/root/Node2D/fx").add_child(ring)
		if state == 1 and can_walljump and is_on_wall():
			wallJump()
	elif released_jump==false:
		released_jump = true
		if _velocity.y<0:
			_velocity.y*=0.4

func flip():
	if direction.x>0:
		transform.x.x = 1
	if direction.x<0:
		transform.x.x = -1

func wallJump():
	if state==1:
		$currentAttack.interrupted = true
		$currentAttack.endAttack(self)
		resetToIdle()
	_velocity.y = -jumpspeed
	if position.x>0:
		_velocity.x = 500
	else:
		_velocity.x = -500
	anim_player.stop(true) #resets animation
	anim_player.play("double_jump")
	released_jump = false
	
func respawn():
	percentage = 0
	$Label.text = str(percentage)+"%"
	shieldHealth = shieldHealthMax
	intangible = false
	$sprite.modulate = sprite_color
	position = Vector2(0,0)
	_velocity = Vector2(0,0)
	if state==1:
		$currentAttack.interrupted = true
		$currentAttack.endAttack(self)
	resetToIdle()

func resetToIdle():
	state=0
	stateTimer=0
	$Shield.visible = false
	anim_player.stop(true) #resets animation
	anim_player.play("standing")
	if not is_on_ground:
		pass#
		#anim_player.play("jump") #questionable
	
func tech():
	#_velocity = Vector2(0,0)
	dodge()
				
func attack():
	pass
func special():
	pass
func grab(): #brag
	can_walljump = false
	state = 1
	stateTimer = 0
	$currentAttack.set_script(grab)
func shield():
	if is_on_ground:
		state = 3
		stateTimer = 0
		$Shield.visible = true
		anim_player.stop(true) #resets animation
		anim_player.play("standing")
	else:
		airdodge()
func shieldEnd():
	resetToIdle()

func airdodge():
	is_on_ground = false
	state = 4
	stateTimer = 0
	$Shield.visible = false
	$sprite.modulate = sprite_color+Color(0.5,0.5,0.5,0)
	intangible = true
	var dodge_direction = direction.normalized()
	_velocity = dodge_direction*1000
	anim_player.stop(true)
	anim_player.play("roll")
	

func dodge():
	state = 4
	stateTimer = 0
	$Shield.visible = false
	$sprite.modulate = sprite_color+Color(0.5,0.5,0.5,0)
	intangible = true
	anim_player.stop(true)
	if direction.x!=0:
		var dodge_direction = Vector2(direction.x,0).normalized()
		_velocity = dodge_direction*1000
		#transform.x.x = -dodge_direction.x #fucks up wavedashes. do it frame 4
		anim_player.play("roll")
	else:
		_velocity = Vector2(0,0)
		anim_player.play("stunned")

func CheckHurtBoxes() -> Array:
	var HitActors = []
	#print($HurtBox.get_overlapping_areas())
	for hitbox in $HurtBox.get_overlapping_areas():
		var opponent=hitbox.get_parent().get_parent()
		
		if opponent.team != self.team and intangible == false:
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
		var kb = data["kb"] + data["kbscaling"]*percentage
		nextFrameHitPause += hitpauseFormula(kb) #+= for trades and stuff?
		opponent.nextFrameHitPause += hitpauseFormula(kb)
		
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
		var kb = (data["kb"] + data["kbscaling"]*percentage)
		if kb:
			var blast
			if(not state==3):
				kb_vector = Vector2(cos(angle)*opponent.transform.x.x, -sin(angle))*10*kb
				totalHitstun = kb*0.2
				state = 2
				stateTimer = 0
				percentage += data["damage"]
				$Label.text = str(percentage)+"%"
				anim_player.stop(true) #resets animation
				anim_player.play("standing")
				anim_player.stop(true)
				anim_player.play("shake")
				$"/root/Node2D/AudioStreamPlayer".playSound($"/root/Node2D/AudioStreamPlayer".punch, 100/kb)
				blast = explosion.instance()
			else:
				shieldHealth -= data["damage"]*3
				shieldStun = data["damage"]*2
				$Shield.modulate=Color(0.7,0.7,0.7)
				$"/root/Node2D/AudioStreamPlayer".playSound($"/root/Node2D/AudioStreamPlayer".shieldHit, 100/kb)
				blast = explosion2.instance()
			#explosiin
			blast.position = self.position
			blast.scale = Vector2(kb*0.02, kb*0.02)
			blast.z_index = -2
			get_node("/root/Node2D/fx").add_child(blast)
		
		opponent.get_node("currentAttack").onHit(data["name"], self, (state==3))
	
	
	if position.y>1000:
		respawn()
	if position.y<-750:
		respawn()
	if position.x>1500:
		respawn()
	if position.x<-1500:
		respawn()
		
	if state==3:
		if(shieldStun > 0):
			shieldStun-= 1
		else:
			$Shield.modulate=Color(1,1,1)
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
			anim_player.stop(true)
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
				resetToIdle()
	if hitPause>0:
		hitPause-=1
		#position+=direction #asdi #test_move ( 
		#_velocity+=direction #this is not di this is just weird
		if hitPause<=0:
			hitPause=0
			anim_player.play()
			if state==2:
				anim_player.play("stunned")
				# DI
				rng.randomize() #test
				var my_random_number = rng.randf_range(0.0, 6.28) #test
				var new_angle = kb_vector.angle() + sin(kb_vector.angle_to(Vector2(sin(my_random_number),cos(my_random_number))))*0.2 #test
				#var new_angle = kb_vector.angle() + sin(kb_vector.angle_to(direction))*0.2 #.1 to .2
				kb_vector = Vector2(cos(new_angle), sin(new_angle))*kb_vector.length()
				_velocity = kb_vector

func hitpauseFormula(kb):
	return kb*0.05+2
