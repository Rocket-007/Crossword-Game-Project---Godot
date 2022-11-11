extends Control


var levels_json = Levels.levels_json.duplicate(true)

var B_utton = preload("res://scenes/levels/levelButton.tscn")
var picked_level = 1
var padding_top_buttom = 100

func select_level(v):
	picked_level = $Popup.get_children().find(v)+1

	print("pressed ",picked_level)
	
	GlobalState.level_index = picked_level - 1
	GlobalState.load_level(picked_level)
	
func gen_level_grids():
	var starting_button = $Popup/Button
	var starting_position = $Popup/Button.rect_position
	
	var padding = 40
	
	var button_per_level = 10
	var level_count = levels_json.size()
	var level_box_sections = level_count / button_per_level
	var level_box_remender = level_count % button_per_level
	
	
	
	for i in range(1,level_count):
		
		var button = B_utton.instance()
		
#		make some levels passed just to test
#		note that the first button here is actually the second in the
#		tree, so also the last
		if false: # i == 1 or i == 2 or i == 3:
			button.passed = true
			button.mouse_filter = Control.MOUSE_FILTER_IGNORE
		
#		position the buttons
		button.rect_position = starting_position
#		adjust vertical position
		button.rect_position.y += (
		(button.rect_size.y * (i))
		+ padding_top_buttom*i)
		
#		button text
#		button.text = str($Popup.get_children().find(button)+1)
		
#		connect the signals
		if button.is_connected("pressed", self, "select_level"):
			pass
		else:
			button.connect("pressed", self, "select_level", [button])
		
		$Popup.add_child(button)
		button.text = str($Popup.get_children().find(button)+1)
		
		pass



func expand_menuButton():
	var active_button
	var temp_postion
	var temp_scale
	var temp_color

	active_button = $Popup.get_child(GlobalState.level_index)
	temp_postion = active_button.rect_position
	temp_scale = active_button.rect_scale
	temp_color =active_button.modulate
	
	$Tween.remove(active_button)
	
	$Tween.interpolate_property(active_button, "modulate", temp_color,Color(1,1,1,0.4), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(active_button, "rect_scale", temp_scale,Vector2(1.2,1.2), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	
	$Tween.start()

func shrink_menuButton():
	var active_button
	var temp_postion
	var temp_scale
	var temp_color
	
	active_button = $Popup.get_child(GlobalState.level_index)
	temp_postion = active_button.rect_position
	temp_scale = active_button.rect_scale
	temp_color = active_button.modulate

	$Tween.remove(active_button)

	$Tween2.interpolate_property(active_button, "modulate", temp_color,Color(1,1,1,1), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween2.interpolate_property(active_button, "rect_scale", temp_scale, Vector2(0.9,0.9), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
#
	$Tween2.start()



func set_slider(the_slide):
#	for some reasons leaving the slider at 100 does not work well
#	so have to use the size of a button + the paddings 
	the_slide.max_value = $Popup/Button.rect_size.y + padding_top_buttom
	
	the_slide.value = (the_slide.max_value/levels_json.size()) * GlobalState.level_index
	pass



func _ready():
	for i in (100):
#		levels_json.append("")
		pass
	
	$Popup.show()
	
	set_slider($VSlider)
	
	gen_level_grids()


#	make all buttons behind the current level index to be passed and not clickable
	for i in range(GlobalState.level_index + 1):
		$Popup.get_child(i).passed = true
		$Popup.get_child(i).self_modulate = Color("ffffff")
		$Popup.get_child(i).mouse_filter = Control.MOUSE_FILTER_IGNORE
	
#	override and make the current selected level index to be selectable and a diff color
	$Popup.get_child(GlobalState.level_index).passed = true
	$Popup.get_child(GlobalState.level_index).self_modulate = Color("a4a4a4") 
#	$Popup.get_child(GlobalState.level_index).self_modulate = Color("ffa700")
	$Popup.get_child(GlobalState.level_index).mouse_filter = Control.MOUSE_FILTER_STOP


#	expand animation
	expand_menuButton()





func _process(delta):
	for v in $Popup.get_children():
		if v.is_connected("pressed", self, "select_level"):
			pass
		else:
			v.connect("pressed", self, "select_level", [v])
			
#	so when you are scrolling it doesnt go out of the screen
	$Popup.rect_position.y = -($VSlider.value)* (levels_json.size()-1)

#	update()



func _input(event):

	if event is InputEventKey and event.scancode == KEY_Q:# and not event.echo:
		get_tree().quit()
		pass



func draw_empty_circle(circle_center, circle_radius, c_olor, resolution):
	var draw_counter = 1
	var line_origin = Vector2()
	var line_end = Vector2()
	line_origin = circle_radius + circle_center
	
	while draw_counter <= 360:
		line_end = circle_radius.rotated(deg2rad(draw_counter)) + circle_center
		draw_line(line_origin, line_end, c_olor)
		draw_counter += 1/ resolution
		line_origin = line_end
		
	line_end = circle_radius.rotated(deg2rad(360)) + circle_center
	draw_line(line_origin, line_end, c_olor)
	pass

func _draw():
#	this is needed for making the circle an elipse
#	draw_set_transform($Popup.get_child(GlobalState.level_index).rect_global_position + ($Popup.get_child(GlobalState.level_index).rect_size/2), 0, Vector2(1.2,1))
#
#	draw_arc(Vector2(0,0), 100, 0, TAU,40, Color("b5fa8100"), 10)
#	draw_empty_circle($Popup.get_child(GlobalState.level_index).rect_global_position + ($Popup.get_child(GlobalState.level_index).rect_size/2), 150, 0, TAU,1, Color.red)
	pass


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		# For Windows
#		get_tree().paused = true
#		pause.show()
		get_tree().change_scene("res://scenes/Main_menu/Menu.tscn")
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		# For Android
#		get_tree().paused = true
#		pause.show()
		get_tree().change_scene("res://scenes/Main_menu/Menu.tscn")




func _on_Tween_tween_completed(object, key):
	 shrink_menuButton()



func _on_Tween2_tween_completed(object, key):
	 expand_menuButton()



