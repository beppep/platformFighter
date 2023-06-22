extends KinematicBody2D



var explosion = load("res://source/fx/explosion.tscn")



export var gravity = 0.0
var _velocity = Vector2(400,-400)
var bannedHitboxes = []
var HitActors = []
var hitPause = 0
var nextFrameHitPause = 0
var kb_vector = Vector2(0,0)
var team = 0
var state = 0
var stateTimer = 0
var currentAttack
var player

var sleepDart = false

onready var anim_sprite = $AnimatedSprite #basically just declared in _ready func

# Called when the node enters the scene tree for the first time.
func attackWith(scriptName):
	currentAttack = load("res://source/characters/Oculus/"+scriptName+".gd").new()
	currentAttack.player = self
	
func inputAction():	
	
	if(nextFrameHitPause):
		hitPause=nextFrameHitPause
		nextFrameHitPause=0
	if hitPause:
		return
	
	#_velocity.y += gravity
	if is_instance_valid(player):
		_velocity += (player.position - position) * 0.02
	else:
		if state!=2:
			anim_sprite.play("break")
			state = 2
			stateTimer = 0
	if state==2 and stateTimer == 20:
		queue_free()
		if is_instance_valid(player):
			player.eyeball = null
	_velocity *=0.9
	var collision = move_and_collide(_velocity*1/60)
	if collision:
		pass #queue_free()
	
	if position.y>1000:
		queue_free()
	if position.y<-750:
		queue_free()
	if position.x>1500:
		queue_free()
	if position.x<-1500:
		queue_free()


func CheckHurtBoxes() -> Array:
	var HitActors = []
	#print($HurtBox.get_overlapping_areas())
	for hitbox in $HurtBox.get_overlapping_areas():
		var opponent=hitbox.get_parent().get_parent()
		
		if opponent.team != team:
			var data = opponent.currentAttack.hitboxes[int(hitbox["name"])] #invalid get index 169 on base array apparently #also 1
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
	if state==1 and hitPause==0:
		currentAttack.endAttack()
	if HitActors:
		var data = HitActors[0][0]
		var opponent = HitActors[0][1]
		
		if state == 1:
			currentAttack.interrupted = true
			currentAttack.endAttack()
		var angle = data["angle"]*PI/180
		var kb = (data["kb"])
		if kb:
			var blast
			$"/root/Node2D/Camera2D".screenShake = int(kb/20)
			$"/root/Node2D/AudioStreamPlayerLow".playSound($"/root/Node2D/AudioStreamPlayerLow".punch, 0.5+100/kb)
			blast = explosion.instance()
			#explosiin
			blast.position = self.position
			blast.scale = Vector2(kb*0.02, kb*0.02)
			blast.z_index = -2
			get_node("/root/Node2D/fx").add_child(blast)
		state = 2
		stateTimer = 0
		opponent.currentAttack.onHit(data["name"], self, (state==3))
		opponent.onHit(data["name"], self, (state==3))
			
	#progress states
	if hitPause==0:
		stateTimer+=1
	if hitPause>0:
		hitPause-=1
		if hitPause<=0:
			hitPause=0
			#queue_free()
			
func getGrabbed():
	return false

func hitpauseFormula(kb):
	return kb*0.06+2
