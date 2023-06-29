extends CharacterBody2D

class_name moldSpore

var explosion = load("res://source/fx/explosion.tscn")



@export var gravity = 1
@export var fallspeed = 100
@export var airfriction = 0.999
var _velocity = Vector2(400,-400)
var bannedHitboxes = []
var HitActors = []
var hitPause = 0
var nextFrameHitPause = 0
var kb_vector = Vector2(0,0)
var team = 0
var currentAttack
var myOwner
var timer = 1
var hi_im_a_spore

@onready var anim_sprite = $AnimatedSprite2D #basically just declared in _ready func

# Called when the node enters the scene tree for the first time.
func attackWith(scriptName):
	currentAttack = load("res://source/characters/Svampkoloni/"+scriptName+".gd").new()
	currentAttack.player = self

func onHit(name, target, shielded=false):
	pass
	#spored
	
func inputAction():	
	if(nextFrameHitPause):
		hitPause=nextFrameHitPause
		nextFrameHitPause=0
	if hitPause:
		return


	if _velocity.y<fallspeed:
		_velocity.y += gravity
	_velocity.x *= airfriction
	_velocity.y *= airfriction
	
	set_velocity(_velocity)
	move_and_slide()
	_velocity = velocity
	
	if position.y>750:
		queue_free()
	if position.y<-750:
		queue_free()
	if position.x>1500:
		queue_free()
	if position.x<-1500:
		queue_free()
	randomize()
	if(randf_range(0, 1)<float(timer)/1000):
		queue_free()
		pass
	timer+=1


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
			#queue_free()

func hitpauseFormula(kb):
	return kb*0.06+2
