extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("runing_particle1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.rect_position.y -= 30 * delta
	pass
