extends KinematicBody2D
class_name Character

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var gravity = 80.0 #per second squared
export var airspeed = 20.0
export var groundspeed = 100.0
export var jumpspeed = 1000.0
export var groundfriction = 0.8
export var airfriction = 0.98
var player_id = 0
var _velocity: = Vector2(0,-100) #pixels per second
var direction: = Vector2.ZERO
var released_jump = false
var double_jump = true
var state = 0 #0: actionable, 1:attacking, 2:hitstun
var currentAttack = "error"
var stateTimer = 0
var totalHitstun = 0
var hitPause = 0 #descends
var bannedHitboxes = []
var HitActors = []
var percentage = 0

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer") #basically just declared in _ready func

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func inputAction():
	# input 
	direction = get_direction()
	# movement
	if hitPause:
		return
	_velocity = calculate_move_velocity(_velocity, direction) # should be += and friction for nice movement (wut
	# options
	if state==0:
		if Input.get_action_strength("p1_a") and player_id==0 or Input.get_action_strength("p2_a") and player_id==1:
			attack()
	if state==1:
		#print(currentAttack.get_script_method_list())
		#print(ClassDB.class_exists("jab"))
		$currentAttack.update(self)
	_velocity = move_and_slide(_velocity, Vector2.UP)
func attack():
	pass
func hitCollision():			
	# hitting
	HitActors = CheckHurtBoxes()
func hitEffect():
	if HitActors:
		var data = HitActors[0][0]
		var opponent = HitActors[0][1]
		
		if state ==1:
			for i in $HitBoxes.get_children():
				i.queue_free()
			for player in get_node("/root/Node2D/Players").get_children():
				var replacementList = []
				for i in player.bannedHitboxes:
					if i[0] != self:
						replacementList.append(i)
				player.bannedHitboxes = replacementList
		state = 2
		stateTimer = 0
		anim_player.stop(true) #resets animation
		anim_player.play("shake")
		var angle = data["angle"]*PI/180
		var kb = data["kb"] + data["kbscaling"]*percentage
		_velocity = Vector2(cos(angle)*opponent.scale.y, -sin(angle))*kb*10
		totalHitstun = kb*0.2
		hitPause = kb*0.1 #+= for trades and stuff?
		opponent.hitPause = hitPause
		anim_player.stop()
		percentage += data["damage"]
		$Label.text = str(percentage)+"%"
	#progress states
	if hitPause>0:
		hitPause-=1
		position+=direction #asdi
		_velocity+=direction #this is not di this is just weird
		if hitPause<=0:
			hitPause=0
			anim_player.play()
	else:
		stateTimer+=1
		if state == 2:
			if stateTimer >= totalHitstun:
				state = 0
				anim_player.stop(true)
				#useless to remove bans here

func get_direction():
	if player_id==0:
		return Vector2(
			Input.get_action_strength("p1_right")-Input.get_action_strength("p1_left"),
			-Input.get_action_strength("p1_up") #is_on_floor updated by moveandslide
		)
	else:
		return Vector2(
			Input.get_action_strength("p2_right")-Input.get_action_strength("p2_left"),
			-Input.get_action_strength("p2_up") #is_on_floor updated by moveandslide
		)
	
func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2
) -> Vector2:
	var new_velocity = linear_velocity
	if is_on_floor():
		double_jump = true
		if state==0:
			anim_player.play("standing")
			
	
	# FLIP
	if state==0 and is_on_floor():
		if direction.x>0:
			scale.x = scale.y * 1
		if direction.x<0:
			scale.x = scale.y * -1
	
	# MOVE X
	if is_on_floor():
		if state == 0:
			new_velocity.x += direction.x * groundspeed
	else:
		if state !=2:
			new_velocity.x += direction.x * airspeed
	new_velocity.y += gravity #* get_physics_process_delta_time() #indent?
	#friction
	#velocity.y*=c
	if is_on_floor():
		new_velocity *= groundfriction
	else:
		new_velocity *= airfriction
	
	# MOVE Y
	if direction.y == -1.0 and state == 0:
		if is_on_floor():
			new_velocity.y = -jumpspeed
			anim_player.stop() #resets animation
			anim_player.play("double_jump")
			released_jump = false
		elif released_jump == true and double_jump == true:
			new_velocity.y = -jumpspeed
			anim_player.stop(true) #resets animation
			anim_player.play("double_jump")
			double_jump = false
	if not is_on_floor() and not direction.y == -1.0:
		released_jump = true
		
	if position.y>1000:
		respawn()
	return new_velocity
	

func respawn():
	percentage = 0
	position = Vector2(0,0)


func CheckHurtBoxes() -> Array:
	var HitActors = []
	#print($HurtBox.get_overlapping_areas())
	for hitbox in $HurtBox.get_overlapping_areas():
		if $HurtBox.get_child_count() > 0:
			var opponent=hitbox.get_parent().get_parent()
			
			if opponent != self:
				var data = get_node("../"+opponent.name+"/currentAttack").hitboxes[int(hitbox["name"])]
				if not [opponent, data["group"]] in bannedHitboxes:
					print(data)
					HitActors.append([data,opponent])
					bannedHitboxes.append([opponent,data["group"]]) 
	#print(HitActors)
	return HitActors
