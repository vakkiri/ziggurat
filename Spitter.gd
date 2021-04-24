extends StaticBody2D

const PROJECTILE = preload("res://Shard.tscn")
const EXPLOSION = preload("res://IceCloud.tscn")

const COOLDOWN = 0.5
const ATTACK_DURATION = 2

var attack_timer = 0
var cooldown_timer = 0
var state = "IDLE"
const SHOT_CD = 0.15
var shot_timer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.playing = false



func _process(delta):
	if cooldown_timer > 0:
		cooldown_timer -= delta
		
	if state == "ATTACK":
		attack_timer -= delta
		if attack_timer <= 0:
			cooldown_timer = COOLDOWN
			state = "IDLE"
			$AnimatedSprite.playing = false
			$AnimatedSprite.frame = 0
		else:
			shot_timer -= delta
			if shot_timer <= 0:
				if rand_range(0, 100) < 75:
					var proj = PROJECTILE.instance()
					proj.position.x = position.x + rand_range(-4, 4)
					proj.position.y = position.y
					get_parent().add_child(proj)
					for i in range(3):
						var e = EXPLOSION.instance()
						e.position.x = position.x + rand_range(-2, 2)
						e.position.y = position.y + rand_range(-2, 2) - 4
						get_parent().add_child(e)
				shot_timer += SHOT_CD		

				


func _on_Area2D_body_entered(body):
	if body.name == "Player" and state == "IDLE" and cooldown_timer <= 0:
		state = "ATTACK"
		attack_timer = ATTACK_DURATION
		$AnimatedSprite.frame = 0
		$AnimatedSprite.playing = true


func _on_Area2D_body_exited(body):
	if body.name == "Player" and state == "IDLE" and cooldown_timer <= 0:
		state = "ATTACK"
		attack_timer = ATTACK_DURATION
		$AnimatedSprite.frame = 0
		$AnimatedSprite.playing = true
