extends AnimatedSprite

const EXPLOSION = preload("res://IceCloud.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	position.y -= 90 * delta

func _die():
	for i in range(3):
		var e =EXPLOSION.instance()
		e.position.x = position.x + rand_range(-4, 4)
		e.position.y = position.y + rand_range(-2, 2)
		get_parent().add_child(e)
		
	queue_free()
	
func _on_Shard_area_entered(area):
	if area.get_parent().name == "Player":
		area.get_parent().hit(10)
		_die()
	if not area.is_in_group("Monster"):
		_die()



func _on_Shard_body_entered(body):
	if body.name == "TileMap":
		_die()
	elif body.name == "Player":
		body.hit(35)
		_die()
