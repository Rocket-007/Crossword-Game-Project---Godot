# rocket 007
# https://www.youtube.com/channel/UC8G8IEsYtIkj2hxfnRWhkuQ

extends Node2D

#export var button_number = 10


var Touching = false
var readyToAddLine = false
var word_dragged = []


var TextureButtton_Tscn = preload("res://scenes/Cookie_input/TextureButton.tscn")
var Label_Tscn = preload("res://scenes/Cookie_input/Label.tscn")





func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()


onready var combinator_array = get_node("/root/gameArea").get_node("union_combinator").combinator_array


func _ready():
	delete_children(self)
	var tween = get_tree().root.get_node("gameArea/cookie_input/Tween")
	
	var count = combinator_array.size()
#	var count = 5#button_number
	var radius = Vector2(130,0)
	var center = self.position
	
	var step = 2 * PI / count
	
	

	for i in range(count):
		var spawn_pos =  center + radius.rotated(step * i)
		
		var texture_button = TextureButtton_Tscn.instance()
		
		texture_button.rect_position = center - (texture_button.get_rect().size / 2)
		
#		ohhh my gosh good thing this has vector calculations
#		other wise this would have been a lot more messy
#		center the button position to  minus size divide by 2

		
		tween.interpolate_property(texture_button, "rect_position", texture_button.rect_position, spawn_pos - (texture_button.get_rect().size / 2), 0.5, Tween.TRANS_BACK, Tween.EASE_IN_OUT, i*0.15)
#		tween.start()
		
#		texture_button.set_position(spawn_pos - (texture_button.get_rect().size / 2))
		
		add_child(texture_button)
	
	
	tween.start()
	
	
	for v in get_children():
#		creating a new instance parent node for tthe buttons labels
#		because apperently they said that a control node eg: label does not have a zindex
#		and i need that to make the text come on top of the buttons
		var node_container = Node2D.new()
		
		var label_tscn = Label_Tscn.instance()
		node_container.add_child(label_tscn)
#		
#		this is to make it so any body in this func looking for the label will use this intead
		var label = node_container.get_child(0)
		
#		btw you are supposed to set the positoin after instancing i think
#		v.add_child(node_container)
#		label.rect_global_position = v.rect_position
		label.rect_global_position = v.get_global_rect().get_center()
		
#		this is to text align enum to 0 = left (because center isnt to good for a char)
		label.align = 0
		
#		ran int0 problems on polishing the game: if i size the button instance
#		the label does not center, this seems to fix that
		var instance_button_size = v.rect_size
#		these will off set the label so the character appears in the middle of the button center
#		instead of just the top left edge touching em 
		label.margin_left = (instance_button_size.x/2) - 20#16
		label.margin_top = (instance_button_size.y/2) - 20#16
		
		label.text = v.letter
#		label.text = combinator_array[get_children().find(v)]
		
#		finally we can set the z index of the node with will in turn affect the label child in it
		node_container.set_z_index(0)
		v.add_child(node_container)
		
		
		
	
#
#func _input(event):
#	if event is InputEventMouseButton:
#		if event.pressed:
#			print("screen touched")
#		else:
#			Touching = false
#	if event is InputEventScreenDrag:
#		print("screendrag")
			
func _process(delta):
	readyToAddLine = false
#	update()
	if !Touching:
		for v in get_children():
#			v.mouseover = false
			pass
#
#
func _draw():
#	for v in get_children():
#		if v.get_child(0):
#			draw_circle(v.get_child(0).get_child(0).rect_global_position, 45.0, Color.yellow)
#			var default_font = Control.new().get_font("font")
#			draw_string(default_font, v.get_child(0).get_child(0).rect_global_position,v.get_child(0).get_child(0).text)
	pass
