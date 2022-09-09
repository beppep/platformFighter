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
var myOwner
var currentAttack = false


onready var anim_player: AnimationPlayer = get_node("AnimationPlayer") #basically just declared in _ready func
onready var anim_sprite = get_node("AnimatedSprite") #basically just declared in _ready func

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	z_index = -1

func onHit(name, target, shielded=false):
	pass
	
func inputAction():	
	
	if(nextFrameHitPause):
		hitPause=nextFrameHitPause
		nextFrameHitPause=0
	if hitPause:
		return
	
	if state==1:
		currentAttack.update()
	
	_velocity.x *= 0.98
	_velocity.y += gravity
	_velocity = move_and_slide(_velocity)

func CheckHurtBoxes() -> Array:
	var HitActors = []
	#print($HurtBox.get_overlapping_areas())
	for hitbox in $HurtBox.get_overlapping_areas():
		var opponent=hitbox.get_parent().get_parent()
		
		if opponent.team != self.team:
			var data = opponent.currentAttack.hitboxes[int(hitbox["name"])] #invalid get index 169 on base array apparently
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
		currentAttack.endAttack()
	if HitActors:
		wasHit = true
		var data = HitActors[0][0]
		var opponent = HitActors[0][1]
		
		if state == 1:
			currentAttack.interrupted = true
			currentAttack.endAttack()
		
		var angle = data["angle"]*PI/180
		var kb = (data["kb"] + data["kbscaling"]*myOwner.percentage)
		myOwner.percentage += data["damage"]
		if kb:
			kb_vector = Vector2(cos(angle)*opponent.transform.x.x, -sin(angle))*10*kb
			if true:
				kb_vector = Vector2(cos(angle)*opponent.transform.x.x, -sin(angle))*1*kb
			totalHitstun = kb*0.3
			state = 2
			stateTimer = 0
			
			$"/root/Node2D/AudioStreamPlayerLow".playSound($"/root/Node2D/AudioStreamPlayerLow".punch, 100/kb)

			opponent.currentAttack.onHit(data["name"], self, false)
			#explosiin
			var blast = explosion.instance()
			blast.position = self.position
			blast.scale = Vector2(kb*0.02, kb*0.02)
			blast.z_index = -2
			get_node("/root/Node2D/fx").add_child(blast)
		
	
	if position.y>1000:
		queue_free()
		myOwner.shroomList.erase(self)
	#if position.y<-750:
		#queue_free()
		#myOwner.shroomList.erase(self)queue_free()
	if position.x>1500:
		queue_free()
		myOwner.shroomList.erase(self)
	if position.x<-1500:
		queue_free()
		myOwner.shroomList.erase(self)
	
	
	#progress states
	if hitPause==0:
		stateTimer+=1
		if state == 2:
			if stateTimer >= totalHitstun:
				state = 0
				stateTimer = 0
				
	if hitPause>0:
		hitPause-=1
		if hitPause<=0:
			hitPause=0
			anim_player.play()
			if state==2:
				anim_player.play("stunned")
				_velocity = kb_vector
				wasHit = false
