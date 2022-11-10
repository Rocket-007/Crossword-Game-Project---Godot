extends Control







var hasExec = false



func format_seconds(time : float, use_milliseconds : bool) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)
	if not use_milliseconds:
		return "%02d:%02d" % [minutes, seconds]
	var milliseconds := fmod(time, 1) * 100
	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]






func expand_menuButton():
	var temp_postion
	var temp_scale
	
#	animate the buttons level panel
#	yield(get_tree().create_timer(1.0), "timeout")
	temp_postion = $VBoxContainer.rect_position
	temp_scale = $VBoxContainer.rect_scale
#		$VBoxContainer/Tween.interpolate_property($VBoxContainer, "rect_position", temp_postion, temp_postion + Vector2(0, 90), 0.9, Tween.TRANS_BACK, Tween.EASE_OUT)
	$VBoxContainer/Tween.interpolate_property($VBoxContainer, "rect_scale", temp_scale,Vector2(1.1,1.1), 1.6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	$VBoxContainer/Tween.start()

func shrink_menuButton():
	var temp_postion
	var temp_scale

	temp_postion = $VBoxContainer.rect_position
	temp_scale = $VBoxContainer.rect_scale
#	$VBoxContainer/Tween.interpolate_property($VBoxContainer, "rect_position", temp_postion - Vector2(0, 90) , temp_postion, 0.9, Tween.TRANS_BACK, Tween.EASE_OUT)
	$VBoxContainer/Tween2.interpolate_property($VBoxContainer, "rect_scale", temp_scale, Vector2(0.9,0.9), 1.6, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#
	$VBoxContainer/Tween2.start()




# Called when the node enters the scene tree for the first time.
func _ready():
#	GlobalNode.get_node("AudioStreamPlayer").play()
	$VBoxContainer/Button.grab_focus()
	expand_menuButton()
	
	

func _process(delta):
	pass








func _on_Button_pressed():
	$AudioStreamPlayer.play()
	get_tree().change_scene("res://Scenes/levels/levels_select.tscn")


func _on_Button2_pressed():
	$AudioStreamPlayer.play()
#	var options = load("res://debug_overlay.tscn").instance()
	get_tree().change_scene("res://Scenes/options_button.tscn")


func _on_Button3_pressed():
	$AudioStreamPlayer.play()
	get_tree().quit()
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		# For Windows
		get_tree().quit()

	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		# For Android
		get_tree().quit()


func _on_socialB_pressed():
	OS.shell_open("https://www.youtube.com/channel/UC8G8IEsYtIkj2hxfnRWhkuQ")


func _on_socialB2_pressed():
	OS.shell_open("https://rocket-007.itch.io/")


func _on_socialB3_pressed():
	OS.shell_open("https://github.com/Rocket-007")


func _on_Tween_tween_completed(object, key):
	 shrink_menuButton()



func _on_Tween2_tween_completed(object, key):
	 expand_menuButton()
