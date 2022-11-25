extends Control


	
#onready var input_json = GlobalState.input_json




onready var word_tile_map = $ControTileMap/WordTileMap
onready var crossword_gen = $crossword_generator2_remake

#var combinator_array
onready var combinator_array = $union_combinator.combinator_array



func change_to_end_scene():
	print("thanks for playing")
	
	#	change scene
	get_tree().change_scene("res://scenes/end_screen/end_screen.tscn")
	pass



func _ready():
	var input_json = Levels.levels_json[GlobalState.configFile.get_value("Level_Index","index")]
#	
	var temp_postion
	var temp_color
	
#	animate cookie input
	temp_postion = $cookie_input.rect_position
	$cookie_input/Tween2.interpolate_property($cookie_input, "rect_position", Vector2(0, 220) + temp_postion, temp_postion, 1.0, Tween.TRANS_BACK, Tween.EASE_OUT)
	$cookie_input/Tween2.start()


	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = "LEVEL: " + str(GlobalState.level_index + 1)
#	$Label.text = "level: " + str(get_node("/root/GlobalState").level_index + 1)
	
	
#	this is for the robots_box if he is cheering
	if $robot_box/robot_cheer.frame == 7:
#		print("no longer playing")
		$robot_box/robot_cheer.visible = false
		$robot_box/robot_cheer.playing = false
		$robot_box/robot_idle.visible = true
	if $robot_box/robot_cheer.playing:
		$robot_box/robot_cheer.visible = true
		$robot_box/robot_idle.visible = false



func _input(event):
	if event.is_action_pressed("ui_right"):
		pass

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
		GlobalState.get_node("click_button").play()
		get_tree().change_scene("res://scenes/levels/levels_select.tscn")
		
#		because of the sceneChanger, it sometimes doesnt free us the gameArea properly
#		so have to do it manually when we are leaving
		self.queue_free()
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		# For Android
#		get_tree().paused = true
#		pause.show()
		GlobalState.get_node("click_button").play()
		get_tree().change_scene("res://scenes/levels/levels_select.tscn")
		
#		because of the sceneChanger, it sometimes doesnt free us the gameArea properly
#		so have to do it manually when we are leaving
		self.queue_free()


func _on_WordTileMap_level_completed():
	print("level completed")
	var temp_postion
	var temp_color

#	animate the completed level panel
	yield(get_tree().create_timer(1.0), "timeout")
	$Panel.show()
#	$Panel/level_clear_aniPlay.play("floating")
	temp_postion = $Panel.rect_position
	temp_color = $Panel.modulate
	$Panel/Tween.interpolate_property($Panel, "rect_position", Vector2(0, 390) + temp_postion, temp_postion, 0.9, Tween.TRANS_BACK, Tween.EASE_OUT)
	$Panel/Tween.interpolate_property($Panel, "modulate", temp_color,Color(1,1,1,1), 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Panel/Tween.start()


func _on_nextLevel_pressed():
	GlobalState.get_node("click_button").play()
	
	if GlobalState.level_index+1 < Levels.levels_json.size():

		
		
		var next_level = GlobalState.level_index + 2
		GlobalState.level_index = next_level - 1
		
		
#		GlobalState.load_level(next_level)
		SceneChanger.goto_scene("res://scenes/gameArea.tscn", get_tree().root.get_node("gameArea"))
		

		GlobalState.delete_old_save()
		
		GlobalState.configFile.set_value("Level_Index","index",GlobalState.level_index)
		GlobalState.configFile.save(GlobalState.file_to_save)
		
#	goto disable the button as soon as you press it cause
#	someone can just spam it and pass 16 more levels
	$Panel/nextLevel.disabled = true



func _on_AnimationPlayer_animation_finished(anim_name):
	pass
		


func _on_WordTileMap_game_passed():
#	set the dimming color rect to cover mouse events
	$ColorRect3.mouse_filter = Control.MOUSE_FILTER_STOP
	
	
	yield(get_tree().create_timer(3.0), "timeout")
#	do not forget that inside the animation player, we have set a 
#	method to run at a paricular point
	$ColorRect3/AnimationPlayer.play("fade_out")
	



func _on_robot_box_gui_input(event):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		$robot_box/robot_cheer.frame = 0
		$robot_box/robot_cheer.play()
		$robot_box/click_robo.play()

	
