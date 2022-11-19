extends Node2D






var level_index
#var level_index = 0

var input_json
#var input_json = Levels.levels_json[level_index]





var root
var current




onready var gameArea = get_tree().root.get_node("gameArea")
onready var level_select = get_tree().root.get_node("level_select")
onready var Menu = get_tree().root.get_node("Menu")





#____________________________________________________
# Path to save file 
#var path = "user://configuration.cfg"
var path = "res://configuration.cfg"
var file_to_save= path
var file_to_load= path

var configFile = ConfigFile.new()


#needed cause i dont what to make each level all have a separete saved data
#so we will claer the saved data when you complete a level or in other use cases
#when u use the arrow keys
func delete_old_save():
	for v in configFile.get_section_keys("Level_Words"):
		configFile.erase_section_key("Level_Words", v)
		print("cleared save ", v)
	configFile.save(file_to_save)



func createSave():
	configFile.load(file_to_load) 
	var err = configFile.load(file_to_load) 
	if err != OK:
		# Add values to file 
		configFile.set_value("Highest","level",0) 
		configFile.set_value("Highest","clicks",0) 
		configFile.set_value("Highest","time",0)
		
#		set the level index to level 1
		configFile.set_value("Level_Index","index",0)
		
#		set all words in the level to not solved
		for i in range(Levels.levels_json[0].size()):
			configFile.set_value("Level_Words",Levels.levels_json[0][i][0],false)
		
		
		
		configFile.set_value("Overall","clicks",0) 
		configFile.set_value("Overall","time",0)
		
		configFile.set_value("Settings","music",true)
		configFile.set_value("Settings","sfx",true)
	 
		# Save file 
		configFile.save(file_to_save)
		print("created save")
#
#	if configFile.has_section("Highest"):
#		pass
#
#	if configFile.has_section("Overall"):
#		pass



func load_level(level): # funciton has the job of changing the crossword input and scene
#	unfortunatl most fuctions dont rely on this any more
	input_json = Levels.levels_json[level-1]
	get_tree().change_scene("res://scenes/gameArea.tscn")
	


func _ready():
#	play song 
	$mainMenu_track.play(1.35)
	
	
#	input_json = levels_json[1]
#	yield(get_tree().create_timer(14.0), "timeout")

#_______________________________________________	
#	Initiate ConfigFile 
	configFile = ConfigFile.new()
	createSave()
	
	level_index = configFile.get_value("Level_Index","index")
	input_json = Levels.levels_json[level_index]
	
	pass






func _process(delta):
#	gameArea = get_tree().root.get_node("gameArea")
#	level_select = get_tree().root.get_node("level_select")
#	Menu = get_tree().root.get_node("Menu")
	
	root = get_tree().root
	current = root.get_child(root.get_child_count() - 1)
	
# playing the sounds	
#	if configFile.get_value("Settings","music") == false:
#		GlobalNode.get_node("AudioStreamPlayer").stop()
#	else:
#		if !GlobalNode.get_node("AudioStreamPlayer").playing and root.get_child(root.get_child_count() - 1) != current2:
#			GlobalNode.get_node("AudioStreamPlayer").play()

#	check if the current scene is gameArea
	if current.get_filename() == "res://scenes/gameArea.tscn":
#		then stop the mainMenu track
		$mainMenu_track.stop()
#		then check if we are not playing the gametrack
		if !GlobalState.get_node("game_track").playing: # and root.get_child(root.get_child_count() - 1) != current2:
			print("game track play")
#			then play the gametrack
#			GlobalState.get_node("game_track").play()
			GlobalState.get_node("game_track").play(3.2)
#	else if we are in menu or level select screens
	elif current.name == "level_select" or current.name == "Menu" or current.name == "options_button":
		if !$mainMenu_track.playing:
	#		stop game track and play mainmenu track
			GlobalState.get_node("game_track").stop()
			$mainMenu_track.play(1.35)










# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(event):
#	make sure we dont go off the bonds of the Level.level_json size
	if event.is_action_pressed("ui_right") and level_index+1 < Levels.levels_json.size():
		delete_old_save()
		
		level_index += 1
		configFile.set_value("Level_Index","index",level_index)
		configFile.save(file_to_save)
		
#		we are no longer using the loadLevel function cause we wanted to add
#		the cool loading screen and bar
#		load_level(level_index+1)
		
#		we also want to update the GlobState's own input_json(tho no other node uses it again as ref)
		input_json = Levels.levels_json[(level_index)]
		SceneChanger.goto_scene("res://scenes/gameArea.tscn", get_tree().root.get_node("gameArea"))
		
		GlobalState.get_node("click_button").play()
	
	
	
	if event.is_action_pressed("ui_left") and level_index-1 > -1:
		delete_old_save()
		
		level_index -= 1
		configFile.set_value("Level_Index","index",level_index)
		configFile.save(file_to_save)
		
#		load_level(level_index+1)
		
#		we also want to update the GlobState's own input_json(tho no other node uses it again as ref)
		input_json = Levels.levels_json[(level_index)]
		SceneChanger.goto_scene("res://scenes/gameArea.tscn", get_tree().root.get_node("gameArea"))

		
		GlobalState.get_node("click_button").play()


