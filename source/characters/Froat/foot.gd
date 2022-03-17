extends KinematicBody2D



var explosion = load("res://source/fx/explosion.tscn")

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var _velocity = Vector2(0,-600)
var hitPause = 0
var nextFrameHitPause = 0
var state = 1
var stateTimer = 0
var team = 0
var upsideDown = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	z_index = -2

func onHit(name, target, shielded=false):
	pass

func inputAction():	
	
	$currentAttack.update(self) #inconventionally placed before hitpause check
	
	
	if(nextFrameHitPause):
		hitPause=nextFrameHitPause
		nextFrameHitPause=0
	if hitPause:
		return
		
		
	
	move_and_slide(_velocity)
	
	if position.y>750:
		queue_free()
	if position.y<-750:
		queue_free()

func hitCollision():			
	pass

func changeHitbox():
	$currentAttack.changeHitbox()
		
func hitEffect():
	
	if hitPause==0:
		$currentAttack.endAttack(self)
	
	#progress states
	if hitPause==0:
		stateTimer+=1
	if hitPause>0:
		hitPause-=1
		if hitPause<=0:
			hitPause=0
