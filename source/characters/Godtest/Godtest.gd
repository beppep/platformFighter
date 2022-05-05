extends Character

var jab = load("res://source/characters/Godtest/attacks/jab.gd")
var uair = load("res://source/characters/Godtest/attacks/uair.gd")
var uair2 = load("res://source/characters/Godtest/attacks/uair2.gd")
var ftilt = load("res://source/characters/Godtest/attacks/ftilt.gd")
var dtilt = load("res://source/characters/Godtest/attacks/dtilt.gd")
var utilt = load("res://source/characters/Godtest/attacks/utilt.gd")
var bair = load("res://source/characters/Godtest/attacks/bair.gd")
var nair = load("res://source/characters/Godtest/attacks/nair.gd")
var dair = load("res://source/characters/Godtest/attacks/dair.gd")
var upb = load("res://source/characters/Godtest/attacks/upb.gd")
var sideb = load("res://source/characters/Godtest/attacks/sideb.gd")
var shine = load("res://source/characters/Godtest/attacks/shine.gd")
var hover = load("res://source/characters/Godtest/attacks/float.gd")
#var utilt = load("res://source/characters/Godtest/attacks/utilt.gd")
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var sunScene = load("res://source/characters/Godtest/sun.tscn")
var B_charge = 8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

	grab = load("res://source/characters/Godtest/attacks/grab.gd")
	#var sun = sunScene.instance()
	#get_node("/root/Node2D/Articles").add_child(sun)

func regain_resources():
	B_charge = 8

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
			attackWith(ftilt)
		elif attackDirection.x<0:
			attackWith(bair)
		else:
			attackWith(nair)
	else:
		flip()
		if attackDirection.y<0:
			attackWith(utilt)
		elif attackDirection.y>0:
			attackWith(dtilt)
		elif attackDirection.x>0:
			attackWith(ftilt)
		else:
			attackWith(jab)
	
func special():
	flip()
	if not is_on_ground:
		if direction.y<0:
			attackWith(upb)
		elif direction.y>0:
			if B_charge>0:
				attackWith(hover)
			else:
				state = 0
				stateTimer = 0
		elif direction.x != 0:
			attackWith(sideb)
		else:
			attackWith(uair2)
	else:
		if direction.y<0:
			attackWith(upb)
		elif direction.y>0:
			attackWith(hover)
		elif direction.x != 0:
			attackWith(sideb)
		else:
			attackWith(uair2)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
