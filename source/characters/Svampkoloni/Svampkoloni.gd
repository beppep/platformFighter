extends Character

var isdead
var shroomList = []

var shroom = load("res://source/characters/Svampkoloni/shroom.tscn")
var svampScene = load("res://source/Characters/Svampkoloni/svamp.tscn")
var spore = load("res://source/characters/Svampkoloni/spore.tscn")
var moldSpore = load("res://source/characters/Svampkoloni/moldSpore.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	isdead = false
	attacks = {
		"grab": load("res://source/characters/Svampkoloni/attacks/grab.gd"),
		"zair": load("res://source/characters/Svampkoloni/attacks/zair.gd"),
		"throw": load("res://source/characters/Svampkoloni/attacks/throw.gd"),
		"throw2": load("res://source/characters/Svampkoloni/attacks/throw2.gd"),
		"jab": load("res://source/characters/Svampkoloni/attacks/jab.gd"),
		"utilt": load("res://source/characters/Svampkoloni/attacks/utilt.gd"),
		"ftilt": load("res://source/characters/Svampkoloni/attacks/ftilt.gd"),
		"dtilt": load("res://source/characters/Svampkoloni/attacks/dtilt.gd"),
		"uair": load("res://source/characters/Svampkoloni/attacks/uair.gd"),
		"bair": load("res://source/characters/Svampkoloni/attacks/bair.gd"),
		"fair": load("res://source/characters/Svampkoloni/attacks/fair.gd"),
		"nair": load("res://source/characters/Svampkoloni/attacks/nair.gd"),
		"dair": load("res://source/characters/Svampkoloni/attacks/dair.gd"),
		"upb": load("res://source/characters/Svampkoloni/attacks/upb.gd"),
		"fb": load("res://source/characters/Svampkoloni/attacks/fb.gd"),
		"db": load("res://source/characters/Svampkoloni/attacks/db.gd"),
		"fsmash": load("res://source/characters/Svampkoloni/attacks/fsmash.gd"),
		"dsmash": load("res://source/characters/Svampkoloni/attacks/transform.gd"),
		"reborn": load("res://source/characters/Svampkoloni/attacks/reborn.gd"),
	}

func characterInputAction():
	if isdead:
		die(-1)
	
func createSvamp(pos):
	var newSvamp = svampScene.instance()
	newSvamp.position = pos
	newSvamp.transform.x.x = int(pos.x>0)*2-1 #random number -1 or 1
	get_node("/root/Node2D/fx").add_child(newSvamp)
	newSvamp.get_node("Sprite").modulate = sprite_color

func createShroom(pos, facing, bornAnim = true):
	if len(shroomList)>2:
		createSvamp(pos+Vector2(0,32))
	else:
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

func createSpore(vel):
	
	var svamp = spore.instance()
	svamp.position = position
	svamp.team = team
	svamp.transform.x.x = transform.x.x
	svamp._velocity = vel + _velocity
	get_node("/root/Node2D/Articles").add_child(svamp)
	svamp.attackWith("sporeAttack")
	svamp.modulate = sprite_color
	svamp.anim_sprite.play("spore")
	svamp.myOwner = self

func createMoldSpore(vel):
	
	var svamp = moldSpore.instance()
	svamp.position = position
	svamp.team = team
	svamp.transform.x.x = transform.x.x
	svamp._velocity = vel
	get_node("/root/Node2D/Articles").add_child(svamp)
	svamp.attackWith("moldSporeAttack")
	svamp.modulate = sprite_color
	svamp.anim_sprite.play("spore") 
	svamp.myOwner = self

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
		elif attackDirection.x < 0:
			attackWith("bair")
		elif attackDirection.x > 0:
			attackWith("fair") # jag tänker att det är ganska nice
		else:
			attackWith("nair") # kunna drifta fram och göra nairs?
	else:
		#flip()
		if attackDirection.x>0:
			attackWith("ftilt")
		elif attackDirection.x<0:
			transform.x.x *= -1
			attackWith("ftilt")
		elif attackDirection.y<0:
			attackWith("utilt")
		elif attackDirection.y>0:
			attackWith("dtilt")
		else:
			attackWith("jab")
	
func special():
	flip()
	if not is_on_ground:
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
			attackWith("dsmash")
		elif direction.x != 0:
			attackWith("fsmash")
		else:
			state = 0
	

func grab():
	flip() #?
	if not is_on_ground:
		attackWith("zair")
	else:
		attackWith("grab")

func dodge():
	.dodge()
	createSvamp(position + Vector2(transform.x.x*0,40))
	
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
		var pos = shroomList[-1].position + Vector2(0,-20)
		shroomList.pop_back().queue_free()
		
		position = pos
		_velocity = Vector2.ZERO#?
		isdead = false
		visible = true
		intangible = false
		attackWith("reborn")
		for other in get_node("/root/Node2D/Players").get_children():
			if other.grab_target!=null and other.grab_target == self:
				other.grab_target = null
	else:
		make_blastline(angle)
		respawn()
