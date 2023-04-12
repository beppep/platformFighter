extends KinematicBody2D
class_name Character

#tech timing
#finite downb froat
#side b bakåt i luften
#respawn time
var rng = RandomNumberGenerator.new()

var explosion = load("res://source/fx/explosion.tscn")
var explosion2 = load("res://source/fx/explosion2.tscn")
var blastline = load("res://source/fx/deathblast.tscn")
var jump_ring = load("res://source/fx/jump_ring.tscn")
var sparks = load("res://source/fx/sparks.tscn")
var sparks2 = load("res://source/fx/sparks2.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (float) var gravity = 80.0 #per second squared
export (float) var airspeed = 20.0
export (float) var groundspeed = 100.0
export (float) var maxspeed = 1000.0
export (float) var jumpspeed = 1000.0
export (float) var fallspeed = 1000.0
export (float) var groundfriction = 0.8
export (float) var airfriction = 0.98
export (float) var yfriction = 0.95
export (int) var player_id = 0
export (int) var team = 0
var sprite_color = Color(1,1,1)
var _velocity = Vector2(0,-100) #pixels per second
var direction = Vector2.ZERO
var c_direction = Vector2.ZERO
var buttons = [0,0,0,0,0]
var buffers = [99,99,99,99,99]
var released_jump = false
var double_jumps = 1
var can_walljump = true
var cant_hitfall = false
enum states {
	actionable,
	attacking,
	hitstun,
	shield,
	dodge,
	grabbed,
	landinglag,
	lying,
	wallHogging,
	jumpsquat,
}
var stocks = 4
var state = states.actionable
var attacks = {}
var currentAttack = false
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
var intangible = false
var intangibleFrames = 0
var is_on_ground = false
var dontShield = true
var grab_target = null
var dodge_direction
var has_airdodge = 1
var wallJumps = jumpspeed / 2
var can_shield_float = false
var can_getupattack = false
var ghosted = false
var walljump_facing = 1
var jablocked = 0
var dummyOpponent = 0

#func process:...::
#	match state:
	#	states.actionable:
#			idle()
#			if buttons[3]:
	#			state = states.shield
#				
#		states.shield:
			
			
			

# Monk elemental conditions

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
		sprite_color=Color(0.8,0.8,1.3)
		anim_sprite.modulate=sprite_color


func onHit(name, target, shielded=false):
	pass
	#double_jumps = 1
	wallJumps = jumpspeed/2
	#has_airdodge = 1

func regain_resources(): # i.e. while grounded
	pass

func characterInputAction():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func inputAction():
	# input 
	
	buttons = get_buttons()
	for i in range(len(buttons)):
		if buttons[i]:
			buffers[i] = 0
		else:
			buffers[i] += 1
	direction = get_direction()
	c_direction = get_c_direction()
	
	# hitpause
	if(nextFrameHitPause):
		hitPause=nextFrameHitPause
		if state==states.hitstun:
			anim_sprite.play("hurt")
			anim_player.stop(true)
			anim_player.play("shake")
		else:
			anim_sprite.stop()
		nextFrameHitPause=0
		if direction.y>0.9 and not cant_hitfall: #hitfalling
			_velocity.y = fallspeed*1
	if hitPause:
		return
	
	characterInputAction()
	
	# movement
	if not (state==states.dodge and stateTimer<20):
		calculate_move_velocity()
	# options
	if not buttons[3]:
		dontShield = false
	if state == states.wallHogging:
		print(states.wallHogging)
		_velocity = Vector2(0,50)
		if not buttons[0]:
			endWallJump()
		if buttons[3]:
			pass
	if state==states.actionable:
		if buttons[3] and not dontShield:
			shield()
		elif buttons[4] or buffers[4]<5:
			grab()
		elif buttons[1] or buffers[1]<5 or c_direction!=Vector2(0,0):
			attack()
		elif buttons[2] or buffers[2]<5:
			special()
	if state==states.shield and shieldStun < 1:
		if not is_on_ground:
			_velocity*=0.95
			_velocity.y-=50
		if buttons[4]: # shield grab
			shieldEnd()
			grab()
		elif not buttons[3]: # drop shield
			shieldEnd()
		elif not is_on_ground: # shield float
			if can_shield_float:
				if buttons[0]:
					_velocity.y-=30
					shieldHealth-=1
					released_jump = false
			else:
				shieldEnd()
				state = 2
				stateTimer = 0
				totalHitstun = 30
				totalLandingLag = 0
				anim_sprite.play("stunned")
		elif is_on_ground:
			if buttons[0]:
				$Shield.visible = false
				jump()
			elif direction.y>0.8 or direction.x!=0 and not (buttons[1] or buttons[2]):
				dodge()
			elif direction.y<-0.8: #shield drop
				#set_collision_mask_bit(4,0)
				#shieldEnd()
				#dontShield=true
				#is_on_ground = false
				pass
	if state==states.attacking:
		currentAttack.manageHitboxes()
		currentAttack.update()
	if state == states.dodge:
		# roll cancel wavedash
		if stateTimer < 3:
			if buttons[0]:
				if is_on_ground and not direction.y<0:
					intangible = false
					anim_sprite.modulate = sprite_color
					is_on_ground = true
					state = states.landinglag
					stateTimer = 0
					totalLandingLag = 10
					_velocity = direction.normalized()*1000
					#dontShield = true
					released_jump = false
					$"/root/Node2D/AudioStreamPlayerLow".playSound($"/root/Node2D/AudioStreamPlayer".waveland)
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
	if state==states.lying:
		if stateTimer>40:
			if can_getupattack and buttons[1]:
				attackWith("getupa")
			elif (direction!=Vector2.ZERO or buttons[3] or buttons[1]):
				tech()
			jablocked = 0
	if state==states.landinglag:
		anim_sprite.play("land")
	if state==states.jumpsquat:
		anim_sprite.play("land")
		if stateTimer==5:
			if buttons[0]:
				_velocity.y = -jumpspeed
				released_jump = false
			else:
				_velocity.y = -jumpspeed*0.6
			state = states.actionable
			anim_sprite.play("jump")
			anim_sprite.play("doublejump")
			
	# MOVE
	
	if state==states.dodge and stateTimer<8:
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
			if collision:
				if collision.normal==Vector2.UP: #waveland on walls?
					#print("waveland")
					anim_sprite.modulate = sprite_color
					intangible = false
					#dontShield = true
					#if collision.normal==Vector2.UP:
					is_on_ground = true
					_velocity = _velocity.slide(collision.normal)
					state = states.landinglag
					stateTimer = 0
					totalLandingLag = 10
					$"/root/Node2D/AudioStreamPlayerLow".playSound($"/root/Node2D/AudioStreamPlayer".waveland)
				else:
					position += collision.get_remainder().slide(collision.normal)
		else:
			move_and_slide(_velocity)
	elif state==states.hitstun:
		z_index=0
		var collision = move_and_collide(_velocity*1/60)
		if collision:
			var prev_vel = _velocity
			var bounce_vel = _velocity.bounce(collision.normal)
			if prev_vel.length() > 600 or (collision.normal!=Vector2(0,-1) and buttons[3]):
				_velocity = bounce_vel
				
				#explosiin
				var spark
				if not is_on_ground:
					if buttons[3]: # teching correctly
						if collision.normal==Vector2(0,-1):
							is_on_ground = true
							tech()
						else:
							if buttons[0] and canWallJump(position.x):
								wallJump()
								released_jump = false
							else:
								_velocity = Vector2(0,-100)
							state=0
							stateTimer=0
							dontShield = true
						spark = sparks2.instance()
						$"/root/Node2D/AudioStreamPlayer".playSound($"/root/Node2D/AudioStreamPlayer".tech)
					else:
						if collision.normal==Vector2(0,-1) and prev_vel.length() < 1600: # missed tech situation
							is_on_ground = true
							percentage += 1
							_velocity = Vector2.ZERO
							state = 7
							stateTimer = 10
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
	if state==states.grabbed:
		$Shield.visible = false
		z_index=0
		anim_sprite.play("roll")
	
func get_buttons():
	if dummyOpponent==player_id:
		rng.randomize() #test
		return [(rng.randf()<0.1 or position.y>300 and rng.randf()<0.9),(rng.randf()<0.3),(rng.randf()<0.1 or position.y>300 and rng.randf()<0.99),(rng.randf()<0.1),(rng.randf()<0.1)] #test
		
	if player_id==0:
		return [Input.get_action_strength("p1_jump"),Input.get_action_strength("p1_a"),Input.get_action_strength("p1_b"),Input.get_action_strength("p1_shield"),Input.get_action_strength("p1_z")]
	else:
		return [Input.get_action_strength("p2_jump"),Input.get_action_strength("p2_a"),Input.get_action_strength("p2_b"),Input.get_action_strength("p2_shield"),Input.get_action_strength("p2_z")]
func get_direction():
	if dummyOpponent==player_id:
		var my_random_number = rng.randf_range(0.0, 2*PI) #test
		if position.y>200 or abs(position.x) > 300:
			if position.x >0:
				return Vector2(-0.7,-0.7)*rng.randf() #test
			else:
				return Vector2(0.7,-0.7)*rng.randf() #test
		else:
			return Vector2(sin(my_random_number),cos(my_random_number))*max(0,rng.randf()-0.5) #test
		
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
		double_jumps = 1
		wallJumps = jumpspeed / 2
		has_airdodge = 1
		regain_resources()
	else:
		if state==6 or state==7:
			resetToIdle()
			
	
	# FLIP
	if state==0 and is_on_ground and not direction.y>0:
		flip()
	
	# MOVE X
	if is_on_ground:
		if state == states.actionable:
			if direction.x > 0.1 and _velocity.x < maxspeed:
				_velocity.x += direction.x * groundspeed
			if direction.x < -0.1 and _velocity.x > -maxspeed:
				_velocity.x += direction.x * groundspeed
			if direction.x:
				anim_sprite.play("run")
			else:
				anim_sprite.play("standing")
	else:
		if state != 2:
			if direction.x > 0.1 and _velocity.x < maxspeed:
				_velocity.x += airspeed
			if direction.x < -0.1 and _velocity.x > -maxspeed:
				_velocity.x -= airspeed

	#friction
	if is_on_ground and not state==states.jumpsquat:
		_velocity *= groundfriction
	else:
		if state==2:
			_velocity.x *= 0.98
		else:
			_velocity.x *= airfriction
			_velocity.y *= yfriction
	if state==2:
		if _velocity.y<fallspeed:
			var personalGravityPart = 0.3 # lerped with 55
			_velocity.y += gravity*personalGravityPart + 55*(1-personalGravityPart)  #(gravity*0.6 + 70*0.6)/2
		if _velocity.y>0:
			pass
			#_velocity.y *= yfriction
	else:
		if _velocity.y<fallspeed:
			_velocity.y += gravity
		if 0<_velocity.y and _velocity.y<fallspeed*1.5+100 and direction.y>0.9:
			_velocity.y += gravity
	
	
	# MOVE Y
	if direction.y > 0.9 and ((state == states.actionable and not buttons[1]) or not is_on_ground) and not state == states.dodge:#
		set_collision_mask_bit(4,0)
	else:
		set_collision_mask_bit(4,1)
	
	if buttons[0]: #jumping
		# check ways to jump
		if (state == 0 or (state == 1 and stateTimer<=2 and false)):
			if is_on_ground and released_jump == true:
				jump()
			elif is_on_wall() and wallJumps>0 and canWallJump(position.x):
				wallJump()
			elif released_jump == true and double_jumps>0:
				double_jump()
		if state == 1 and can_walljump and is_on_wall() and wallJumps>0 and canWallJump(position.x):
			currentAttack.interrupted = true
			currentAttack.endAttack()
			wallJump()
	elif released_jump == false:
		released_jump = true
		

func flip():
	if (direction.x>0 and c_direction.x==0 or c_direction.x>0) and transform.x.x == -1 or (direction.x<0 and c_direction.x==0 or c_direction.x<0) and transform.x.x == 1:
		transform.x.x *= -1
func reverse():
	if direction.x>0 and transform.x.x == -1 or direction.x<0 and transform.x.x == 1:
		transform.x.x *= -1
		_velocity.x *= -1
func jump():
	anim_sprite.play("jump")
	released_jump = false
	state = states.jumpsquat
	stateTimer = 0
func double_jump():
	released_jump = false
	_velocity.y = -jumpspeed * 0.9
	if direction.x * _velocity.x < 0:
		_velocity.x = direction.x * jumpspeed*0.1
	anim_sprite.play("double_jump")
	double_jumps -= 1
	#effect
	var ring = jump_ring.instance()
	ring.position = self.position + Vector2(0,50)
	ring.z_index = -2
	get_node("/root/Node2D/fx").add_child(ring)
func canWallJump(r):
	if r>0:
		return not $"/root/Node2D".rightHog
	else:
		return not $"/root/Node2D".leftHog
func wallJump():
	released_jump = false
	state = states.wallHogging
	stateTimer = 0
	_velocity = Vector2(0,10)
	anim_sprite.play("wallhog")
	if position.x>0:
		transform.x.x = -1 * walljump_facing
		$"/root/Node2D".rightHog = true
		$"/root/Node2D".rightHogger = self
	else:
		transform.x.x = 1 * walljump_facing
		$"/root/Node2D".leftHog = true
		$"/root/Node2D".leftHogger = self
func endWallJump():
	state = states.actionable
	stateTimer = 0
	_velocity.y = -wallJumps
	wallJumps-=50
	if wallJumps<0:
		wallJumps = 0
	if position.x>0:
		#$"/root/Node2D".rightHog = false
		_velocity.x = 400
	else:
		#$"/root/Node2D".leftHog = false
		_velocity.x = -400
	anim_sprite.play("jump")

func resetToIdle():
	state=0
	stateTimer=0
	if is_on_ground:
		anim_sprite.play("standing")
	else:
		anim_sprite.play("jump")
	
func tech():
	#_velocity = Vector2(0,0)
	dodge()
				
func attack():
	pass
func special():
	pass
func grab():
	pass
func attackWith(script):
	grab_target = null
	#can_walljump = false
	cant_hitfall = false
	state = 1
	stateTimer = 0
	currentAttack = attacks[script].new()
	currentAttack.player = self
	
func shield():
	if direction==Vector2.ZERO and can_shield_float:
		_velocity*=0.5
	if is_on_ground or (direction==Vector2.ZERO and can_shield_float):
		state = 3
		stateTimer = 0
		$Shield.visible = true
		anim_sprite.play("standing")
	elif has_airdodge>0:
		airdodge()
func shieldEnd():
	$Shield.visible = false
	state = 6
	stateTimer = 0
	totalLandingLag = 10
	anim_sprite.play("land")
	

func airdodge():
	is_on_ground = false
	set_collision_mask_bit(4,1)
	state = 4
	stateTimer = 0
	$Shield.visible = false
	anim_sprite.modulate = sprite_color+Color(0.5,0.5,0.5,0)
	intangible = true
	#released_jump = false
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
		anim_sprite.play("spotdodge")

func CheckHurtBoxes() -> Array:
	var HitActors = []
	for hitbox in $HurtBox.get_overlapping_areas():
		var opponent=hitbox.get_parent().get_parent()
		
		if opponent.team != team and intangible == false:
			#print(opponent.currentAttack,opponent.currentAttack.hitboxes,int(hitbox["name"]))
			var data = opponent.currentAttack.hitboxes[int(hitbox.name)] #invalid get index 169 on base array apparently #also 1, 6, 0, 738 etc
			if not [opponent, data["group"]] in bannedHitboxes:
				HitActors.append([data,opponent])
				bannedHitboxes.append([opponent,data["group"]])
			else:
				pass
		
	return HitActors

func hitCollision():			
	# hitting
	HitActors = CheckHurtBoxes()
	if HitActors:
		var data = HitActors[0][0]
		var opponent = HitActors[0][1]
		var kb = data["kb"] + data["kbscaling"]*percentage
		if kb>0:
			nextFrameHitPause = max(nextFrameHitPause, hitpauseFormula(kb))
			opponent.nextFrameHitPause = max(opponent.nextFrameHitPause, hitpauseFormula(kb))
		if "extrahitpause" in data and state!=states.shield:
			nextFrameHitPause += data["extrahitpause"]
			opponent.nextFrameHitPause += data["extrahitpause"]
		if "electric" in data:
			nextFrameHitPause += data["electric"]
				

func getGrabbed():
	if currentAttack:
		currentAttack.interrupted = true
		currentAttack.endAttack()
	state = 5 #you are doll and cant tech or stuff
	stateTimer = 0
	return true

func hitEffect():
	if state==1:# and hitPause==0:# ?????
		currentAttack.endAttack()
	if HitActors:
		
		var data = HitActors[0][0]
		var opponent = HitActors[0][1]
		
		var angle = data["angle"]*PI/180
		var kb = (data["kb"] + data["kbscaling"]*percentage)
		if kb>0:
			var blast
			if state == 1:
				currentAttack.interrupted = true
				currentAttack.endAttack()
			if state == states.wallHogging:
				if position.x>0:
					pass
					#$"/root/Node2D".rightHog = false
				else:
					pass
					#$"/root/Node2D".leftHog = false
			if state==states.lying and jablocked < 3:
				jablocked +=1
				anim_player.play("shake") # ???
			else:
				jablocked = 0
			if (not state==3):# or data["unshieldable"]:
				kb_vector = Vector2(0,-1)*(gravity/30)*pow(kb,0.9) + Vector2(cos(angle)*opponent.transform.x.x, -sin(angle))*2.7 *pow(kb,1.2) # not += imo
				totalHitstun = hitstunFormula(kb)
				state = 2
				stateTimer = 0
				percentage += data["damage"]
				
				$"/root/Node2D/Camera2D".screenShake = int(kb/20)
				$"/root/Node2D/AudioStreamPlayerLow".playSound($"/root/Node2D/AudioStreamPlayerLow".punch, 0.5+100/kb)
				$"/root/Node2D/AudioStreamPlayer".playSound($"/root/Node2D/AudioStreamPlayer".rocks, 0.5+100/kb)
				blast = explosion.instance()
			else:
				_velocity.x += data["kb"]*cos(angle)*opponent.transform.x.x
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
		elif (not state==3):
			percentage += data["damage"]
		wallJumps = jumpspeed
		has_airdodge = 1
		opponent.currentAttack.onHit(data["name"], self, (state==3))
		opponent.onHit(data["name"], self, (state==3))
		if (not state==3):# or data["unshieldable"]:
			autolink_vector = Vector2.ZERO
			if "autolinkX" in data and data["autolinkX"]>0:
				autolink_vector.x = data["autolinkX"]*opponent._velocity.x
			if "autolinkY" in data and data["autolinkY"]>0:
				autolink_vector.y = data["autolinkY"]*opponent._velocity.y
	
	if position.y>$"/root/Node2D".blastzoneDown:
		die(0)
	if position.y<$"/root/Node2D".blastzoneUp and state == 2:
		die(180)
	if position.x>$"/root/Node2D".blastzoneX:
		die(270)
	if position.x<-$"/root/Node2D".blastzoneX:
		die(90)
	
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
		
	if intangibleFrames>0:
		intangibleFrames -= 1
		if intangibleFrames>1:
			intangible = true
			anim_sprite.modulate = sprite_color+Color(0.5,0.5,0.5,0)
	if intangibleFrames == 1:
		intangible = false
		anim_sprite.modulate = sprite_color
	#progress states
	if hitPause == 0:
		stateTimer += 1
		if state == 2:
			if stateTimer >= totalHitstun:
				if ghosted:
					ghosted = false
					getGhosted()
				else:
					resetToIdle()
					jablocked = 0				
		if state == 6:
			if stateTimer >= totalLandingLag:
				resetToIdle()
	if hitPause > 0:
		hitPause -= 1
		#position+=direction #asdi #test_move ( 
		#_velocity+=direction #this is not di this is just weird
		if hitPause<=0:
			hitPause=0
			if state==2:
				anim_player.stop(true)
				anim_player.play("idle")
				anim_sprite.play("stunned")
				# DI
				var new_angle = kb_vector.angle() + sin(kb_vector.angle_to(direction))*0.1 #.1 to .2
				kb_vector = Vector2(cos(new_angle), sin(new_angle))*kb_vector.length()
				kb_vector = kb_vector + autolink_vector
				if jablocked>0 and kb_vector.length()<500:
					_velocity = Vector2.ZERO
					state = 7
					stateTimer = 0
					anim_sprite.play("lying")
					anim_player.stop(true)
					anim_player.play("shake")
					is_on_ground = true
				else:
					_velocity = kb_vector
					if kb_vector.y<0:
						is_on_ground = false
				kb_vector = Vector2.ZERO
				autolink_vector = Vector2.ZERO
			else:
				anim_sprite.play()

func die(angle):
	make_blastline(angle)
	respawn()
	
func make_blastline(angle):
	var blast = blastline.instance()
	blast.rotation_degrees = angle
	blast.position = position +- Vector2(0,128*8).rotated(deg2rad(angle))
	blast.scale = Vector2(8, 8)
	blast.z_index = -2
	get_node("/root/Node2D/fx").add_child(blast)

func respawn():
	get_node("/root/Node2D/uiElements/ui"+str(player_id)).get_node(str(stocks)).queue_free()
	if stocks>1:
		var new = $"/root/Node2D".chosenCharacters[player_id].instance()
		$"/root/Node2D/Players".add_child(new)
		new.player_id = player_id
		new.team = team
		new._ready2()
		new.position = Vector2(0,$"/root/Node2D".blastzoneUp)
		new.intangibleFrames = 100
		new.intangible = true
		new.stocks = stocks-1
	else:
		get_tree().change_scene("res://source/characterSelect.tscn")
	queue_free()
		

func getGhosted():
	
	$Ghost.visible = false
	#var angle = 90*PI/180 # den e 90
	
	var kb = (90 + 0.6*percentage)
	kb_vector = Vector2(0,-1)*(gravity/30)*pow(kb,0.9) + Vector2(0, -1)*2.7 *pow(kb,1.2) # not += imo
	totalHitstun = hitstunFormula(kb)
	state = 2
	stateTimer = 0
	wallJumps = jumpspeed
	has_airdodge = 1
	nextFrameHitPause = max(nextFrameHitPause, hitpauseFormula(kb))
	$"/root/Node2D/Camera2D".screenShake = int(kb/20)
	$"/root/Node2D/AudioStreamPlayerLow".playSound($"/root/Node2D/AudioStreamPlayerLow".punch, 0.5+100/kb)
	$"/root/Node2D/AudioStreamPlayer".playSound($"/root/Node2D/AudioStreamPlayer".rocks, 0.5+100/kb)
	var blast = explosion.instance()
	percentage += 8
	
	blast.position = self.position
	blast.scale = Vector2(kb*0.02, kb*0.02)
	blast.z_index = -2
	get_node("/root/Node2D/fx").add_child(blast)
	
	
func hitpauseFormula(kb):
	return kb*0.1+3
func hitstunFormula(kb):
	return pow(kb,0.9)*0.4 + 10 # less?
