# rocket 007
# https://www.youtube.com/channel/UC8G8IEsYtIkj2hxfnRWhkuQ
extends TextureButton

export var letter : String = ""
var has_exec = false
var mouseover = false
var is_selected = false
var is_backtracking = false

onready var combinator_array = get_node("/root/gameArea").get_node("union_combinator").combinator_array



func _ready():
#	loading in label for the buttons
#	var label = load("res://label.tscn").instance()
#	label.text = letter
##	label.set_position().set_global_position() = get_global_rect().get_global_position()
##	label.rect_global_position = rect_global_position
#	add_child(label)

#	noticed a problem with deleting the previous buttons, so gotto check to prevent crash
	if combinator_array.size() >= get_parent().get_child_count():
		pass
	letter = combinator_array[get_parent().get_children().find(self)]

	
	connect("button_down", self, "_on_TextureButtons_down")
	connect("button_up", self, "_on_TextureButtons_up")
	
#	you can comment this out to start seeing the button and the size it contains etc
	self.self_modulate = Color(0,0,0,0)
	
	
func _on_TextureButtons_down():
	get_parent().Touching = true
	get_parent().readyToAddLine = true


func _on_TextureButtons_up():
	get_parent().Touching = false
	mouseover = false
#	this should set all the button is selected to false if we release
	for v in get_parent().get_children():
		v.is_selected = false
#		am just gonna comment this and see what happens
#		v.is_backtracking = false


func checkHover():
	var mousepos = get_viewport().get_mouse_position()
	if get_global_rect().has_point(mousepos):
#	if get_global_rect().has_point(mousepos):
#		the first time you hover, this is not executed, its then the second time
		if !has_exec:
			has_exec = true
			mouseover = true
#			check that the button has been selected before
			if is_selected:
#				then say that it is back tracked if it is hovered again
				is_backtracking = true
			else:
				get_parent().readyToAddLine = true
	else:
		has_exec = false
		mouseover = false
		is_backtracking = false
		pass

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			pass
#			get_parent().readyToAddLine = true
		else:
#			so we can check again if the same button was pressed on android;
			has_exec = false
			for v in get_parent().get_children():
#				v.is_selected = false
#				v.is_backtracking = false
				v.mouseover = false
#			get_parent().Touching = false


func _process(delta):
#	because of mobile compatability i have only update the check hovered buttons only
#	when the first button is pressed down
	if get_parent().Touching:
		pass
		checkHover()
#	
