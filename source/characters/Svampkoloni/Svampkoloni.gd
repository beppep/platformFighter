extends Character

var isdead
var shroomList = []

var shroom = load("res://source/characters/Svampkoloni/shroom.tscn")
var svampScene = load("res://source/Characters/Svampkoloni/svamp.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	isdead = false
	attacks = {
		"grab": load("res://source/characters/Svampkoloni/attacks/grab.gd"),
		"throw": load("res://source/characters/Svampkoloni/attacks/throw.gd"),
		"jab": load("res://source/characters/Svampkoloni/attacks/jab.gd"),
		"utilt": load("res://source/characters/Svampkoloni/attacks/utilt.gd"),
		"ftilt": load("res://source/characters/Svampkoloni/attacks/ftilt.gd"),
		"dtilt": load("res://source/characters/Svampkoloni/attacks/dtilt.gd"),
		"uair": load("res://source/characters/Svampkoloni/attacks/uair.gd"),
		"bair": load("res://source/characters/Svampkoloni/attacks/bair.gd"),
		"nair": load("res://source/characters/Svampkoloni/attacks/nair.gd"),
		"dair": load("res://source/characters/Svampkoloni/attacks/dair.gd"),
		"upb": load("res://source/characters/Svampkoloni/attacks/upb.gd"),
		"fb": load("res://source/characters/Svampkoloni/attacks/fb.gd"),
		"db": load("res://source/characters/Svampkoloni/attacks/transform.gd"),
		"fsmash": load("res://source/characters/Svampkoloni/attacks/fsmash.gd"),
		"reborn": load("res://source/characters/Svampkoloni/attacks/reborn.gd"),
	}

func characterInputAction():
	if isdead:
		die(-1)
	
func createShroom(pos, facing, bornAnim = true):
	
	var svamp = shroom.instance()
	svamp.position = pos
	svamp.team = team
	svamp.transform.x.x = facing
	svamp._velocity = Vector2(0,0)
	get_node("/root/Node2D/Articles").add_child(svamp)
	svamp.modulate = sprite_color
	if bornAnim:
		svamp.anim_sprite.play("born")
	svamp.myOwner = self
	shroomList.append(svamp)


func attack():
	var attackDirection
	if c_direction!=Vector2(0,0):
		attackDirection = c_direction
	else:
		attackDirection = direction
	attackDirection.x*=self.transform.x.x
	if not is_on_ground:
		if attackDirection.y<0:
			attackWith("utilt")
		elif attackDirection.y>0:
			attackWith("dair")
		elif attackDirection.x < 0:
			attackWith("bair")
		else:
			attackWith("jab")
	else:
		flip()
		if attackDirection.y<0:
			attackWith("utilt")
		elif attackDirection.y>0:
			attackWith("dtilt")
		else:
			attackWith("jab")
	
func special():
	flip()
	if not is_on_floor():
		if direction.y<0:
			attackWith("upb")
		elif direction.y>0:
			attackWith("db")
		elif direction.x != 0:
			attackWith("fb")
		else:
			state = 0
	else:
		if direction.y<0:
			attackWith("upb")
		elif direction.y>0:
			attackWith("db")
		elif direction.x != 0:
			attackWith("fsmash")
		else:
			state = 0
	

func grab():
	flip() #?
	attackWith("grab")

func dodge():
	.dodge()
	
	var newSvamp = svampScene.instance()
	newSvamp.position = position + Vector2(transform.x.x*0,40)
	get_node("/root/Node2D/fx").add_child(newSvamp)
	newSvamp.get_node("Sprite").modulate = sprite_color

func die(angle):
	if isdead and not angle == -1: # otherwise you respawn twice on the same frame
		return
	if not len(shroomList) > 0:
		for i in get_node("/root/Node2D/Articles").get_children():
			if i.team == team and "hi_im_a_spore" in i:
				isdead = true
				visible = false
				position = i.position
				intangible = true
				state = 7
				return
	if len(shroomList) > 0:
		var pos = shroomList[-1].position
		shroomList.pop_back().queue_free()
		
		position = pos
		isdead = false
		visible = true
		intangible = false
		attackWith("reborn")
	else:
		make_blastline(angle)
		respawn()
