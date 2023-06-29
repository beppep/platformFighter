extends CharacterBody2D



var explosion = load("res://source/fx/explosion.tscn")

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var _velocity = Vector2(0,-1200)
var hitPause = 0
var nextFrameHitPause = 0
var state = 1
var stateTimer = 0
var team = 0
var ownerPlayer
var upsideDown = false
var bannedHitboxes = []
var grab_target = false
var is_on_ground = false
var intangible = false #?
var HitActors = []
var totalHitstun
var currentAttack
# Called when the node enters the scene tree for the first time.

@onready var anim_sprite = $AnimatedSprite2D #basically just declared in _ready func
@onready var anim_player: AnimationPlayer = get_node("AnimationPlayer") #basically just declared in _ready func


func _ready() -> void:
	pass # Replace with function body.
	z_index = -10+position.y*0.005
	currentAttack = load("res://source/characters/Froat/footAttack.gd").new()
	currentAttack.player = self

func onHit(name, target, shielded=false):
	pass

func inputAction():	
	"""
	if stateTimer<15 and not upsideDown:
		for other in $"/root/Node2D/Players".get_children():
			if other.team == team:
				if get_node("HitBoxes/0").overlaps_body(other):
					other._velocity = Vector2(0,-2000)
					#maybe not reset idk...
					#other.currentAttack.interrupted = true
					#other.currentAttack.endAttack()
					#other.resetToIdle()
	"""
	
	if(nextFrameHitPause):
		hitPause=nextFrameHitPause
		nextFrameHitPause=0
	if hitPause:
		return
		
		
	
	set_velocity(_velocity)
	move_and_slide()
	currentAttack.update()
	
	if state == 2:
		queue_free()
	if position.y>750:
		queue_free()
	if position.y<-750:
		queue_free()

func changeHitbox():
	currentAttack.changeHitbox()

			
			
			

func CheckHurtBoxes() -> Array:
	var HitActors = []
	#print($HurtBox.get_overlapping_areas())
	for hitbox in $HurtBox.get_overlapping_areas():
		var opponent=hitbox.get_parent().get_parent()
		
		if opponent.team != team and intangible == false:
			var data = opponent.currentAttack.hitboxes[int(str(hitbox["name"]))] #invalid get index 169 on base array apparently #also 1
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
			blast = explosion.instantiate()
			#explosiin
			blast.position = self.position
			blast.scale = Vector2(kb*0.02, kb*0.02)
			blast.z_index = -2
			get_node("/root/Node2D/fx").add_child(blast)
		state=2
		opponent.currentAttack.onHit(data["name"], self, (state==3))
		opponent.onHit(data["name"], self, (state==3))
		
		
		
	if hitPause==0:
		currentAttack.endAttack()

	#progress states
	if hitPause==0:
		stateTimer+=1
	if hitPause>0:
		hitPause-=1
		if hitPause<=0:
			hitPause=0
func getGrabbed():
	return false
	
func hitpauseFormula(kb):
	return kb*0.06+2
