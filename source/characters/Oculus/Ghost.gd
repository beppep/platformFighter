extends CharacterBody2D



var explosion = load("res://source/fx/explosion.tscn")



@export var gravity = 0.0
var _velocity = Vector2(400,-400)
var bannedHitboxes = []
var HitActors = []
var hitPause = 0
var nextFrameHitPause = 0
var kb_vector = Vector2(0,0)
var team = 0
var currentAttack

var sleepDart = false

@onready var anim_sprite = $AnimatedSprite2D #basically just declared in _ready func

# Called when the node enters the scene tree for the first time.
func attackWith(scriptName):
	currentAttack = load("res://source/characters/Cline/"+scriptName+".gd").new()
	currentAttack.player = self

func onHit(name, target, shielded=false):
	if not shielded:
		if "ghosted" in target:
			target.ghosted = true
			target.get_node("Ghost").visible = true
	queue_free()
	
func inputAction():	
	
	if(nextFrameHitPause):
		hitPause=nextFrameHitPause
		nextFrameHitPause=0
	if hitPause:
		return
		
	#_velocity.y += gravity
	var collision = move_and_collide(_velocity*1/60)
	if collision:
		queue_free()
	
	if position.y>1000:
		queue_free()
	if position.y<-750:
		queue_free()
	if position.x>1500:
		queue_free()
	if position.x<-1500:
		queue_free()


func hitCollision():			
	pass
		
func hitEffect():

	if HitActors:
		print("whut")
			
	#progress states
	if hitPause==0:
		pass
	if hitPause>0:
		hitPause-=1
		if hitPause<=0:
			hitPause=0
			queue_free()

func hitpauseFormula(kb):
	return kb*0.06+2
