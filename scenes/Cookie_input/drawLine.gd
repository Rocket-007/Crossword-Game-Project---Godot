# rocket 007
# https://www.youtube.com/channel/UC8G8IEsYtIkj2hxfnRWhkuQ

extends Control

signal word_drag_stop

var delete_all_line_flag = true

var hasExec = false

#onready var combinator_array = get_parent().combinator_array
onready var combinator_array = get_parent().get_node("union_combinator").combinator_array

func displayOverlayDebugging():
	var overlay = load("res://scenes/Cookie_input/debug_overlay.tscn").instance()
#	overlay.add_stat("Custom Button children NO. ", $CustomButtons, "get_child_count", true)
#	overlay.add_stat("Line2d Count ", $Line2D, "get_point_count", true)
	
#	overlay.add_stat("ON BUTTONS 1 ", $CustomButtons/TextureButton, "mouseover", false)
#	overlay.add_stat("ON BUTTONS 2 ", $CustomButtons/TextureButton2, "mouseover", false)
#	overlay.add_stat("ON BUTTONS 3 ", $CustomButtons/TextureButton3, "mouseover", false)
#	overlay.add_stat("ON BUTTONS 4 ", $CustomButtons/TextureButton4, "mouseover", false)

#	overlay.add_stat("Touching", $CustomButtons, "Touching", false)
#	overlay.add_stat("readyToAddLine ", $CustomButtons, "readyToAddLine", false)
	
	
#	overlay.add_stat("is_selected 1 ", $CustomButtons.get_child(0), "is_selected", false)
#	overlay.add_stat("is_selected 2 ", $CustomButtons.get_child(1), "is_selected", false)
#	overlay.add_stat("is_selected 3 ", $CustomButtons.get_child(2), "is_selected", false)
#	overlay.add_stat("is_selected 4 ", $CustomButtons/.get_child(3), "is_selected", false)
#
#	overlay.add_stat("", "", "", false)
#
#	overlay.add_stat("is_backtracking 1 ", $CustomButtons/TextureButton, "is_backtracking", false)
#	overlay.add_stat("is_backtracking 2 ", $CustomButtons/TextureButton2, "is_backtracking", false)
#	overlay.add_stat("is_backtracking 3 ", $CustomButtons/TextureButton3, "is_backtracking", false)
#	overlay.add_stat("is_backtracking 4 ", $CustomButtons/TextureButton4, "is_backtracking", false)
#
#	overlay.add_stat("", "", "", false)
	
#	overlay.add_stat("word_dragged", $CustomButtons, "word_dragged", false)
	
	add_child(overlay)
	
	
	
func _ready():
#	var combinator_array =  get_parent().get_node("union_combinator").combinator_array
	displayOverlayDebugging()
	

	pass
	

#	fuction to get the hovered over button's center
func buttonCenter():
	for v in $CustomButtons.get_children():
		if v.mouseover:
			return v.get_rect().get_center()

#much like the buttonCenter() but this time returns the object 
func get_button_over_itself():
	for v in $CustomButtons.get_children():
		if v.mouseover:
			return v

#actually this does more than just drawing the line
func lineFunction():
#	check if we Pressed down on the first button
	if $CustomButtons.Touching == true:
#		check when we are to add new Line2D Point : 
#		ie : hover over any butten including first pressed button
		if $CustomButtons.readyToAddLine == true:
#			make sure buttoncenter returns vectors and not nulll when called
			if buttonCenter():
	#			is the line point counts 0 |ie: is there no line then
				if $Line2D.get_point_count() == 0:
	#				then create line point at last(basically first) position
					$Line2D.add_point(buttonCenter(),-1)
	#			add new point at the center of hovered button 
	#			(this line point will later be the constantly moving line when we drag) 
				$Line2D.add_point(buttonCenter(),-1)
	#			reposition/set the position of 2nd last line point to center of hovered button
				$Line2D.set_point_position($Line2D.get_point_count()-2, buttonCenter())
	#			set the button is selected to true
				get_button_over_itself().is_selected = true
	#			push the button letter to the front of the drag word array stack
				$CustomButtons.word_dragged.push_back(get_button_over_itself().letter)
#				playsound here
				$drag_click.play()
		
		
		# this is for the backtracking
#		first check that there is a maximum of 2 line
		if $Line2D.get_point_count() > 2:
#			check if the currently hovered button's coord is the same as the second to the last line coord; this is to check if
#			we are in the motion of undoing our stroke 
			if (buttonCenter() == $Line2D.get_point_position($Line2D.get_point_count()-2)): 	# and get_button_over_itself().is_selected:
#				then confirm that the button.gd script says that we are going over an already selected button
				if get_button_over_itself().is_backtracking:
#					remove the line point: at the second to lasttt
#					then set it to not selected
					$Line2D.remove_point($Line2D.get_point_count()-2)
					get_button_over_itself().is_selected = false
#					pop out the back letter if its backtracking
					$CustomButtons.word_dragged.pop_back()
					$undrag_click.play()
	
#		make sure that there are line points in line2D
		if $Line2D.get_point_count() > 0:
#			this will be the last line point that will be following the mouse
#			$Line2D.set_point_position($Line2D.get_point_count()-1,get_global_mouse_position())
			$Line2D.set_point_position($Line2D.get_point_count()-1,get_local_mouse_position())
		
#		at first the else body was executing every frame cause of the condition of touching = false
#		this is important to make the else section only run ONCE we stop  touching any button 
		hasExec = false
	else:
#		check if we have already run this code 
		if !hasExec:
	#		if you release the mouse and flag = true, the whole line2D is cleared
			if delete_all_line_flag:
				$Line2D.clear_points()
	#		finally to clear the word dragged array if we release the mouse button
			emit_signal("word_drag_stop")
			$CustomButtons.word_dragged.clear()
			hasExec = true
				
#	this is to make sure that the word_dragged array size is not exceeded
	if $CustomButtons.word_dragged.size() <= $CustomButtons.get_child_count():
		pass
	else:
		$CustomButtons.word_dragged.pop_front()

#	this will set the labesls text to the array to string form
func outputWord():
	$Label.text = PoolStringArray($CustomButtons.word_dragged).join("")

#also for debug purpose
func _draw():
	for i in $Line2D.get_point_count():
#		we dont want to draw the last circle
		if i == $Line2D.get_point_count() - 1:
			continue
		var default_font = Control.new().get_font("font")
#		draw_string(default_font, $Line2D.get_point_position(i), "            " + str($Line2D.get_point_position(i).round()))
#		draw_string(default_font, $Line2D.get_point_position(i), "             \n\n\n" + str(i))
		draw_circle($Line2D.get_point_position(i), 30.0, Color("a9661c"))
#		$Label.rect_global_position
		for v in $CustomButtons.get_children():
#			draw_circle(v.rect_global_position, 45.0, Color.yellow)
			pass
		


func _process(delta):
	lineFunction()
	outputWord()
	
	$Sprite3.rotation_degrees -= 50*delta
	$Sprite2.rotation_degrees -= 30*delta
	$Sprite.rotation_degrees += 20*delta
	
	update()
	
