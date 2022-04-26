extends Character

var jab = load("res://source/characters/Froat/attacks/jab.gd")
var dtilt = load("res://source/characters/Froat/attacks/dtilt.gd")
var ftilt = load("res://source/characters/Froat/attacks/ftilt.gd")
var utilt = load("res://source/characters/Froat/attacks/utilt.gd")
var bash = load("res://source/characters/Froat/attacks/bash.gd")
var uair = load("res://source/characters/Froat/attacks/uair.gd")
var dair = load("res://source/characters/Froat/attacks/dair.gd")
var bair = load("res://source/characters/Froat/attacks/bair.gd")
var fair = load("res://source/characters/Froat/attacks/fair.gd")
var ramm = load("res://source/characters/Froat/attacks/ramm.gd")
var summon2 = load("res://source/characters/Froat/attacks/summon2.gd")
var spin = load("res://source/characters/Froat/attacks/spin.gd")
var upb = load("res://source/characters/Froat/attacks/upb.gd")
var downb = load("res://source/characters/Froat/attacks/downb.gd")
var upsmash = load("res://source/characters/Froat/attacks/upsmash.gd")
var nsmash = load("res://source/characters/Froat/attacks/nsmash.gd")
var dsmash = load("res://source/characters/Froat/attacks/dsmash.gd")
var shoot = load("res://source/characters/Froat/attacks/shoot.gd")
#var utilt = load("res://source/characters/Froat/attacks/utilt.gd")
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	grab = load("res://source/characters/Froat/attacks/grab.gd")

func shield():
	if direction==Vector2.ZERO:
		_velocity*=0.5
	if is_on_ground or direction==Vector2.ZERO:
		state = 3
		stateTimer = 0
		$Shield.visible = true
		anim_player.stop(true) #resets animation
		anim_player.play("standing")
	elif has_airdodge>0:
		airdodge()

func attack():
	var attackDirection
	if c_direction!=Vector2(0,0):
		attackDirection = c_direction
	else:
		attackDirection = direction
	attackDirection.x*=self.transform.x.x
	if not is_on_ground:
		if attackDirection.y<0:
			attackWith(uair)
		elif attackDirection.y>0:
			attackWith(dair)
		elif attackDirection.x>0:
			attackWith(fair)
		elif attackDirection.x<0:
			attackWith(bair)
		else:
			attackWith(bash)
	else:
		flip()
		if attackDirection.x>0:
			attackWith(ftilt)
		elif attackDirection.y>0:
			attackWith(dtilt)
		elif attackDirection.y<0:
			attackWith(utilt)
		else:
			attackWith(jab)
	
func special():
	flip()
	if not is_on_ground:
		if direction.y<0:
			attackWith(upb)
		elif direction.y>0:
			attackWith(downb)
		elif direction.x==0:
			if B_charged:
				attackWith(summon2)
				B_charged = false
			else:
				state = 0
				stateTimer = 0
		else:
			attackWith(ramm)
	else:
		if direction.y<0:
			attackWith(upsmash)
		elif direction.y>0:
			attackWith(dsmash)
		elif direction.x==0:
			attackWith(dsmash)
		else:
			attackWith(ramm)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
