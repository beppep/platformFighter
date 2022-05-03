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
export var fallspeed = 1000.0
export var groundfriction = 0.8
export var airfriction = 0.98
export var yfriction = 0.95
export var player_id = 0
export var team = 0
var sprite_color = Color(1,1,1)
var _velocity = Vector2(0,-100) #pixels per second
var direction = Vector2.ZERO
var c_direction = Vector2.ZERO
var buttons = [0,0,0,0]
var released_jump = false
var double_jump = 1
var can_walljump = false
var cant_hitfall = false
var state = 0 #0: actionable, 1:attacking, 2:hitstun 3:shield, 4:dodge, 5:grabbed?, 6:landinglag, 7:lying, 8:shieldlag
var currentAttack = "error"
var stateTimer = 0
var totalHitstun = 0
var totalLandingLag = 0
var hitPause = 0 #descends
var nextFrameHitPause = 0
var bannedHitboxes = []
var HitActors = []
var percentage = 0
var shieldHealthMax = 150.0
var shieldHealth = shieldHealthMax
var shieldStun = 0
var kb_vector = Vector2(0,0) # to be applied after hitpause
var autolink_vector = Vector2(0,0) # to apply autolink after hitpause
var autolink_player
var intangible = false
var is_on_ground = true
var dontShield = true
var grab_target
var dodge_direction
var fullhop_timer = 0
var B_charged = true
var has_airdodge = 1
var wallJumps = jumpspeed*0.9

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer") #basically just declared in _ready func
onready var anim_sprite = $AnimatedSprite #basically just declared in _ready func

"""
If updating both an animation and a separate property at once (for example, a platformer may update the sprite's h_flip/v_flip properties when a character turns while starting a 'turning' animation), it's important to keep in mind that play() isn't applied instantly. Instead, it's applied the next time the AnimationPlayer is processed. This may end up being on the next frame, causing a 'glitch' frame, where the property change was applied but the animation was not. If this turns out to be a problem, after calling play(), you can call advance(0) to update the animation immediately.
"""


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _ready2():
	if team==1:
		sprite_color=Color(0.9,0.9,1.2)
		anim_sprite.modulate=sprite_color
	$Label.text = str(percentage)+"%"


