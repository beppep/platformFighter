extends Character





var sunScene = load("res://source/characters/Godtest/sun.tscn")
var B_charge = 8
var hasHoverboard = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attacks = {
		"grab": load("res://source/characters/Godtest/attacks/grab.gd"),
		"jab": load("res://source/characters/Godtest/attacks/jab.gd"),
		"ftilt": load("res://source/characters/Godtest/attacks/ftilt.gd"),
		"dtilt": load("res://source/characters/Godtest/attacks/dtilt.gd"),
		"utilt": load("res://source/characters/Godtest/attacks/utilt.gd"),
		"fair": load("res://source/characters/Godtest/attacks/ftilt.gd"),
		"bair": load("res://source/characters/Godtest/attacks/bair.gd"),
		"nair": load("res://source/characters/Godtest/attacks/nair.gd"),
		"dair": load("res://source/characters/Godtest/attacks/dair.gd"),
		"uair": load("res://source/characters/Godtest/attacks/uair.gd"),
		"nb": load("res://source/characters/Godtest/attacks/uair2.gd"),
		"ub": load("res://source/characters/Godtest/attacks/upb.gd"),
		"fb": load("res://source/characters/Godtest/attacks/sideb.gd"),
		"db": load("res://source/characters/Godtest/attacks/float.gd"),
	}

	#var sun = sunScene.instance()
	#get_node("/root/Node2D/Articles").add_child(sun)

func regain_resources():
	B_charge = 8
	if hasHoverboard:
		double_jump = 2

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
			if B_charge>0:
				attackWith("db")
			else:
				state = 0
				stateTimer = 0
		elif direction.x != 0:
			attackWith("fb")
		else:
			attackWith("nb")
	else:
		if direction.y<0:
			attackWith("ub")
		elif direction.y>0:
			attackWith("db")
		elif direction.x != 0:
			attackWith("fb")
		else:
			attackWith("nb")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
