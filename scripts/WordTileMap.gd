extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var gameArea


onready var cookie_input = get_parent().get_parent().get_node("cookie_input")


var TextureGridTextTscn = preload("res://scenes/TextureGridText.tscn")


var layout


# Called when the node enters the scene tree for the first time.
func _ready():
	gameArea = get_parent().get_parent()
	
	for v in gameArea.input_json:
		if v.size() < 2:
			v.append("clue")
		if v.size() < 3:
			v.append(false)
	
	
#	this was for the old generator
#	var layout = gameArea.get_node("crossword_generator").generateLayout(gameArea.input_json)
#
#	for i in layout.table:
#		print(i)
#	clear()
#	for i in range(layout.table.size()):
#		for j in range(layout.table[i].size()):
#			if layout.table[i][j] != "-":
#				set_cell(j, i, 0)
#	return


			
	layout = gameArea.get_node("crossword_generator2_remake").Crossword.new(10, 10, '-', 2000, gameArea.input_json)

	 
	var start_full = float(OS.get_unix_time())
	
#	var layout = Crossword.new(13, 13, '-', 5000, word_list)
	print("compute crossword() started")
	layout.compute_crossword(2)
	print("compute crossword finished")
	print (layout.word_bank())
	print (layout.solution())
	#print (layout.word_find())
	layout.display()
#	print (layout.display())
	print (layout.legend())
	print (len(layout.current_word_list), 'out of', len(gameArea.input_json))
#	print (len(layout.current_word_list), 'out of', len(word_list))
	print (layout.debug)
	
	var end_full = float(OS.get_unix_time())
	print ("time: ", end_full - start_full)
#---------------------------------

	clear()
	for i in range(layout.rows):
		for j in range(layout.cols):
			if layout.grid[i][j] != "-":
				set_cell(j, i, 0)
#				var texture_grid_text = TextureGridTextTscn.instance()
#				texture_grid_text.text = layout.grid[i][j]

#				all this is just to ensure that the texts position is centered by itself
#				and the grid's cell too
#				so now no matter the size of font for the text so long as the margins
#				are set to over occupy the text, it will work seamlessly
 
#				texture_grid_text.set_position((self.map_to_world(Vector2(j, i)) + self.cell_size/2)  - (texture_grid_text.get_rect().size / 2))
#				add_child(texture_grid_text)
	ready_draw_gridWords()
	
	var temp_postion = self.position
	$Tween.interpolate_property(self, "position", Vector2(200, 0) + temp_postion, temp_postion, 1.2, Tween.TRANS_BACK, Tween.EASE_IN_OUT)
	$Tween.start()
	print(self.get_child_count())
	print(self.get_children())
	
func _on_cookie_input_word_drag_stop():
#	check if we guessed a correct word from the input json var
	for i in range(gameArea.input_json.size()):
		if gameArea.get_node("union_combinator").array_to_string(cookie_input.get_node("CustomButtons").word_dragged) == gameArea.input_json[i][0]:
#			print("got a word: ", gameArea.input_json[i][0])
	
#			find the word in the layout class word list and
#			place the words in the correct position
			for word in layout.current_word_list:
				if word.word == gameArea.input_json[i][0]:
					word.solved = true
					
					var j = word.row - 1
					var k = word.col - 1
					if layout.grid[j][k] != "-":
#						need some variables
						var text_font_size = 35
						var text_x_offset = 50
						var text_y_offset = 0
#						first check if the word is across
						if word.down_across() == "across":
#							then we will increase a var toward the right according to the word length
							for l in range(0, word.length):
#								we will further use the l for letter position and gridText tscn coordinare as well
								var texture_grid_text = TextureGridTextTscn.instance()
								texture_grid_text.text = layout.grid[j][k + l]
#								var temp_font_style = texture_grid_text.get_font("font").duplicate()
#								temp_font_style.size = 90
#								texture_grid_text.add_font_override("font", temp_font_style)

#								texture_grid_text.get_font("font", "texture_grid_text").size = 90
								
#								after creating the grid text instace
#								set the position to the position of the word dragged LABEL scene (need to make it a bit more complicated than that)
								texture_grid_text.set_position(  #set position to
								cookie_input.get_node("Label").rect_global_position / self.scale  #global pos of word dragged LABEL / self.scale (this is to fix if we scale the tile map)
								- (cookie_input.get_node("Label").get_rect().size)  # minus dragged LABEL size (might be == to text font size too)
								- Vector2((cookie_input.get_node("Label").get_total_character_count()-1) * text_font_size, 0)  #make it dynamicly addjusst to the amount of letters
								+ Vector2(text_x_offset * l, text_y_offset))  # spacing btw the letters any other offsetting
								
