extends Button


var passed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if !self.passed:
		self_modulate = Color("2b2a2a") #("282525") #("a4a4a4")
		self.mouse_filter = Control.MOUSE_FILTER_IGNORE


func _process(delta):
	pass
