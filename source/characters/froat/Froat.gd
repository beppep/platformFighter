extends Character

var jab = load("res://source/characters/Froat/attacks/jab.gd")
var dtilt = load("res://source/characters/Froat/attacks/dtilt.gd")
var ftilt = load("res://source/characters/Froat/attacks/ftilt.gd")
var utilt = load("res://source/characters/Froat/attacks/utilt.gd")
var bash = load("res://source/characters/Froat/attacks/bash.gd")
var uair = load("res://source/characters/Froat/attacks/uair.gd")
var dair = load("res://source/characters/Froat/attacks/dair.gd")
var ramm = load("res://source/characters/Froat/attacks/ramm.gd")
var summon = load("res://source/characters/Froat/attacks/summon.gd")
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

func airdodge():
	if direction==Vector2.ZERO:
		_velocity*=0.5
		state = 3
		stateTimer = 0
		$sprite.modulate=sprite_color
		$Shield.visible = true
		anim_player.stop(true) #resets animation
		anim_player.play("standing")
	else:
		is_on_ground = false
		state = 4
		stateTimer = 0
		$Shield.visible = false
		$sprite.modulate = sprite_color+Color(0.5,0.5,0.5,0)
		intangible = true
		var dodge_direction = direction.normalized()
		_velocity = dodge_direction*1000
		anim_player.stop(true)
		anim_player.play("roll")

func attack():
	grab_target = false
	can_walljump = false
	cant_hitfall = false
	state = 1
	stateTimer = 0
	var attackDirection
	if c_direction!=Vector2(0,0):
		attackDirection = c_direction
	else:
		attackDirection = direction
	attackDirection.x*=self.transform.x.x
	if not is_on_ground:
		if attackDirection.y<0:
			$currentAttack.set_script(uair)
		elif attackDirection.y>0:
			$currentAttack.set_script(dair)
		elif attackDirection.x>0:
			$currentAttack.set_script(ftilt)
		else:
			$currentAttack.set_script(bash)
	else:
		flip()
		if attackDirection.x>0:
			$currentAttack.set_script(ftilt)
		elif attackDirection.y>0:
			$currentAttack.set_script(dtilt)
		elif attackDirection.y<0:
			$currentAttack.set_script(utilt)
		else:
			$currentAttack.set_script(jab)
	
func special():
	grab_target = false
	can_walljump = false
	state = 1
	stateTimer = 0
	flip()
	if not is_on_ground:
		if direction.y<0:
			$currentAttack.set_script(upb)
		elif direction.y>0:
			$currentAttack.set_script(downb)
		elif direction.x==0:
			if B_charged:
				$currentAttack.set_script(summon)
				B_charged = false
			else:
				state = 0
				stateTimer = 0
		else:
			$currentAttack.set_script(ramm)
	else:
		if direction.y<0:
			$currentAttack.set_script(upsmash)
		elif direction.y>0:
			$currentAttack.set_script(dsmash)
		elif direction.x==0:
			$currentAttack.set_script(nsmash)
		else:
			$currentAttack.set_script(ramm)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
