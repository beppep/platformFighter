extends Character





var boardScene = load("res://source/characters/Godtest/hoverboard/hoverboard.tscn")
var B_charge = 8
var hasHoverboard = true
var boardObject = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attacks = {
		"grab": load("res://source/characters/Godtest/attacks/grab.gd"),
		"throw": load("res://source/characters/Godtest/attacks/throw.gd"),
		"jab": load("res://source/characters/Godtest/attacks/jab.gd"),
		"ftilt": load("res://source/characters/Godtest/attacks/ftilt.gd"),
		"dtilt": load("res://source/characters/Godtest/attacks/dtilt.gd"),
		"utilt": load("res://source/characters/Godtest/attacks/utilt.gd"),
		"fair": load("res://source/characters/Godtest/attacks/fair.gd"),
		"bair": load("res://source/characters/Godtest/attacks/bair.gd"),
		"nair": load("res://source/characters/Godtest/attacks/jab.gd"),
		"dair": load("res://source/characters/Godtest/attacks/dair.gd"),
		"uair": load("res://source/characters/Godtest/attacks/uair.gd"),
		"nb": load("res://source/characters/Godtest/attacks/uair.gd"),
		"ub": load("res://source/characters/Godtest/attacks/upb.gd"),
		"fb": load("res://source/characters/Godtest/attacks/sideb.gd"),
		"db": load("res://source/characters/Godtest/attacks/db.gd"),
		"attach": load("res://source/characters/Godtest/attacks/attach.gd"),
		"dthrow": load("res://source/characters/Godtest/attacks/dthrow.gd"),
		"fthrow": load("res://source/characters/Godtest/attacks/fthrow.gd"),
		"uthrow": load("res://source/characters/Godtest/attacks/uthrow.gd"),
	}


func regain_resources():
	B_charge = 8
	if hasHoverboard:
		double_jumps = 2
	else:
		double_jumps = 1
		
func double_jump():
	if double_jumps == 1:
		.double_jump()
	elif double_jumps == 2:
		#jump
		_velocity.y = -jumpspeed
		anim_sprite.play("jump")
		double_jumps = 1
		
		#create board
		boardObject = boardScene.instance()
		boardObject.transform.x.x = self.transform.x.x
		boardObject.position = self.position+Vector2(0,36)
		boardObject._velocity = Vector2(0, 200)
		boardObject.z_index = -2
		boardObject.team = team
		boardObject.ownerObject = self
		get_node("/root/Node2D/Articles").add_child(boardObject)
		
		$Hoverboard.visible = false
		hasHoverboard = false
		released_jump = false

func characterInputAction():
	if hasHoverboard:
		groundfriction = 0.93
		groundspeed = 90
		can_shield_float = true
		maxspeed = 1000
	else:
		groundfriction = 0.85
		groundspeed = 70
		can_shield_float = false
		maxspeed = 500
	
func attack():
	var attackDirection
	if c_direction!=Vector2(0,0):
		attackDirection = c_direction
	else:
		attackDirection = direction
	attackDirection.x*=self.transform.x.x
	if not (is_on_ground or hasHoverboard):
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
		elif attackDirection.x!=0:
			attackWith("ftilt")
		else:
			attackWith("jab")
	
func special():
	flip()
	if not is_on_ground:
		if direction.y<0:
			if hasHoverboard:
				attackWith("uthrow")
			else:
				attackWith("ub")
		elif direction.y>0:
			if hasHoverboard:
				attackWith("dthrow")
			else:
				attackWith("db")
		elif direction.x != 0:
			if hasHoverboard:
				attackWith("fthrow")
			else:
				attackWith("fb")
		else:
			attackWith("nb")
	else:
		if direction.y<0:
			if hasHoverboard:
				attackWith("uthrow")
			else:
				attackWith("ub")
		elif direction.y>0:
			if hasHoverboard:
				attackWith("fthrow")
			else:
				attackWith("db")
		elif direction.x != 0:
			if hasHoverboard:
				attackWith("fthrow")
			else:
				attackWith("fb")
		else:
			attackWith("nb")
	
func grab():
	flip() #?
	attackWith("grab")