#								now to animate it to the final grid matching position
								$Tween.interpolate_property(
								texture_grid_text, 
								"rect_position", 
								texture_grid_text.rect_position,
								
								Vector2((self.map_to_world(Vector2(k + l, j)) + self.cell_size/2)  
								- (texture_grid_text.get_rect().size / 2) 
								+ Vector2(0,text_y_offset)),
								
								0.6, Tween.TRANS_BACK, Tween.EASE_IN_OUT, 0.08*l)
#								0.5, Tween.TRANS_BACK, Tween.EASE_OUT, 0.08*l)

								add_child(texture_grid_text)
								print(self.get_child_count())
								$Tween.start()
								
								
								
#						then check for if down
						elif word.down_across() == "down":
							for l in range(0, word.length):
#								same approach for across but for the y axis
								var texture_grid_text = TextureGridTextTscn.instance()
								texture_grid_text.text = layout.grid[j + l][k]
								
								texture_grid_text.set_position(
								cookie_input.get_node("Label").rect_global_position / self.scale
								- (cookie_input.get_node("Label").get_rect().size)
								- Vector2((cookie_input.get_node("Label").get_total_character_count()-1) * text_font_size, 0)
								+ Vector2(text_x_offset * l, text_y_offset))
								
#								now to animate it to the final grid matching position
								$Tween.interpolate_property(
								texture_grid_text, 
								"rect_position", 
								texture_grid_text.rect_position,
								
								Vector2((self.map_to_world(Vector2(k, j + l)) + self.cell_size/2)  
								- (texture_grid_text.get_rect().size / 2) 
								+ Vector2(0,text_y_offset)),
								
								0.6, Tween.TRANS_BACK, Tween.EASE_IN_OUT, 0.08*l)
								
								
								add_child(texture_grid_text)
								print(self.get_child_count())
								$Tween.start()
								
							pass


func ready_draw_gridWords():
#	for i in range(gameArea.input_json.size()):
	for word in layout.current_word_list:
		if word.solved == true:
			var j = word.row - 1
			var k = word.col - 1
			if layout.grid[j][k] != "-":
				var text_font_size = 35
				var text_x_offset = 0
				var text_y_offset = 0
				if word.down_across() == "across":
					for l in range(0, word.length):
						var texture_grid_text = TextureGridTextTscn.instance()
						texture_grid_text.text = layout.grid[j][k + l]
						
						texture_grid_text.set_position(
						Vector2((self.map_to_world(Vector2(k + l, j)) + self.cell_size/2))  
						- (texture_grid_text.get_rect().size / 2) 
						+ Vector2(-900,text_y_offset))
						
						
						$Tween.interpolate_property(texture_grid_text, "rect_position", 
						texture_grid_text.rect_position, 
						
						Vector2((self.map_to_world(Vector2(k + l, j)) + self.cell_size/2)  
						- (texture_grid_text.get_rect().size / 2) 
						+ Vector2(0,text_y_offset)),
						 1.2, Tween.TRANS_BACK, Tween.EASE_IN_OUT, 0.08*l)
						
						
						add_child(texture_grid_text)
						
#						then check for if down
				elif word.down_across() == "down":
					for l in range(0, word.length):
						var texture_grid_text = TextureGridTextTscn.instance()
						texture_grid_text.text = layout.grid[j + l][k]
						
						texture_grid_text.set_position(
						Vector2((self.map_to_world(Vector2(k, j + l)) + self.cell_size/2))  
						- (texture_grid_text.get_rect().size / 2) 
						+ Vector2(680,text_y_offset))
						
						
						$Tween.interpolate_property(texture_grid_text, "rect_position", 
						texture_grid_text.rect_position,
						
						Vector2((self.map_to_world(Vector2(k, j + l)) + self.cell_size/2)  
						- (texture_grid_text.get_rect().size / 2) 
						+ Vector2(0,text_y_offset)),
						 1.0, Tween.TRANS_BACK, Tween.EASE_IN, 0.08*l)
						
#						$Tween.start()
						
						add_child(texture_grid_text)
						

func _process(delta):
	update()
	pass


func _draw():
	draw_circle(cookie_input.get_node("Label").rect_global_position / self.scale   - (cookie_input.get_node("Label").get_rect().size) - Vector2((cookie_input.get_node("Label").get_total_character_count()-1) * 35,0), 10.0, Color.blueviolet)
	pass