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
var _velocity: = Vector2(0,-100) #pixels per second
var direction: = Vector2.ZERO
var released_jump = false
var double_jump = true
var state = 0
var stateTimer = 0

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer") #basically just declared in _ready func

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	# input 
	direction = get_direction()
	# movement
	_velocity = calculate_move_velocity(_velocity, direction) # should be += and friction for nice movement (wut
	_velocity = move_and_slide(_velocity, Vector2.UP)
	# options
	if state==0:
		if Input.get_action_strength("attack"):
			attack()
	# hitting
	var HitActors = CheckHurtBoxes()
	if HitActors:
		state = 2
		stateTimer = 0
		anim_player.stop(true) #resets animation
		anim_player.play("shake")
	else:
		stateTimer+=1
		if stateTimer == 60:
			state = 0
			anim_player.stop(true)
	# hit out of attack? check janky?
	if state!=1:
		for i in $HitBoxes.get_children():
			i.queue_free()
		#removeHitboxBans

func get_direction():
	return Vector2(
		Input.get_action_strength("move_right")-Input.get_action_strength("move_left"),
		-1.0 if Input.get_action_strength("jump") else 1.0 #is_on_floor updated by moveandslide
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
	if state==0:
		if direction.x>0:
			scale.x = scale.y * 1
		if direction.x<0:
			scale.x = scale.y * -1
	
	# MOVE X
	if is_on_floor():
		if state == 0:
			new_velocity.x += direction.x * groundspeed
	else:
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
			anim_player.stop(true) #resets animation
			anim_player.play("double_jump")
			released_jump = false
		elif released_jump == true and double_jump == true:
			new_velocity.y = -jumpspeed
			anim_player.stop(true) #resets animation
			anim_player.play("double_jump")
			double_jump = false
	if not is_on_floor() and not direction.y == -1.0:
		released_jump = true
	return new_velocity

func attack():
	state = 1
	stateTimer = 0
	anim_player.stop(true) #resets animation
	anim_player.play("punchin")
	createHitBox()

func createHitBox():
	"""
	for i in HitBoxData[CurrentHitBoxFrame]:
		var _bs = BoxShape.new()
		_bs.extents.x = float(i[3])/2
		_bs.extents.y = float(i[4])/2
		_bs.extents.z = 1
		
		var _sp = CollisionShape.new()
		_sp.shape = _bs
		_sp.transform.origin.x = i[0]
		_sp.transform.origin.y = i[1]
		_sp.rotation_degrees.z = i[2]
		$HitBox.add_child(_sp)
		_sp.set_owner(self)
	"""
	var hitbox = Area2D.new()
	$HitBoxes.add_child(hitbox)
	hitbox.set_collision_layer(4)
	hitbox.set_collision_mask(0)
	hitbox.set_name("the one")
	var _bs = RectangleShape2D.new()
	_bs.extents.x = 20
	_bs.extents.y = 20
	
	var _sp = CollisionShape2D.new()
	_sp.shape = _bs
	_sp.transform.origin.x = 80
	_sp.transform.origin.y = -40
	#_sp.rotation_degrees.z = 0
	hitbox.add_child(_sp)
	_sp.set_owner(self)

func CheckHurtBoxes() -> Array:
	var HitActors = []
	#print($HurtBox.get_overlapping_areas())
	for n in $HurtBox.get_overlapping_areas():
		if $HurtBox.get_child_count() > 0:
			
			if n.get_parent() != self:
				HitActors.append([n.get_parent(),self]) 
	#print(HitActors)
	return HitActors
