extends Character

var jab = load("res://source/characters/Monk/attacks/jab.gd")
var uair = load("res://source/characters/Monk/attacks/uair.gd")
var uair2 = load("res://source/characters/Monk/attacks/uair2.gd")
var ftilt = load("res://source/characters/Monk/attacks/ftilt.gd")
var dtilt = load("res://source/characters/Monk/attacks/dtilt.gd")
var utilt = load("res://source/characters/Monk/attacks/utilt.gd")
var bair = load("res://source/characters/Monk/attacks/bair.gd")
var nair = load("res://source/characters/Monk/attacks/nair.gd")
var dair = load("res://source/characters/Monk/attacks/dair.gd")
var upb = load("res://source/characters/Monk/attacks/upb.gd")
var sideb = load("res://source/characters/Monk/attacks/sideb.gd")
var shine = load("res://source/characters/Monk/attacks/shine.gd")
var hover = load("res://source/characters/Monk/attacks/float.gd")
#var utilt = load("res://source/characters/Monk/attacks/utilt.gd")
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var sunScene = load("res://source/characters/Monk/sun.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

	grab = load("res://source/characters/Monk/attacks/grab.gd")
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
			attackWith(hover)
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
