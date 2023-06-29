extends CharacterBody2D
class_name HitableBody


var explosion = load("res://source/fx/explosion.tscn")
var explosion2 = load("res://source/fx/explosion2.tscn")
var sparks = load("res://source/fx/sparks.tscn")
var sparks2 = load("res://source/fx/sparks2.tscn")


#export var gravity = 80.0 #per second squared
@export var team = 0


var sprite_color = Color(1,1,1)
var _velocity = Vector2(0,-100) #pixels per second
var state = 0 #0: actionable, 1:attacking, 2:hitstun 3:shield, 4:dodge, 5:grabbed?, 6:landinglag, 7:lying, 8:shieldlag
var currentAttack = "error"
var stateTimer = 0
var totalHitstun = 0
var hitPause = 0 #descends
var nextFrameHitPause = 0
var bannedHitboxes = []
var HitActors = []
var percentage = 0
var kb_vector = Vector2(0,0) # to be applied after hitpause
var autolink_vector = Vector2(0,0) # to apply autolink after hitpause
var autolink_player
var intangible = false
var is_on_ground = false
var grab_target


@onready var anim_player: AnimationPlayer = get_node("AnimationPlayer") #basically just declared in _ready func
@onready var anim_sprite = $AnimatedSprite2D #basically just declared in _ready func

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
func _ready2():
	if team==1:
		sprite_color=Color(0.8,0.8,1.3)
		anim_sprite.modulate=sprite_color
	$Label.text = str(percentage)+"%"


func onHit(name, target, shielded=false):
	pass
func gotHit():
	pass

func inputAction():
	if state==0:
		pass
	
	
	if state==1:
		currentAttack.update()

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
		currentAttack.endAttack()
	if HitActors:
		
		var data = HitActors[0][0]
		var opponent = HitActors[0][1]
		
		if state == 1:
			currentAttack.interrupted = true
			currentAttack.endAttack()
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
				$"/root/Node2D/AudioStreamPlayerLow".playSound($"/root/Node2D/AudioStreamPlayer".punch, 0.5+100/kb)
				$"/root/Node2D/AudioStreamPlayer".playSound($"/root/Node2D/AudioStreamPlayer".rocks, 0.5+100/kb)
				blast = explosion.instantiate()
			else:
				_velocity.x += data["kb"]*cos(angle)*opponent.transform.x.x
				shieldHealth -= data["damage"]*3
				shieldStun = data["damage"]*0+1
				$Shield.modulate=Color(0.7,0.7,0.7)
				$"/root/Node2D/AudioStreamPlayer".playSound($"/root/Node2D/AudioStreamPlayer".shieldHit, 0.5+100/kb)
				blast = explosion2.instantiate()
			#explosiin
			blast.position = self.position
			blast.scale = Vector2(kb*0.02, kb*0.02)
			blast.z_index = -2
			get_node("/root/Node2D/fx").add_child(blast)
		
		opponent.get_node("currentAttack").onHit(data["name"], self, (state==3))
		opponent.onHit(data["name"], self, (state==3))
		gotHit()
	
	
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
	if hitPause == 0:
		stateTimer += 1
		if state == 2:
			if stateTimer >= totalHitstun:
				resetToIdle()
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
				anim_sprite.play("stunned")
				# DI
				var new_angle = kb_vector.angle() + sin(kb_vector.angle_to(direction))*0.1 #.1 to .2
				kb_vector = Vector2(cos(new_angle), sin(new_angle))*kb_vector.length()
				if autolink_player:
					if autolink_vector.x!=0 and autolink_player:
						kb_vector.x += autolink_player._velocity.x*autolink_vector.x
					if autolink_vector.y!=0 and autolink_player:
						kb_vector.y += autolink_player._velocity.y*autolink_vector.y
				_velocity = kb_vector
				kb_vector = Vector2.ZERO
				autolink_vector = Vector2.ZERO
			else:
				anim_sprite.play()


func hitpauseFormula(kb):
	return kb*0.06+2
func hitstunFormula(kb):
	return pow(kb,0.9)*0.4 + 10
