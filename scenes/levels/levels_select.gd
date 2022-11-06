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


func set_slider(the_slide):
#	for some reasons leaving the slider at 100 does not work well
#	so have to use the size of a button + the paddings 
	the_slide.max_value = $Popup/Button.rect_size.y + padding_top_buttom
	
	the_slide.value = (the_slide.max_value/levels_json.size()) * GlobalState.level_index
	pass
	


func _ready():
	for i in (100):
		levels_json.append("")
		pass
	
	$Popup.show()
	
	set_slider($VSlider)
	
	gen_level_grids()
	
#	make the selected button active
	$Popup.get_child(GlobalState.level_index).grab_focus()
	
	
func _process(delta):
	for v in $Popup.get_children():
		if v.is_connected("pressed", self, "select_level"):
			pass
		else:
			v.connect("pressed", self, "select_level", [v])
			
#	so when you are scrolling it doesnt go out of the screen
	$Popup.rect_position.y = -($VSlider.value)* (levels_json.size()-1)
#	$Popup.rect_position.y = -(100/$VSlider.value)



func _input(event):

	if event is InputEventKey and event.scancode == KEY_Q:# and not event.echo:
		get_tree().quit()
		pass














