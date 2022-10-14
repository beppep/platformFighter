extends Character


var bulletScene = preload("res://source/characters/Noxh/Bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	can_getupattack = true
	attacks = {
		"getupa": load("res://source/characters/Noxh/attacks/getupattack.gd"),
		"grab": load("res://source/characters/Noxh/attacks/grab.gd"),
		"throw": load("res://source/characters/Noxh/attacks/throw.gd"),
		"zair": load("res://source/characters/Noxh/attacks/airthrow.gd"),
		"jab": load("res://source/characters/Noxh/attacks/jab.gd"),
		"ftilt": load("res://source/characters/Noxh/attacks/ftilt.gd"),
		"dtilt": load("res://source/characters/Noxh/attacks/dtilt.gd"),
		"utilt": load("res://source/characters/Noxh/attacks/utilt.gd"),
		"uair": load("res://source/characters/Noxh/attacks/uair.gd"),
		"bair": load("res://source/characters/Noxh/attacks/bair.gd"),
		"nair": load("res://source/characters/Noxh/attacks/nair.gd"),
		"fair": load("res://source/characters/Noxh/attacks/fair.gd"),
		"fair2": load("res://source/characters/Noxh/attacks/fair2.gd"),
		"dair": load("res://source/characters/Noxh/attacks/dair.gd"),
		"ub": load("res://source/characters/Noxh/attacks/upb.gd"),
		"fb": load("res://source/characters/Noxh/attacks/fb.gd"),
		"nb": load("res://source/characters/Noxh/attacks/nb.gd"),
		"db": load("res://source/characters/Noxh/attacks/downb.gd"),
		"nsmash": load("res://source/characters/Noxh/attacks/nsmash.gd"),
		"dsmash": load("res://source/characters/Noxh/attacks/dsmash.gd"),
		"usmash": load("res://source/characters/Noxh/attacks/usmash.gd"),
		"fsmash": load("res://source/characters/Noxh/attacks/fsmash.gd"),
	}

	#var sun = sunScene.instance()
	#get_node("/root/Node2D/Articles").add_child(sun)

func regain_resources():
	pass

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
			attackWith("fair2")
		elif attackDirection.x<0:
			attackWith("bair")
		else:
			attackWith("fair")
	else:
		#flip()
		if attackDirection.y<0:
			attackWith("utilt")
		elif attackDirection.y>0:
			attackWith("dtilt")
		elif attackDirection.x>0:
			attackWith("ftilt")
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
			attackWith("nb")
	else:
		if direction.y<0:
			attackWith("usmash")
		elif direction.y>0:
			attackWith("dsmash")
		elif direction.x != 0:
			attackWith("fsmash")
		else:
			attackWith("nsmash")
	
func grab():
	flip() #?
	attackWith("grab")
