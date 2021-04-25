extends AnimatedSprite

var hit = false
var v = 0
var maxv = 100
var accel = 60

# Called when the node enters the scene tree for the first time.
func _ready():
	if  not $"/root/Settings".flashing:
		frame = int(rand_range(0, 4))
		playing = false


func _process(delta):
	if v < maxv:
		v += accel * delta
		
	position.y += v * delta
	
	if position.y > 512:
		queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.hit(20)
			
	if not hit:
		v = -30
		hit = true
		playing = false
