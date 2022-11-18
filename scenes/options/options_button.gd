extends Control






func _ready():
#	need to set the toggle button for the music and sfx to the AudioSevers mute values
	$VBoxContainer/HBoxContainer/Button.pressed = not AudioServer.is_bus_mute(AudioServer.get_bus_index("music"))
	$VBoxContainer/HBoxContainer/Button2.pressed = not AudioServer.is_bus_mute(AudioServer.get_bus_index("sfx"))


func _on_Button2_pressed():
	GlobalState.get_node("click_button").play()
	OS.shell_open("https://github.com/Rocket-007/BALLSBEAT-first-game-jam-")


func _on_Button3_pressed():
	GlobalState.get_node("click_button").play()
	get_tree().change_scene("res://Scenes/help_button.tscn")


func _on_Button4_pressed():
	GlobalState.get_node("click_button").play()
	OS.shell_open("https://rocket-007.itch.io/ballsbeat-first-jam-2022-godot")


func _on_Button5_pressed():
	GlobalState.get_node("click_button").play()
	get_tree().change_scene("res://Scenes/Main_menu/Menu.tscn")
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		# For Windows
		GlobalState.get_node("click_button").play()
		get_tree().change_scene("res://Scenes/Main_menu/Menu.tscn")

	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		# For Android
		GlobalState.get_node("click_button").play()
		get_tree().change_scene("res://Scenes/Main_menu/Menu.tscn")



func _on_Button_toggled(button_pressed):
	GlobalState.get_node("click_button").play()
#	toggle to mute the music bus
#	also stop the playing (mainmenu track) music too so as to start from afresh
	AudioServer.set_bus_mute(AudioServer.get_bus_index("music"), not button_pressed)
	GlobalState.get_node("mainMenu_track").stop()
	pass


func _on_Button2_toggled(button_pressed):
	GlobalState.get_node("click_button").play()
#	toggle to mute the sfx bus
	AudioServer.set_bus_mute(AudioServer.get_bus_index("sfx"), not button_pressed)
	pass
