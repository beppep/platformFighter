extends Character

var ghostScene = preload("res://source/characters/Cline/Ghost.tscn")
var B_charge = 10
var electric_charge = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	can_getupattack = false
	attacks = {
		#"getupa": load("res://source/characters/Cline/attacks/getupattack.gd"),
		"grab": load("res://source/characters/Cline/attacks/grab.gd"),
		"throw": load("res://source/characters/Cline/attacks/throw.gd"),
		"zair": load("res://source/characters/Cline/attacks/airthrow.gd"),
		"jab": load("res://source/characters/Cline/attacks/jab.gd"),
		"ftilt": load("res://source/characters/Cline/attacks/ftilt.gd"),
		"dtilt": load("res://source/characters/Cline/attacks/dtilt.gd"),
		"utilt": load("res://source/characters/Cline/attacks/utilt.gd"),
		"uair": load("res://source/characters/Cline/attacks/uair.gd"),
		"bair": load("res://source/characters/Cline/attacks/bair.gd"),
		"nair": load("res://source/characters/Cline/attacks/nair.gd"),
		"fair": load("res://source/characters/Cline/attacks/fair.gd"),
		"fair2": load("res://source/characters/Cline/attacks/fair2.gd"),
		"dair": load("res://source/characters/Cline/attacks/dair.gd"),
		"ub": load("res://source/characters/Cline/attacks/upb.gd"),
		"fb": load("res://source/characters/Cline/attacks/fb2.gd"),
		"nb": load("res://source/characters/Cline/attacks/nb.gd"),
		"db": load("res://source/characters/Cline/attacks/db.gd"),
		"db2": load("res://source/characters/Cline/attacks/db2.gd"),
		"nsmash": load("res://source/characters/Cline/attacks/nsmash.gd"),
		"dsmash": load("res://source/characters/Cline/attacks/dsmash.gd"),
		"usmash": load("res://source/characters/Cline/attacks/usmash.gd"),
		"fsmash": load("res://source/characters/Cline/attacks/fsmash.gd"),
	}

	#var sun = sunScene.instance()
	#get_node("/root/Node2D/Articles").add_child(sun)

func regain_resources():
	B_charge = 10

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
			if B_charge>0:
				B_charge-=1
				attackWith("nb")
	else:
		if direction.y<0:
			attackWith("ub")
		elif direction.y>0:
			attackWith("dsmash")
		elif direction.x != 0:
			attackWith("fb")
		else:
			if B_charge>0:
				B_charge-=1
				attackWith("nb")
	
func grab():
	flip() #?
	attackWith("grab")


func uniqueRespawn(new):
	new.position = Vector2(-$"/root/Node2D".blastzoneX, -100)
	new._velocity = Vector2(2000, -1000)
	new.intangibleFrames = 100
	new.state = 2
	new.stateTimer = 0
	new.totalHitstun = 30
