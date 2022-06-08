extends KinematicBody2D



var explosion = load("res://source/fx/explosion.tscn")

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var gravity = 0.0
var _velocity = Vector2(400,-400)
var bannedHitboxes = []
var HitActors = []
var hitPause = 0
var nextFrameHitPause = 0
var kb_vector = Vector2(0,0)
var team = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func onHit(name, target, shielded=false):
	pass
	
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
