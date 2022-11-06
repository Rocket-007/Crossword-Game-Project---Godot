extends Node





func goto_scene(path, current_scene):
	var loader = ResourceLoader.load_interactive(path)
	
	if loader == null:
		print("unable to open the resource at file path")
		return
	var loading_bar = load("res://scenes/scene_changer/ProgressBar.tscn").instance()
	get_tree().get_root().call_deferred("add_child", loading_bar)
	
	
	
	while true:
		var err = loader.poll()
		if err == ERR_FILE_EOF:
#			loading complete
			var resource = loader.get_resource()
			get_tree().get_root().call_deferred("add_child", resource.instance())
			

			current_scene.queue_free()
			loading_bar.queue_free()
			break
#		to see the loading progress
		elif err == OK:
#			still loading
			var progress = float(loader.get_stage())/loader.get_stage_count()
			
			loading_bar.value = progress * 100
			print("progress", progress)
			
		else:
#			print("error wile loading file")
			break
			
		yield(get_tree(),"idle_frame")
			
			





onready var root = get_tree().root
onready var current_scene = root.get_child(root.get_child_count() - 1)


# Called when the node enters the scene tree for the first time.
func _ready():
	root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	
#	goto_scene("res://scenes/gameArea.tscn", current_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
