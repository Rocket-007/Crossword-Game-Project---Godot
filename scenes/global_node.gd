extends Node2D


onready var current = get_tree().root.get_node("Menu")
onready var current2 = get_tree().root.get_node("Intro")


# Path to save file 
#var path = "user://configuration.cfg"
var path = "res://configuration.cfg"
var file_to_save= path
var file_to_load= path

var level = 0
var clicks = 0
var time = 0

var configFile


func _ready():
#	$AudioStreamPlayer.play()
#	Initiate ConfigFile 
	configFile = ConfigFile.new()  
 

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








# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var root = get_tree().root
#	current = get_tree().root.get_node("Menu")
#	current2 = get_tree().root.get_node("Intro")
	
	
# playing the sounds	
#	if configFile.get_value("Settings","music") == false:
#		GlobalNode.get_node("AudioStreamPlayer").stop()
#	else:
#		if !GlobalNode.get_node("AudioStreamPlayer").playing and root.get_child(root.get_child_count() - 1) != current2:
#			GlobalNode.get_node("AudioStreamPlayer").play()

	

	if root.get_child(root.get_child_count() - 1) == current:
		pass
#		print(root.get_child(root.get_child_count() - 1))
#		GlobalNode.get_node("AudioStreamPlayer").play()
