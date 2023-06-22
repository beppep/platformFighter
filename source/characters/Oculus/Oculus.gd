extends Character

var eyeballScene = preload("res://source/characters/Oculus/Eyeball.tscn")
var upB_charge = 15
var eyeball = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	wallHogFallSpeed = -150
	can_getupattack = false
	attacks = {
		#"getupa": load("res://source/characters/Oculus/attacks/getupattack.gd"),
		"grab": load("res://source/characters/Oculus/attacks/grab.gd"),
		"throw": load("res://source/characters/Oculus/attacks/throw.gd"),
		"zair": load("res://source/characters/Oculus/attacks/airthrow.gd"),
		"jab": load("res://source/characters/Oculus/attacks/jab.gd"),
		"ftilt": load("res://source/characters/Oculus/attacks/ftilt.gd"),
		"dattack": load("res://source/characters/Oculus/attacks/dattack.gd"),
		"dtilt": load("res://source/characters/Oculus/attacks/dtilt.gd"),
		"utilt": load("res://source/characters/Oculus/attacks/utilt.gd"),
		"uair": load("res://source/characters/Oculus/attacks/uair.gd"),
		"bair": load("res://source/characters/Oculus/attacks/bair.gd"),
		"bair2": load("res://source/characters/Oculus/attacks/bair2.gd"),
		"nair": load("res://source/characters/Oculus/attacks/nair.gd"),
		"fair": load("res://source/characters/Oculus/attacks/fair.gd"),
		"fair2": load("res://source/characters/Oculus/attacks/fair2.gd"),
		"dair": load("res://source/characters/Oculus/attacks/dair.gd"),
		"ub": load("res://source/characters/Oculus/attacks/upb.gd"),
		"fb": load("res://source/characters/Oculus/attacks/fb.gd"),
		"nb": load("res://source/characters/Oculus/attacks/nb.gd"),
		"db": load("res://source/characters/Oculus/attacks/db.gd"),
		"db2": load("res://source/characters/Oculus/attacks/db2.gd"),
		"nsmash": load("res://source/characters/Oculus/attacks/nsmash.gd"),
		"dsmash": load("res://source/characters/Oculus/attacks/dsmash.gd"),
		"usmash": load("res://source/characters/Oculus/attacks/usmash.gd"),
		"usmash2": load("res://source/characters/Oculus/attacks/usmash2.gd"),
		"fsmash": load("res://source/characters/Oculus/attacks/fsmash.gd"),
	}
	
	upB_charge = 15

func regain_resources():
	upB_charge = 15

func attack():
	var attackDirection
	if c_direction!=Vector2(0,0):
		attackDirection = c_direction
	else:
		attackDirection = direction
	attackDirection.x*=self.transform.x.x
	if not is_on_ground:
		if attackDirection.y<0:
			attackWith("uair")
		elif attackDirection.y>0:
			attackWith("dair")
		elif attackDirection.x>0:
			attackWith("fair")
		elif attackDirection.x<0:
			attackWith("bair")
		else:
			attackWith("nair")
	else:
		#flip()
		if attackDirection.y<0:
			attackWith("utilt")
		elif attackDirection.y>0:
			attackWith("dtilt")
		elif attackDirection.x>0:
			attackWith("dattack")
		elif attackDirection.x<0:
			transform.x.x *= -1
			attackWith("ftilt")
		else:
			attackWith("jab")
	
func special():
	flip()
	if not is_on_ground:
		if direction.y<0:
			attackWith("ub")
		elif direction.y>0:
			attackWith("db")
		elif direction.x != 0:
			attackWith("fb")
		else:
			if not eyeball:
				attackWith("nb")
	else:
		if direction.y<0:
			attackWith("usmash")
		elif direction.y>0:
			attackWith("dsmash")
		elif direction.x != 0:
			attackWith("fb")
		else:
			if not eyeball:
				attackWith("nb")
	
func grab():
	flip() #?
	attackWith("grab")
