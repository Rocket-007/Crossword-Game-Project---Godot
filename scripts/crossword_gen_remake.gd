# rocket007
# https://www.youtube.com/channel/UC8G8IEsYtIkj2hxfnRWhkuQ

extends Node


class MyCustomSorter:
	static func sort_ascending(a, b):
		if a[0] < b[0]:
			return true
		return false
	static func sort_decending(a, b):
		if a[0] > b[0]:
			return true
		return false
	static func sort_decending_arrLength(a, b):
		if a.get("word").length() > b.get("word").length():
#		if a.word.length() > b.word.length():
			return true
		return false	
	static func sort_decending_bestScore(a, b):
		if a[4] > b[4]:
			return true
		return false
	static func sort_ascending_numberWords(a, b):
		if a.col+a.row < b.col+b.row:
			return true
		return false



class Word:
	var word
	var clue
	var length
	# the below are set when placed on board
	var row
	var col
	var vertical
	var number
	var solved
	func _init(word, clue, solved = false):
#	func _init(word=null, clue=null):
	#	so basically how this works is
	#	subtitute any space (\s) with no space
	#	return result in lowercase
		self.word = word.to_upper().replace(" ", "")
#		self.word = word.to_lower().replace(" ", "")
#		self.word = re.sub(r'\s', '', word.lower())
		self.clue = clue
		self.length = len(self.word)
		# the below are set when placed on board
		self.row = null
		self.col = null
		self.vertical = null
		self.number = null
		self.solved = solved

 
	func down_across(): # return down or across
		if self.vertical: 
			return 'down'
		else: 
			return 'across'
			
#	func _to_string():
#		return self.word 



class Crossword:
	

	var cols
	var rows
	var empty
	var maxloops
	var available_words
	var current_word_list
	var debug
	
	var grid
#	func _init(cols, rows, empty, maxloops, available_words):
#	func _init(self, cols, rows, empty:String = '-', maxloops:Int = 2000, available_words:Array=[]):
	func _init(cols, rows, empty = '-', maxloops = 2000, available_words = []):
		self.cols = cols
		self.rows = rows
		self.empty = empty
		self.maxloops = maxloops
		self.available_words = available_words
		self.randomize_word_list()
		self.current_word_list = []
		self.debug = 0
		self.clear_grid()
 
	func clear_grid(): # initialize grid and fill with empty character
		self.grid = []
		for i in range(self.rows):
			var ea_row = []
			for j in range(self.cols):
				ea_row.append(self.empty)
			self.grid.append(ea_row)
 
	func randomize_word_list(): # also resets words and sorts by length
		var temp_list = []
		for word in self.available_words:
#			if  word.get_script() == Word:
			if  word is Word:
#			if isinstance(word, Word):
				temp_list.append(Word.new(word.word, word.clue, word.solved))
#				print("word is Word ")
			else:
				temp_list.append(Word.new(word[0], word[1], word[2]))
#		randomize()
		seed(1)
		temp_list.shuffle() # randomize word list
		temp_list.sort_custom(MyCustomSorter,"sort_decending_arrLength") # sort by length
#		temp_list.sort(key=lambda i: len(i.word), reverse=True) # sort by length
		self.available_words = temp_list
 
	func compute_crossword(time_permitted = 1.00, spins=2):
		time_permitted = float(time_permitted)
 
		var count = 0
		var copy = Crossword.new(self.cols, self.rows, self.empty, self.maxloops, self.available_words)
 
		var start_full = float(OS.get_unix_time())
#		var start_full = float(2)
#		var start_full = float(time.time())
		while (float(OS.get_unix_time()) - start_full) < time_permitted or count == 0: # only run for x seconds
#		while (float(3) - start_full) < time_permitted or count == 0: # only run for x seconds
#		while (float(time.time()) - start_full) < time_permitted or count == 0: # only run for x seconds
			self.debug += 1
			copy.current_word_list = []
			copy.clear_grid()
			copy.randomize_word_list()
			var x = 0
			while x < spins: # spins; 2 seems to be plenty
				for word in copy.available_words:
					if not(word in copy.current_word_list):