func onHit(name, target, shielded=false):
	pass
	#double_jump = 1
	wallJumps = jumpspeed
	B_charged = true
	has_airdodge = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func inputAction():
	# input 
	buttons = get_buttons()
	direction = get_direction()
	c_direction = get_c_direction()
	
	# hitpause
	if(nextFrameHitPause):
		if (stateTimer==2 and state==1): #electric shine op lol
			hitPause=nextFrameHitPause*0.6
		else:
			hitPause=nextFrameHitPause
			if state==2:
				anim_sprite.play("hurt")
				anim_player.stop(true)
				anim_player.play("shake")
			else:
				anim_sprite.stop()
		nextFrameHitPause=0
		if direction.y>0 and not cant_hitfall: #hitfalling
			_velocity.y = gravity*20
	if hitPause:
		return
	
	
	# movement
	if not (state==4 and stateTimer<8):
		calculate_move_velocity()
	# options
	if not buttons[3]:
		dontShield = false
	if state==0:
		if buttons[3] and not dontShield:
			shield()
		elif buttons[4]:
			grab()
		else:
			if buttons[1] or c_direction!=Vector2(0,0):
				attack()
			elif buttons[2]:
				special()
	if state==3 and shieldStun < 1:
		if not is_on_ground:
			_velocity*=0.95
			_velocity.y-=50
		if buttons[4]:
			shieldEnd()
			grab()
		elif not buttons[3]:
			shieldEnd()
		elif buttons[0]: #shield float
			if not is_on_ground:
				_velocity.y-=30
				shieldHealth-=1
				released_jump = false
		elif is_on_ground:
			if direction.y>0 or direction.x!=0:
				dodge()
			elif direction.y<0: #shield drop
				set_collision_mask_bit(4,0)
				shieldEnd()
				dontShield=true
				is_on_ground = false
	if state==1:
		$currentAttack.update(self)
	if state == 4:
		# roll cancel wavedash
		if stateTimer < 3:
			if buttons[0]:
				if is_on_ground and not direction.y<0:
					intangible = false
					anim_sprite.modulate = sprite_color
					resetToIdle()
					_velocity = direction.normalized()*1000
					dontShield = true
					released_jump = false
					$"/root/Node2D/AudioStreamPlayer".playSound($"/root/Node2D/AudioStreamPlayer".waveland)
		elif stateTimer==4:
			if is_on_ground and dodge_direction!=Vector2.ZERO:
				transform.x.x = -dodge_direction.x
		if stateTimer == 8:
			_velocity=Vector2.ZERO
		if stateTimer == 20:
			anim_sprite.modulate = sprite_color
			intangible = false
		if stateTimer>30:
			resetToIdle()
	if state==7:
		if stateTimer>20 and (direction!=Vector2.ZERO or buttons[3]):
			tech()
			
	# MOVE
	
	if state==4 and stateTimer<8:
		z_index=0
		if not is_on_ground:
			#waveland
			move_and_collide(Vector2(0,-50)) #rewrite this shit
			var collision = move_and_collide(_velocity*1/60)
			if collision: # hit wall or floor or ceiling
				move_and_collide(Vector2(0,50))
			if not collision:# and _velocity.y>=0: #land snap
				collision = move_and_collide(Vector2(0,100))
				if not collision:
					move_and_collide(Vector2(0,-50))
			if collision and collision.normal==Vector2.UP: #waveland on walls?
				#print("waveland")
				anim_sprite.modulate = sprite_color
				intangible = false
				dontShield = true
				#if collision.normal==Vector2.UP:
				is_on_ground = true
				_velocity = _velocity.slide(collision.normal)
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
			if prev_vel.length() > 700:
				_velocity = bounce_vel
				
				#explosiin
				var spark
				if not is_on_ground:
					if buttons[3]: # teching correctly
						if collision.normal==Vector2(0,-1):
							is_on_ground = true
						tech()
						spark = sparks2.instance()
					else:
						if collision.normal==Vector2(0,-1) and prev_vel.length() < 2000: # missed tech situation
							is_on_ground = true
							_velocity = Vector2.ZERO
							state = 7
							stateTimer = 0
							anim_sprite.play("lying")
							anim_player.stop(true)
							anim_player.play("shake")
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
	if state==5:
		$Shield.visible = false
		z_index=0
		anim_sprite.play("roll")
	
func get_buttons():
	if player_id==0:
		#rng.randomize() #test
		#return [(rng.randf()<0.1),(rng.randf()<0.3),(rng.randf()<0.1),(rng.randf()<0.1),(rng.randf()<0.1)] #test
		
		return [Input.get_action_strength("p1_jump"),Input.get_action_strength("p1_a"),Input.get_action_strength("p1_b"),Input.get_action_strength("p1_shield"),Input.get_action_strength("p1_z")]
	else:
		return [Input.get_action_strength("p2_jump"),Input.get_action_strength("p2_a"),Input.get_action_strength("p2_b"),Input.get_action_strength("p2_shield"),Input.get_action_strength("p2_z")]
