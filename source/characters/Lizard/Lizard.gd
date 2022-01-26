extends Character

var bair = load("res://source/characters/Lizard/bair.gd") 
var lick = load("res://source/characters/Lizard/lick.gd") 
var punch = load("res://source/characters/Lizard/punch.gd") 
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func attack():
	state = 1
	stateTimer = 0
	if not is_on_floor():
		if direction.x*self.scale.y<0:
			$currentAttack.set_script(bair)
		elif direction.x*self.scale.y>0:
			$currentAttack.set_script(lick)
		else:
			$currentAttack.set_script(punch)
	else:
		if direction.x*self.scale.y>0:
			$currentAttack.set_script(lick)
		else:
			$currentAttack.set_script(punch)
	$currentAttack._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame. #FPS
#func _process(delta):
#	pass
