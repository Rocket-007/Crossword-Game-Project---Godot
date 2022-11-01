extends Node



class Word:
	func _init(word=null, clue=null):
#		self.word = re.sub(r'\s', '', word.lower())
		self.clue = clue
		self.length = len(self.word)
		# the below are set when placed on board
		self.row = null
		self.col = null
		self.vertical = null
		self.number = null

 
	func down_across(): # return down or across
		if self.vertical: 
			return 'down'
		else: 
			return 'across'
 
	func __repr__():
		return self.word
		
		
		
		
		
		
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
