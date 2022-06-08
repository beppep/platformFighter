extends Character

var jab = load("res://source/characters/Noxh/attacks/jab.gd")
var uair = load("res://source/characters/Noxh/attacks/uair.gd")
var uair2 = load("res://source/characters/Noxh/attacks/uair2.gd")
var ftilt = load("res://source/characters/Noxh/attacks/ftilt.gd")
var dtilt = load("res://source/characters/Noxh/attacks/dtilt.gd")
var utilt = load("res://source/characters/Noxh/attacks/utilt.gd")
var bair = load("res://source/characters/Noxh/attacks/bair.gd")
var nair = load("res://source/characters/Noxh/attacks/nair.gd")
var dair = load("res://source/characters/Noxh/attacks/dair.gd")
var upb = load("res://source/characters/Noxh/attacks/upb.gd")
#var sideb = load("res://source/characters/Noxh/attacks/sideb.gd")
var sideb = load("res://source/characters/Noxh/attacks/swiftstrike.gd")
var nb = load("res://source/characters/Noxh/attacks/nb.gd")
var downb = load("res://source/characters/Noxh/attacks/downb.gd")
#var utilt = load("res://source/characters/Noxh/attacks/utilt.gd")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

	grab = load("res://source/characters/Godtest/attacks/grab.gd")
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
			attackWith(downb)
		elif direction.x != 0:
			attackWith(sideb)
		else:
			attackWith(nb)
	else:
		if direction.y<0:
			attackWith(upb)
		elif direction.y>0:
			attackWith(downb)
		elif direction.x != 0:
			attackWith(sideb)
		else:
			attackWith(nb)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
