extends Control


	
var input_json = GlobalState.input_json


signal level_passed

onready var word_tile_map = $ControTileMap/WordTileMap
onready var crossword_gen = $crossword_generator

#var combinator_array
onready var combinator_array = $union_combinator.combinator_array

func _ready():
	var temp_postion = $cookie_input.rect_position
	$cookie_input/Tween2.interpolate_property($cookie_input, "rect_position", Vector2(0, 120) + temp_postion, temp_postion, 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
	$cookie_input/Tween2.start()
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(event):
	if event.is_action_pressed("ui_right"):
		emit_signal("level_passed")
