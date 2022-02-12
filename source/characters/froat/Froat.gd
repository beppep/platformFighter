extends Character

var jab = load("res://source/characters/Froat/attacks/jab.gd")
var dtilt = load("res://source/characters/Froat/attacks/dtilt.gd")
var utilt = load("res://source/characters/Froat/attacks/utilt.gd")
var bash = load("res://source/characters/Froat/attacks/bash.gd")
var uair = load("res://source/characters/Froat/attacks/uair.gd")
var dair = load("res://source/characters/Froat/attacks/dair.gd")
var ramm = load("res://source/characters/Froat/attacks/ramm.gd")
var eye = load("res://source/characters/Froat/attacks/summon.gd")
var spin = load("res://source/characters/Froat/attacks/spin.gd")
var upb = load("res://source/characters/Froat/attacks/eye.gd")
var shoot = load("res://source/characters/Froat/attacks/shoot.gd")
#var utilt = load("res://source/characters/Froat/attacks/utilt.gd")
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func airdodge():
	_velocity.y=-100
	state = 3
	stateTimer = 0
	$sprite.modulate=sprite_color
	$Shield.visible = true
	anim_player.stop(true) #resets animation
	anim_player.play("standing")

func attack():
	can_walljump = false
	state = 1
	stateTimer = 0
	var attackDirection
	if c_direction!=Vector2(0,0):
		attackDirection = c_direction
	else:
		attackDirection = direction
	attackDirection.x*=self.scale.y
	if not is_on_ground:
		if attackDirection.y<0:
			$currentAttack.set_script(uair)
		elif attackDirection.y>0:
			$currentAttack.set_script(dair)
		elif attackDirection.x==0:
			$currentAttack.set_script(spin)
		else:
			$currentAttack.set_script(bash)
	else:
		if attackDirection.x>0:
			$currentAttack.set_script(bash)
		elif attackDirection.y>0:
			$currentAttack.set_script(dtilt)
		elif attackDirection.y<0:
			$currentAttack.set_script(utilt)
		else:
			$currentAttack.set_script(jab)
	$currentAttack._ready()
	
func special():
	can_walljump = false
	state = 1
	stateTimer = 0
	if not is_on_floor():
		if direction.y<0:
			$currentAttack.set_script(upb)
		elif direction.y>0:
			$currentAttack.set_script(eye)
		elif direction.x==0:
			$currentAttack.set_script(shoot)
		else:
			$currentAttack.set_script(ramm)
	else:
		$currentAttack.set_script(ramm)
	$currentAttack._ready()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
