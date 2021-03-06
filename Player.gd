extends KinematicBody2D

const EXPLOSION = preload("res://PlayerDust.tscn")

var motion = Vector2()
const UP = Vector2(0, -1)
const GRAVITY = 11
const MAX_SPEED = 70
const SPEED_ACCEL = 3
const JUMP = -140
const FRICTION = 15
const AIR_DRAG = 3
const CLIMB_SPEED = -25
const LEFT = 0
const RIGHT = 1
const WALL_JUMP = -100

var left_pressed_last = false
var facing_left = false
var last_dir = LEFT

var MAX_Y = 550 / 4
var vx = 0
var vy = 0
var reset_x = 0
var reset_y = 0
var invincible_timer = 0

var jump_period

var fall_timer = 0
var death_timer = 0

var state = "ALIVE"
var post_climb_timer = 0
var POST_CLIMB_TIME = 0.25

var has_key = false
var diamonds = 0
var health = 100
var target_health = health
var ending = false

func _ready():
	$AnimatedSprite.animation = "idle"
	state = "ALIVE"
	facing_left = false
	vx = 0
	jump_period = 0
	reset_x = position.x
	reset_y = position.y


func is_climbing():
	if facing_left:
		return (Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_left") and is_on_wall())
	else:
		return (Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_right") and is_on_wall())
		
func handle_gravity(delta):
	if not is_climbing():
		if Input.is_action_pressed("jump") or Input.is_action_pressed("ui_up"):
			motion.y += GRAVITY * 0.75
		else:
			motion.y += GRAVITY
	else:
		fall_timer = 0
		motion.y = CLIMB_SPEED
		post_climb_timer = POST_CLIMB_TIME


func handle_movement():
	facing_left = left_pressed_last and not (Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left")) or (Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"))
			
	var dvx
	
	if is_on_floor():
		dvx = FRICTION
	else:
		dvx = AIR_DRAG
		
	if vx > 0 and not Input.is_action_pressed("ui_right"):
		vx = max(vx - dvx, 0)
	elif vx < 0 and not Input.is_action_pressed("ui_left"):
		vx = min(vx + dvx, 0)
		
	if Input.is_action_pressed("ui_right") and not (Input.is_action_pressed("ui_left") and left_pressed_last):
		if vx < 0:
			vx += SPEED_ACCEL * 2
		else:
			vx += SPEED_ACCEL
		
		# Wall jump
		if post_climb_timer > 0 and last_dir == LEFT and Input.is_action_pressed("ui_up"):
			motion.y = WALL_JUMP
			vx += 100
			
		last_dir = RIGHT
	elif Input.is_action_pressed("ui_left") and not (Input.is_action_pressed("ui_right") and not left_pressed_last):
		if vx > 0:
			vx -= SPEED_ACCEL * 2
		else:
			vx -= SPEED_ACCEL
		
		# Wall jump
		if post_climb_timer > 0 and last_dir == RIGHT and Input.is_action_pressed("ui_up"):
			motion.y = WALL_JUMP
			vx -= 100
			
		last_dir = LEFT
	motion.x = vx
	
	$AnimatedSprite.flip_h = !facing_left
	
	# Sounds
	if (is_on_floor() and (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"))) or (is_climbing() and Input.is_action_pressed("ui_up")):
		if not $"/root/WalkSound".playing:
			$"/root/WalkSound".play()
	else:
		$"/root/WalkSound".stop()
	
	if not is_on_floor() and not is_on_wall():
		$AnimatedSprite.animation = "fall"
	elif is_climbing():
		$AnimatedSprite.animation = "climb"
	elif motion.x != 0:
		$AnimatedSprite.animation = "run"
	else:
		$AnimatedSprite.animation = "idle"


func _physics_process(delta):
	if not ending:
		post_climb_timer -= delta
		
		if invincible_timer > 0:
			invincible_timer -= delta
			$AnimatedSprite.visible = rand_range(0, 1) < 0.5
		else:
			$AnimatedSprite.visible = true
			
		if target_health < health:
			health -= delta * 120
		if target_health > health:
			health = target_health
			
		if Input.is_action_just_pressed("ui_right"):
			left_pressed_last = false
		if Input.is_action_just_pressed("ui_left"):
			left_pressed_last = true
		if Input.is_action_just_pressed("ui_down"):
			for area in $Collider.get_overlapping_areas():
				if area.name == "DoorArea" and has_key or diamonds == 5:
					area.use()
				elif area.name == "DoorArea":
					$"/root/DoorBuzz".play()
		
		handle_gravity(delta)
		
		if (motion.y > MAX_Y):
			motion.y = MAX_Y
		if (vx > MAX_SPEED):
			vx = MAX_SPEED
		if (vx < -MAX_SPEED):
			vx = -MAX_SPEED
			
		jump_period -= delta;
		if (jump_period < 0):
			jump_period = 0
			
		handle_movement()
		
		if is_on_floor():
			jump_period = 0.2
			if fall_timer > 0.5:
				# $"/root/FallSound".play()
				fall_timer = 0
		else:
			fall_timer += delta
		if jump_period > 0 or post_climb_timer > 0:
			if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("ui_up"):
				motion.y = JUMP
				$"/root/JumpSound".play()
				jump_period = 0
				if is_on_floor():
					var e = EXPLOSION.instance()
					e.position.x = position.x
					e.position.y = position.y
					get_parent().add_child(e)
			
		var prex = position.x
		var prey = position.y
		motion = move_and_slide(motion, UP)
		if position.x < 0:
			position.x = 0
			
		if fall_timer >= 4 or health <= 0:
			get_tree().reload_current_scene()
	else:
		$AnimatedSprite.visible = false
		
func hit(damage):
	if invincible_timer <= 0:
		target_health -= damage
		invincible_timer = 0.1
