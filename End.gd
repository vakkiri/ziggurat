extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var time = $"/root/Settings".time
	var time_str = "%.2f" % time
	
	while len(time_str) < 7:
		time_str = "0" + time_str
	
	$AnimatedSprite.frame = int(time_str[0])
	$AnimatedSprite2.frame = int(time_str[1])
	$AnimatedSprite3.frame = int(time_str[2])
	$AnimatedSprite4.frame = int(time_str[3])
	$AnimatedSprite5.frame = int(time_str[5])
	$AnimatedSprite6.frame = int(time_str[6])
	
	print(time)
	print(time_str)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
