extends Character

# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	attacks = {
		"grab": load("res://source/characters/Monk/attacks/jab.gd"),
		"jab": load("res://source/characters/Monk/attacks/jab.gd"),
		"dtilt": load("res://source/characters/Monk/attacks/dtilt.gd"),
		"ftilt": load("res://source/characters/Monk/attacks/ftilt.gd"),
		"utilt": load("res://source/characters/Monk/attacks/utilt.gd"),
		"nair": load("res://source/characters/Monk/attacks/nair.gd"),
		"uair": load("res://source/characters/Monk/attacks/uair.gd"),
		"dair": load("res://source/characters/Monk/attacks/dair.gd"),
		"bair": load("res://source/characters/Monk/attacks/bair.gd"),
		"fair": load("res://source/characters/Monk/attacks/fair.gd"),
		"nb": load("res://source/characters/Monk/attacks/shine.gd"),
		"fb": load("res://source/characters/Monk/attacks/sideb.gd"),
		"ub": load("res://source/characters/Monk/attacks/upb.gd"),
		"db": load("res://source/characters/Monk/attacks/downb.gd"),
		"nsmash": load("res://source/characters/Monk/attacks/nsmash.gd"),
		"usmash": load("res://source/characters/Monk/attacks/upsmash.gd"),
		"dsmash": load("res://source/characters/Monk/attacks/dsmash.gd"),
		"fsmash": load("res://source/characters/Monk/attacks/ramm.gd"),
	}
	#var sun = sunScene.instance()
	#get_node("/root/Node2D/Articles").add_child(sun)


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
			attackWith("ftilt")
		elif attackDirection.x<0:
			attackWith("bair")
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
			attackWith("upb")
		elif direction.y>0:
			attackWith("nb")
		elif direction.x != 0:
			attackWith("fb")
		else:
			attackWith("nb")
	else:
		if direction.y<0:
			attackWith("upb")
		elif direction.y>0:
			attackWith("nb")
		elif direction.x != 0:
			attackWith("fb")
		else:
			attackWith("nb")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
