extends Node2D







#
#var input_json = [
#	{"answer":"standard"},
#	{"answer":"computer"},
#	{"answer":"equipment"},
#	{"answer":"port"},
#	{"answer":"interface"}]


#[0] - word
#[1] - clue
#[2] - solved

var levels_json = [
	[["TAMED", "clue1", true],
	["MEAD", "clue2", true],
	["EAT", "clue3"],
	["ATE", "clue4"],
	["A", "clue4"],
	["MADE", "clue5", true],
	["DAM", "clue6"],
	["MATED", "clue7", true]],

	[["SPIT", "clue2", true],
	["SIP", "clue1", true],
	["KIT", "clue1", true],
	["PIT", "clue1", true],
	["TIP", "clue1", true],
	["INK", "clue1", false],
	["SLIP", "clue1", true],
	["TIP", "clue1", true],
	["SINK", "clue1", true],
	["INK", "clue1", true],
	["SIT", "clue1", true]],
]


var input_json = levels_json[0]

onready var gameArea = get_tree().root.get_node("gameArea")

# Called when the node enters the scene tree for the first time.
func _ready():
#	input_json = levels_json[1]
#	yield(get_tree().create_timer(14.0), "timeout")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(event):
	if event.is_action_pressed("ui_right"):
		print("level complete")
#		get_tree().reload_current_scene()
		input_json = levels_json[0]
		get_tree().change_scene("res://scenes/gameArea.tscn")
