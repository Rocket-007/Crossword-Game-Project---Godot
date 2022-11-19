extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for v in get_children():
#		v.position.y -= 30*delta
		v.rotation_degrees += (20 / v.scale.x)*delta
