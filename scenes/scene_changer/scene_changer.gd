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
			
#			just tried testing something
			root = get_tree().root
#			yield(get_tree().create_timer(0), "timeout")
#			get_tree().get_root().call_deferred("add_child", resource.instance())
			
			print(root.get_children())
			current_scene.queue_free()
			get_parent().remove_child(current_scene)
			
			loading_bar.queue_free()
#			yield(get_tree(),"idle_frame")
#			yield(get_tree().create_timer(0), "timeout")
#			current_scene.queue_free()
			print(root.get_children())

#			to be able to load the SAME scene with the loading bar function
#			we simply have to just wait abit here AFTER freeing the current_sceen
#			and also dont forget to free it again from the scene itself(when it is leaving
#			to another scene eg: levels_select) this is to prevent duplicate of itself when
#			coming back as scene_changer might not handle that

#			yield(get_tree().create_timer(0), "timeout")
#			yield(get_tree(),"idle_frame")
#			get_tree().get_root().add_child(resource.instance())
			get_tree().get_root().call_deferred("add_child", resource.instance())
			
			break
#		to see the loading progress
		elif err == OK:
#			still loading
			var progress = float(loader.get_stage())/loader.get_stage_count()
			
			loading_bar.value = progress * 100
			loading_bar.get_node("Sprite3").rotation_degrees = progress *400
#			print("progress", progress)
			
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
