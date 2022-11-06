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

func createSave():
	configFile.load(file_to_load) 
	var err = configFile.load(file_to_load) 
	if err != OK:
		# Add values to file 
		configFile.set_value("Highest","level",0) 
		configFile.set_value("Highest","clicks",0) 
		configFile.set_value("Highest","time",0)

		configFile.set_value("Overall","clicks",0) 
		configFile.set_value("Overall","time",0)
		
		configFile.set_value("Settings","music",true)
		configFile.set_value("Settings","sfx",true)
	 
		# Save file 
		configFile.save(file_to_save)

#
#	if configFile.has_section("Highest"):
#		pass
#
#	if configFile.has_section("Overall"):
#		pass



func load_level(level): # funciton has the job of changing the crossword input and scene
	input_json = Levels.levels_json[level-1]
	get_tree().change_scene("res://scenes/gameArea.tscn")
		


func _ready():
#	input_json = levels_json[1]
#	yield(get_tree().create_timer(14.0), "timeout")

#_______________________________________________	
#	Initiate ConfigFile 
	configFile = ConfigFile.new()
	createSave()
	print("created save")

 

	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(event):
	if event.is_action_pressed("ui_right"):
		print("level complete")
		level_index += 1
#		get_tree().reload_current_scene()
		load_level(level_index+1)
		

		
	if event.is_action_pressed("ui_left"):
		level_index -= 1
#		get_tree().reload_current_scene()
		load_level(level_index+1)


