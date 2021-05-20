extends AnimatedSprite

const PROJECTILE = preload("res://OnionBall.tscn")
const SHOOTSOUND = preload("res://OnionShoot.tscn")
const CHARGESOUND = preload("res://OnionCharge.tscn")

var COOLDOWN = 3
var time_until_attack = COOLDOWN
var state = "IDLE"
var max_x
var min_x
var max_speed = 0.1
var accel = 0.025
var dir = "RIGHT"
var speed

# Called when the node enters the scene tree for the first time.
func _ready():
	time_until_attack -= rand_range(0, 3)
	min_x = position.x - 16
	max_x = position.x + 16
	speed = 0

func _process_idle(delta):
	time_until_attack -= delta
	
	if time_until_attack <= 0:
		animation = "attack"
		time_until_attack += COOLDOWN
		state = "ATTACK"
		frame = 0
		var sound = CHARGESOUND.instance()
		sound.position.x = position.x
		sound.position.y = position.y
		get_parent().add_child(sound)
		sound.play()
	else:
		if dir == "RIGHT":
			if position.x < max_x:
				if speed < max_speed:
					speed += accel
			else:
				dir = "LEFT"
				speed = 0.05
		elif dir == "LEFT":
			if position.x > min_x:
				if speed > -max_speed:
					speed -= accel
			else:
				dir = "RIGHT"
				speed = -0.05
				
	position.x += speed * delta * 60
	flip_h = dir == "RIGHT"
				
		
func _process_attack(delta):
	pass
	
func _process(delta):
	if state == "IDLE":
		_process_idle(delta)
	elif state == "ATTACK":
		_process_attack(delta)


func _on_Onion_animation_finished():
	if state == "ATTACK":
		state = "IDLE"
		animation = "idle"
		frame = 0
		var proj = PROJECTILE.instance()
		get_parent().add_child(proj)
		proj.position.x = position.x
		proj.position.y = position.y
		var player_pos = get_parent().get_node("Player").position
		var angle = position.angle_to_point(player_pos) - PI/2
		proj.rotate(angle)
		proj.angle = angle - PI/2
		var sound = SHOOTSOUND.instance()
		sound.position.x = position.x
		sound.position.y = position.y
		get_parent().add_child(sound)
		sound.play()
		
