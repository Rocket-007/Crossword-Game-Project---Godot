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
	
	
#	this is for the robots_box if he is cheering
	if $Label/robot_box/robot_cheer.frame == 7:
#		print("no longer playing")
		$Label/robot_box/robot_cheer.visible = false
		$Label/robot_box/robot_cheer.playing = false
		$Label/robot_box/robot_idle.visible = true
	if $Label/robot_box/robot_cheer.playing:
		$Label/robot_box/robot_cheer.visible = true
		$Label/robot_box/robot_idle.visible = false
	pass




func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		# For Windows
		GlobalState.get_node("click_button").play()
		get_tree().change_scene("res://scenes/Main_menu/Menu.tscn")

	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		# For Android
		GlobalState.get_node("click_button").play()
		get_tree().change_scene("res://scenes/Main_menu/Menu.tscn")






func _on_robot_box_gui_input(event):
	if  event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		$Label/robot_box/robot_cheer.frame = 0
		$Label/robot_box/robot_cheer.play()
		$Label/robot_box/click_robo.play()


func _on_Button_pressed():
	GlobalState.get_node("click_button").play()
	get_tree().change_scene("res://scenes/Main_menu/Menu.tscn")
		
