extends Control




func format_seconds(time : float, use_milliseconds : bool) -> String:
	var minutes := time / 60
	var seconds := fmod(time, 60)
	if not use_milliseconds:
		return "%02d:%02d" % [minutes, seconds]
	var milliseconds := fmod(time, 1) * 100
	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]



# Called when the node enters the scene tree for the first time.
func _ready():
#	GlobalNode.get_node("AudioStreamPlayer").play()
	$VBoxContainer/Button.grab_focus()


func _process(delta):
#	$VBoxContainer3/Label2.text = "LEVEL: " + str(GlobalNode.configFile.get_value("Highest","level"))
#	$VBoxContainer3/Label3.text = "ClCKS: " + str(GlobalNode.configFile.get_value("Highest","clicks"))
#	$VBoxContainer3/Label4.text = "TIME: " + str(format_seconds(GlobalNode.configFile.get_value("Highest","time"), false))
	pass



func _on_Button_pressed():
	$AudioStreamPlayer.play()
	get_tree().change_scene("res://Scenes/play_button.tscn")


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
