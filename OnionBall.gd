extends AnimatedSprite

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
		queue_free()


func _on_Area2D_area_entered(area):
	if area.get_parent().name == "Player":
		area.get_parent().hit(10)
		queue_free()
	elif not area.is_in_group("Monster"):
		queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "TileMap":
		queue_free()
	elif body.name == "Player":
		body.hit(40)
		queue_free()