func get_direction():
	if player_id==0:
		#var my_random_number = rng.randf_range(0.0, 2*PI) #test
		#return Vector2(sin(my_random_number),cos(my_random_number))*rng.randf() #test
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
		wallJumps = jumpspeed
		B_charged = true
		has_airdodge = 1
	else:
		if state==6 or state==7:
			resetToIdle()
			
	
	# FLIP
	if state==0 and is_on_ground and not direction.y>0:
		flip()
	
	# MOVE X
	if is_on_ground:
		if state == 0:
			_velocity.x += direction.x * groundspeed
			if direction.x:
				anim_sprite.play("run")
				anim_player.play("run")
			else:
				anim_sprite.play("standing")
				anim_player.play("standing")
	else:
		if state == 2:
			_velocity.x += direction.x * airspeed * 0.2
		else:
			_velocity.x += direction.x * airspeed

	#friction
	if is_on_ground:
		_velocity *= groundfriction
	else:
		if not state==2:
			_velocity.x *= airfriction
		_velocity.y *= yfriction
	if state==2:
		if _velocity.y<fallspeed:
			_velocity.y += gravity*0.6
		if _velocity.y>0:
			_velocity.y *= yfriction
	else:
		if _velocity.y>0 and direction.y>0:
			_velocity.y += direction.y * airspeed
		if _velocity.y<fallspeed:
			_velocity.y += gravity
	
	
	# MOVE Y
	set_collision_mask_bit(4,1)
	
	if fullhop_timer>0:
		fullhop_timer-=1
		
	if fullhop_timer == 1: # full hop
		if buttons[0]:
			#position.y += _velocity.y*(1/60)
			_velocity.y*=2
		else:
			position.y -= _velocity.y*(1/60)
			_velocity.y*=0.6
		
		
	if buttons[0]: #jumping
		var jumped = false
		if released_jump == true and (state == 0 or state == 1 and stateTimer<=2):
			if is_on_ground:
				_velocity.y = -jumpspeed*0.6
				fullhop_timer = 5 #time that jump must be held for fullhop
				anim_sprite.play("jump")
				anim_player.play("jump")
				jumped = true
			elif released_jump == true and is_on_wall() and wallJumps:
				wallJump()
				jumped = true
			elif released_jump == true and double_jump == 1:
				_velocity.y = -jumpspeed*0.9
				anim_sprite.play("double_jump")
				anim_player.play("double_jump")
				double_jump -= 1
				jumped = true
				#effect
				var ring = jump_ring.instance()
				ring.position = self.position + Vector2(0,50)
				ring.z_index = -2
				get_node("/root/Node2D/fx").add_child(ring)
		if state == 1 and can_walljump and is_on_wall() and wallJumps:
			wallJump()
			jumped = true
		if jumped:
			is_on_ground = false
			released_jump = false
			if state==1: #jump interrupt attack buffer thing
				print("cancel atack")
				$currentAttack.interrupted = true
				$currentAttack.endAttack(self)
				state=0
				stateTimer=0
	elif released_jump == false:
		released_jump = true
		

func flip():
	if (direction.x>0 or c_direction.x>0) and transform.x.x == -1 or (direction.x<0 or c_direction.x<0) and transform.x.x == 1:
		transform.x.x *= -1
func reverse():
	if direction.x>0 and transform.x.x == -1 or direction.x<0 and transform.x.x == 1:
		transform.x.x *= -1
		_velocity.x *= -1

func wallJump():
	_velocity.y = -wallJumps
	wallJumps-=400
	if wallJumps<0:
		wallJumps = 0
	if position.x>0:
		_velocity.x = 700
	else:
		_velocity.x = -700
	anim_sprite.play("double_jump")
	anim_player.play("double_jump")

func resetToIdle():
	state=0
	stateTimer=0
	if is_on_ground:
		anim_sprite.play("standing")
		anim_player.play("standing")
	else:
		anim_sprite.play("jump")
		anim_player.play("jump")
	
func tech():
	#_velocity = Vector2(0,0)
	dodge()
				
func attack():
	pass
func special():
	pass
func attackWith(script):
	grab_target = false
	can_walljump = false
	cant_hitfall = false
	state = 1
	stateTimer = 0
	$currentAttack.set_script(script)
func grab(): #brag
	grab_target = false
	can_walljump = false
	state = 1
	stateTimer = 0
	$currentAttack.set_script(grab)
func shield():
	if is_on_ground:
		state = 3
		stateTimer = 0
		$Shield.visible = true
		anim_sprite.play("standing")
		anim_player.play("standing")
	elif has_airdodge>0:
		airdodge()
func shieldEnd():
	$Shield.visible = false
	state = 6
	stateTimer = 0
	totalLandingLag = 8
	anim_sprite.play("land")
	

func airdodge():
	is_on_ground = false
	state = 4
	stateTimer = 0
	$Shield.visible = false
	anim_sprite.modulate = sprite_color+Color(0.5,0.5,0.5,0)
	intangible = true
	released_jump = false
	var airdodge_direction = direction.normalized()
	_velocity = airdodge_direction*1000
	dodge_direction=Vector2(0,0)
	anim_sprite.play("roll")
	has_airdodge = 0
	

func dodge():
	state = 4
	stateTimer = 0
	$Shield.visible = false
	anim_sprite.modulate = sprite_color+Color(0.5,0.5,0.5,0)
	intangible = true
	if direction.x!=0:
		dodge_direction = Vector2(direction.x,0).normalized()
		_velocity = dodge_direction*1000
		anim_sprite.play("roll")
	else:
		dodge_direction = Vector2(0,0)
		_velocity = Vector2(0,0)
		anim_sprite.play("stunned")