#					if word not in copy.current_word_list:
						copy.fit_and_add(word)
				x += 1
			#print copy.solution()
			#print len(copy.current_word_list), len(self.current_word_list), self.debug
			# buffer the best crossword by comparing placed words
			if len(copy.current_word_list) > len(self.current_word_list):
				self.current_word_list = copy.current_word_list
				self.grid = copy.grid
			count += 1
		return
 
	func suggest_coord(word):
		var count = 0
		var coordlist = []
		var glc = -1
		for given_letter in word.word: # cycle through letters in word
			glc += 1
			var rowc = 0
			for row in self.grid: # cycle through rows
				rowc += 1
				var colc = 0
				for cell in row: # cycle through  letters in rows
					colc += 1
					if given_letter == cell: # check match letter in word to letters in row
						if true: # suggest vertical placement 
#						try: # suggest vertical placement 
							if rowc - glc > 0: # make sure we're not suggesting a starting point off the grid
								if ((rowc - glc) + word.length) <= self.rows: # make sure word doesn't go off of grid
									coordlist.append([colc, rowc - glc, 1, colc + (rowc - glc), 0])
						else: pass
#						except: pass
						if true: # suggest horizontal placement 
#						try: # suggest horizontal placement 
							if colc - glc > 0: # make sure we're not suggesting a starting point off the grid
								if ((colc - glc) + word.length) <= self.cols: # make sure word doesn't go off of grid
									coordlist.append([colc - glc, rowc, 0, rowc + (colc - glc), 0])
						else: pass
#						except: pass
		# example: coordlist[0] = [col, row, vertical, col + row, score]
		#print word.word
		#print coordlist
		var new_coordlist = self.sort_coordlist(coordlist, word)
		#print new_coordlist
		return new_coordlist
 
	func sort_coordlist(coordlist, word): # give each coordinate a score, then sort
		var new_coordlist = []
		for coord in coordlist:
			var col = coord[0]
			var row = coord[1]
			var vertical = coord[2]
			coord[4] = self.check_fit_score(col, row, vertical, word) # checking scores
			if coord[4]: # 0 scores are filtered
				new_coordlist.append(coord)
#		new_coordlist.shuffle() # randomize coord list; why not?

		new_coordlist.sort_custom(MyCustomSorter,"sort_decending_bestScore") # put the best scores first
#		new_coordlist.sort(key=lambda i: i[4], reverse=True) # put the best scores first
		return new_coordlist
 
	func fit_and_add(word): # doesn't really check fit except for the first word; otherwise just adds if score is good
		var fit = false
		var count = 0
		var coordlist = self.suggest_coord(word)
 
		while not fit and count < self.maxloops:
			var vertical
			var col
			var row
			if len(self.current_word_list) == 0: # this is the first word: the seed
				# top left seed of longest word yields best results (maybe override)
#				randomize()
				vertical = 0
#				vertical = randi() % (2 - 0) + 0
#				vertical = rand_range(0, 2)
				col = 1
				row = 1
				"""
				# optional center seed method, slower and less keyword placement
				if vertical:
					col = int(round((self.cols + 1)/2, 0))
					row = int(round((self.rows + 1)/2, 0)) - int(round((word.length + 1)/2, 0))
				else:
					col = int(round((self.cols + 1)/2, 0)) - int(round((word.length + 1)/2, 0))
					row = int(round((self.rows + 1)/2, 0))
				# completely random seed method
				col = random.randrange(1, self.cols + 1)
				row = random.randrange(1, self.rows + 1)
				"""
 
				if self.check_fit_score(col, row, vertical, word): 
					fit = true
					self.set_word(col, row, vertical, word, true)
#					self.set_word(col, row, vertical, word, force=true)
			else: # a subsquent words have scores calculated
				if coordlist.size() > 0: 
#				if true: 
#				try: 
					col = coordlist[count][0]
					row = coordlist[count][1]
					vertical = coordlist[count][2]
				else: return # no more cordinates, stop trying to fit
#				except IndexError: return # no more cordinates, stop trying to fit
 
				if coordlist[count][4]: # already filtered these out, but double check
					fit = true 
					self.set_word(col, row, vertical, word, true)
#					self.set_word(col, row, vertical, word, force=True)
 
			count += 1
		return
 
	func check_fit_score(col, row, vertical, word):
		"""
		And return score (0 signifies no fit). 1 means a fit, 2+ means a cross.
 
		The more crosses the better.
		"""
		if col < 1 or row < 1:
			return 0
 
		var count = 1
		var score = 1  # give score a standard value of 1, will override with 0 if collisions detected
		
		var active_cell
		for letter in word.word:            
			if true:
#			try:
				active_cell = self.get_cell(col, row)
			else:
#			except IndexError:
				return 0
 
			if active_cell == self.empty or active_cell == letter:
				pass
			else:
				return 0
 
			if active_cell == letter:
				score += 1
 
			if vertical:
				# check surroundings
				if active_cell != letter: # don't check surroundings if cross point
					if not self.check_if_cell_clear(col+1, row): # check right cell
						return 0
 
					if not self.check_if_cell_clear(col-1, row): # check left cell
						return 0
 
				if count == 1: # check top cell only on first letter
					if not self.check_if_cell_clear(col, row-1):
						return 0
 
				if count == len(word.word): # check bottom cell only on last letter
					if not self.check_if_cell_clear(col, row+1): 
						return 0
			else: # else horizontal
				# check surroundings
				if active_cell != letter: # don't check surroundings if cross point
					if not self.check_if_cell_clear(col, row-1): # check top cell
						return 0
 
					if not self.check_if_cell_clear(col, row+1): # check bottom cell
						return 0
 
				if count == 1: # check left cell only on first letter
					if not self.check_if_cell_clear(col-1, row):
						return 0
 
				if count == len(word.word): # check right cell only on last letter
					if not self.check_if_cell_clear(col+1, row):
						return 0
 
 
			if vertical: # progress to next letter and position
				row += 1
			else: # else horizontal
				col += 1
 
			count += 1
 
		return score
 
	func set_word(col, row, vertical, word, force=false): # also adds word to word list
		if force:
			word.col = col
			word.row = row
			word.vertical = vertical
			self.current_word_list.append(word)
 
			for letter in word.word:
				self.set_cell(col, row, letter)
				if vertical:
					row += 1
				else:
					col += 1
		return
 
	func set_cell(col, row, value):
		self.grid[row-1][col-1] = value
 
	func get_cell(col, row):
		return self.grid[row-1][col-1]
 
	func check_if_cell_clear(col, row):
		if true:
#		try:
			var cell = self.get_cell(col, row)
			if cell == self.empty: 
				return true
		else:
#		except IndexError:
			pass
		return false
 
	func solution(): # return solution grid
		var outStr = ""
		for r in range(self.rows):
			for c in self.grid[r]:
				outStr += '%s ' % c
			outStr += '\n'
		return outStr
 
	func word_find(): # return solution grid
		var outStr = ""
		for r in range(self.rows):
			for c in self.grid[r]:
				if c == self.empty:
#					outStr += '%s ' % string.ascii_lowercase[random.randint(0,len(string.ascii_lowercase)-1)]
					pass
				else:
					outStr += '%s ' % c
			outStr += '\n'
		return outStr
 
	func order_number_words(): # orders words and applies numbering system to them
		self.current_word_list.sort_custom(MyCustomSorter,"sort_ascending_numberWords") # sort by length
#		self.current_word_list.sort(key=lambda i: (i.col + i.row))
		var count = 1
		var icount = 1
		for word in self.current_word_list:
			word.number = count
			if icount < len(self.current_word_list):
				if word.col == self.current_word_list[icount].col and word.row == self.current_word_list[icount].row:
					pass
				else:
					count += 1
			icount += 1
 
	func display(order=true): # return (and order/number wordlist) the grid minus the words adding the numbers
		var outStr = ""
		if order:
			self.order_number_words()
 
		var copy = self
 
		for word in self.current_word_list:
#			i have to remove this otherwise it will taint the grid when called
			#copy.set_cell(word.col, word.row, word.number)
			pass

		for r in range(copy.rows):
			for c in copy.grid[r]:
				outStr += '%s ' % c
			outStr += '\n'
 
