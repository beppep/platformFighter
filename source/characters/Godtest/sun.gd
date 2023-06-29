extends CharacterBody2D



var explosion = load("res://source/fx/explosion.tscn")

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
@export var speed = 1
var bannedHitboxes = []
var HitActors = []
var hitPause = 0
var nextFrameHitPause = 0
var kb_vector = Vector2(0,0)
var wasHit = false
var state = 0
var stateTimer = 0
var team = 0
var timeAngle = 0

@onready var anim_player: AnimationPlayer = get_node("AnimationPlayer") #basically just declared in _ready func


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	z_index = -2

func onHit(name, target, shielded=false):
	pass
	
func inputAction():	
	
	if(nextFrameHitPause):
		hitPause=nextFrameHitPause
		nextFrameHitPause=0
	if hitPause:
		return
		
	if state==0:
		timeAngle+=speed*0.01
		
	position = Vector2(cos(timeAngle), sin(timeAngle))*500 + Vector2(0,500)
	
	if state==0:
		for other in $"/root/Node2D/Players".get_children():
			if other.team != team:
				if $"burner".overlaps_body(other.get_node("HurtBox")):
					other.percentage+=1
					print("omg")


func CheckHurtBoxes() -> Array:
	var HitActors = []
	return HitActors

func hitCollision():			
	pass
func hitEffect():
	
	
	#progress states
	if hitPause==0:
		stateTimer+=1
	if hitPause>0:
		hitPause-=1
		if hitPause<=0:
			hitPause=0
