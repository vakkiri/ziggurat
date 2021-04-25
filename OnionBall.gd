extends AnimatedSprite

const EXPLOSION = preload("res://IceCloud.tscn")

var angle = 0
var speed = 100
var max_life = 3
var life = max_life

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	position.x += speed * cos(angle) * delta
	position.y += speed * sin(angle) * delta

	life -= delta
	
	if (speed > 0):
		speed -= 60 * delta
		
	if life <= 0 or speed <= 0:
		_die()


func _die():
	for i in range(3):
		var e =EXPLOSION.instance()
		e.position.x = position.x + rand_range(-4, 4)
		e.position.y = position.y + rand_range(-2, 2)
		get_parent().add_child(e)
		
	queue_free()
		
func _on_Area2D_area_entered(area):
	if area.get_parent().name == "Player":
		area.get_parent().hit(10)
		_die()
	elif not area.is_in_group("Monster"):
		_die()


func _on_Area2D_body_entered(body):
	if body.name == "TileMap":
		_die()
	elif body.name == "Player":
		body.hit(40)
		_die()
