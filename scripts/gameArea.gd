extends Control


	
var input_json = GlobalState.input_json


signal level_passed

onready var word_tile_map = $ControTileMap/WordTileMap
onready var crossword_gen = $crossword_generator2_remake

#var combinator_array
onready var combinator_array = $union_combinator.combinator_array

func _ready():
	var temp_postion = $cookie_input.rect_position
	$cookie_input/Tween2.interpolate_property($cookie_input, "rect_position", Vector2(0, 120) + temp_postion, temp_postion, 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
	$cookie_input/Tween2.start()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = "level: " + str(get_node("/root/GlobalState").level_index + 1)




func _input(event):
	if event.is_action_pressed("ui_right"):
		emit_signal("level_passed")

	if event is InputEventKey and event.scancode == KEY_Q:# and not event.echo:
		get_tree().quit()
#		get_tree().paused = true
#		pause.show()
		pass
		
		
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		# For Windows
#		get_tree().paused = true
#		pause.show()
		pass
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		# For Android
#		get_tree().paused = true
#		pause.show()
		get_tree().change_scene("res://scenes/levels/levels_select.tscn")