#		am sorry for doing this but...
		outStr = outStr.replace('a' , ' ')
		outStr = outStr.replace('b' , ' ')
		outStr = outStr.replace('c' , ' ')
		outStr = outStr.replace('d' , ' ')
		outStr = outStr.replace('e' , ' ')
		outStr = outStr.replace('f' , ' ')
		outStr = outStr.replace('g' , ' ')
		outStr = outStr.replace('h' , ' ')
		outStr = outStr.replace('i' , ' ')
		outStr = outStr.replace('j' , ' ')
		outStr = outStr.replace('k' , ' ')
		outStr = outStr.replace('l' , ' ')
		outStr = outStr.replace('m' , ' ')
		outStr = outStr.replace('n' , ' ')
		outStr = outStr.replace('o' , ' ')
		outStr = outStr.replace('p' , ' ')
		outStr = outStr.replace('q' , ' ')
		outStr = outStr.replace('r' , ' ')
		outStr = outStr.replace('s' , ' ')
		outStr = outStr.replace('t' , ' ')
		outStr = outStr.replace('u' , ' ')
		outStr = outStr.replace('v' , ' ')
		outStr = outStr.replace('w' , ' ')
		outStr = outStr.replace('x' , ' ')
		outStr = outStr.replace('y' , ' ')
		outStr = outStr.replace('z' , ' ')
#		outStr = re.sub(r'[a-z]', ' ', outStr)
		return outStr
 
	func word_bank(): 
		var outStr = ''
		var temp_list = []
		temp_list.append_array(self.current_word_list)
#		var temp_list = duplicate(self.current_word_list)
#		randomize()
#		temp_list.shuffle() # randomize word list
		for word in temp_list:
			outStr += '%s\n' % word.word
		return outStr
 
	func legend(): # must order first
		var outStr = ''
		for word in self.current_word_list:
			outStr += '%d. %s (%d,%d) %s: %s %s\n' % [word.number, word.word, word.col, word.row, word.down_across(), word.clue, word.solved ]
		return outStr
		
		
		
		
		
		
		
 
### end class, start execution
 
#start_full = float(time.time())
 
var word_list_old = [['saffron', 'The dried, orange yellow plant used to as dye and as a cooking spice.'], \
	['pumpernickel', 'Dark, sour bread made from coarse ground rye.'], \
	['leaven', 'An agent, such as yeast, that cause batter or dough to rise..'], \
	['coda', 'Musical conclusion of a movement or composition.'], \
	['paladin', 'A heroic champion or paragon of chivalry.'], \
	['syncopation', 'Shifting the emphasis of a beat to the normally weak beat.'], \
	['albatross', 'A large bird of the ocean having a hooked beek and long, narrow wings.'], \
	['harp', 'Musical instrument with 46 or more open strings played by plucking.'], \
	['piston', 'A solid cylinder or disk that fits snugly in a larger cylinder and moves under pressure as in an engine.'], \
	['caramel', 'A smooth chery candy made from suger, butter, cream or milk with flavoring.'], \
	['coral', 'A rock-like deposit of organism skeletons that make up reefs.'], \
	['dawn', 'The time of each morning at which daylight begins.'], \
	['pitch', 'A resin derived from the sap of various pine trees.'], \
	['fjord', 'A long, narrow, deep inlet of the sea between steep slopes.'], \
	['lip', 'Either of two fleshy folds surrounding the mouth.'], \
	['lime', 'The egg-shaped citrus fruit having a green coloring and acidic juice.'], \
	['mist', 'A mass of fine water droplets in the air near or in contact with the ground.'], \
	['plague', 'A widespread affliction or calamity.'], \
	['yarn', 'A strand of twisted threads or a long elaborate narrative.'], \
	['snicker', 'A snide, slightly stifled laugh.']]

var word_list = [
	["tamed"],
	["mead"],
	["eat"],
	["ate"],
	["made"],
	["dam"],
	["mated"]]
	
func _ready():
#	remove the return if you are testing the file indepedently
	return
	
	# if you dont want to put a clue this will solve it
	for v in word_list:
		if v.size() < 2:
			v.append("clue")

#	var start_full = float(OS.get_unix_time())
  
	var layout = Crossword.new(13, 13, '-', 5000, word_list)
	layout.compute_crossword(2)
	print (layout.word_bank())
	print (layout.solution())
#       print (layout.word_find())
	layout.display()
#	print (layout.display())
	print (layout.legend())
#	print (len(layout.current_word_list), 'out of', len(word_list))
	print (layout.debug)
	
#	var end_full = float(OS.get_unix_time())
#	print ("time: ", end_full - start_full)
