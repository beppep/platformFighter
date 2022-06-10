extends Character





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attacks = {
		"grab": load("res://source/characters/Godtest/attacks/grab.gd"),
		"jab": load("res://source/characters/Noxh/attacks/jab.gd"),
		"ftilt": load("res://source/characters/Noxh/attacks/ftilt.gd"),
		"dtilt": load("res://source/characters/Noxh/attacks/dtilt.gd"),
		"utilt": load("res://source/characters/Noxh/attacks/utilt.gd"),
		"uair": load("res://source/characters/Noxh/attacks/uair.gd"),
		"bair": load("res://source/characters/Noxh/attacks/bair.gd"),
		"nair": load("res://source/characters/Noxh/attacks/nair.gd"),
		"dair": load("res://source/characters/Noxh/attacks/dair.gd"),
		"ub": load("res://source/characters/Noxh/attacks/upb.gd"),
		"fb": load("res://source/characters/Noxh/attacks/fb.gd"),
		"nb": load("res://source/characters/Noxh/attacks/nb.gd"),
		"db": load("res://source/characters/Noxh/attacks/downb.gd"),
		"dsmash": load("res://source/characters/Noxh/attacks/dsmash.gd"),
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
			attackWith("nair")
		elif attackDirection.x<0:
			transform.x.x *=-1
			attackWith("nair")
		else:
			attackWith("nair")
	else:
		flip()
		if attackDirection.y<0:
			attackWith("utilt")
		elif attackDirection.y>0:
			attackWith("dtilt")
		elif attackDirection.x>0:
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
			attackWith("ub")
		elif direction.y>0:
			attackWith("dsmash")
		elif direction.x != 0:
			attackWith("fb")
		else:
			attackWith("nb")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
