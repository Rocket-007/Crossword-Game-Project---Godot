extends Node2D






var level_index = 0

var input_json = Levels.levels_json[level_index]

onready var gameArea = get_tree().root.get_node("gameArea")


#____________________________________________________
# Path to save file 
#var path = "user://configuration.cfg"
var path = "res://configuration.cfg"
var file_to_save= path
var file_to_load= path

var configFile = ConfigFile.new()


#needed cause i dont what to make each level all have a separete saved data
#so we will claer the saved data when you complete a level
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
		configFile.set_value("Level_Index","index",level_index)
		
#		set all words in the level to not solved
		for i in range(Levels.levels_json[GlobalState.level_index].size()):
			configFile.set_value("Level_Words",Levels.levels_json[GlobalState.level_index][i][0],false)
		
		
		
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
#	if level > Levels.levels_json.size():
#		print("exceeded")
#		return
	input_json = Levels.levels_json[level-1]
	get_tree().change_scene("res://scenes/gameArea.tscn")
	


func _ready():
#	input_json = levels_json[1]
#	yield(get_tree().create_timer(14.0), "timeout")

#_______________________________________________	
#	Initiate ConfigFile 
	configFile = ConfigFile.new()
	createSave()
	
	level_index = configFile.get_value("Level_Index","index")
	

 

	pass


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
		
		load_level(level_index+1)
	else:
		pass
		
		

		
	if event.is_action_pressed("ui_left") and level_index-1 > -1:
			
		delete_old_save()
		
		level_index -= 1
		configFile.set_value("Level_Index","index",level_index)
		configFile.save(file_to_save)
		
		load_level(level_index+1)