func CheckHurtBoxes() -> Array:
	var HitActors = []
	#print($HurtBox.get_overlapping_areas())
	for hitbox in $HurtBox.get_overlapping_areas():
		var opponent=hitbox.get_parent().get_parent()
		
		if opponent.team != team and intangible == false:
			var data = opponent.get_node("currentAttack").hitboxes[int(hitbox["name"])] #invalid get index 169 on base array apparently #also 1
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
		nextFrameHitPause = max(nextFrameHitPause, hitpauseFormula(kb)) #+= for trades and stuff?
		opponent.nextFrameHitPause = max(opponent.nextFrameHitPause, hitpauseFormula(kb))
		
func hitEffect():
	if state==1 and hitPause==0:
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
			if (not state==3):# or data["unshieldable"]:
				kb_vector += Vector2(0,-1)*2*pow(kb,0.9) + Vector2(cos(angle)*opponent.transform.x.x, -sin(angle))*2.7 *pow(kb,1.2)
				autolink_vector = Vector2.ZERO
				if "autolinkX" in data and data["autolinkX"]>0:
					autolink_vector.x = data["autolinkX"]
				if "autolinkY" in data and data["autolinkY"]>0:
					autolink_vector.y = data["autolinkY"]
				autolink_player = opponent
				totalHitstun = hitstunFormula(kb)
				state = 2
				stateTimer = 0
				percentage += data["damage"]
				
				$"/root/Node2D/Camera2D".screenShake = int(kb/20)
				$Label.text = str(percentage)+"%"
				$"/root/Node2D/AudioStreamPlayer".playSound($"/root/Node2D/AudioStreamPlayer".punch, 0.5+100/kb)
				blast = explosion.instance()
			else:
				shieldHealth -= data["damage"]*3
				shieldStun = data["damage"]*0+1
				$Shield.modulate=Color(0.7,0.7,0.7)
				$"/root/Node2D/AudioStreamPlayer".playSound($"/root/Node2D/AudioStreamPlayer".shieldHit, 0.5+100/kb)
				blast = explosion2.instance()
			#explosiin
			blast.position = self.position
			blast.scale = Vector2(kb*0.02, kb*0.02)
			blast.z_index = -2
			get_node("/root/Node2D/fx").add_child(blast)
		
		opponent.get_node("currentAttack").onHit(data["name"], self, (state==3))
		opponent.onHit(data["name"], self, (state==3))
	
	
	if position.y>750:
		queue_free()
	if position.y<-750 and state == 2:
		queue_free()
	if position.x>1500:
		queue_free()
	if position.x<-1500:
		queue_free()
	
	if hitPause==0:
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
				anim_sprite.play("stunned")
				
			$Shield.scale=Vector2(shieldHealth/(2*shieldHealthMax),shieldHealth/(2*shieldHealthMax))
		else:
			if(shieldHealth<shieldHealthMax):
				shieldHealth+=0.5
			else:
				shieldHealth-=0.5
			
	#progress states
	if hitPause==0:
		stateTimer+=1
		if state == 2:
			if stateTimer >= totalHitstun:
				resetToIdle()
		if state == 6:
			if stateTimer >= totalLandingLag:
				resetToIdle()
	if hitPause>0:
		hitPause-=1
		#position+=direction #asdi #test_move ( 
		#_velocity+=direction #this is not di this is just weird
		if hitPause<=0:
			hitPause=0
			if state==2:
				anim_sprite.play("stunned")
				# DI
				var new_angle = kb_vector.angle() + sin(kb_vector.angle_to(direction))*0.1 #.1 to .2
				kb_vector = Vector2(cos(new_angle), sin(new_angle))*kb_vector.length()
				if autolink_player:
					if autolink_vector.x!=0:
						kb_vector.x += autolink_player._velocity.x*autolink_vector.x
					if autolink_vector.y!=0:
						kb_vector.y += autolink_player._velocity.y*autolink_vector.y
				_velocity = kb_vector
				kb_vector = Vector2.ZERO
				autolink_vector = Vector2.ZERO
			else:
				anim_sprite.play()

func hitpauseFormula(kb):
	return kb*0.05+2
func hitstunFormula(kb):
	return pow(kb,0.9)*0.4 + 10
