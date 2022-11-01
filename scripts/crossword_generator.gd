

extends Node2D

#this is a fuction i created myself becase the js initTable was abit confusing
#i have fixed it now and would no longer need this function
func create_2d_array(width, height, value):
	var a = []
	for x in range(width):
		var col = []
		col.resize(height)
		a.append(col)
		for y in range(width):
			a[x][y] = value
	return a


# MATH FUNCTIONS

# get distance form point a to b
func distance(x1, y1, x2, y2):
	return abs(x1 - x2) + abs(y1 - y2)


func weightedAverage(weights, values):
	var temp = 0
	for k in range(weights.size()):
		temp += weights[k] * values[k]
	if (temp < 0) || (temp > 1):
		print("Error: ", values)
	return temp;


# Component scores
# 1. Number of connections
func computeScore1(connections, word):
	return (connections / (word.length() / 2.0))

# 2. Distance from center
func computeScore2(rows, cols, i, j):
	return 1 - (distance(rows / 2.0, cols / 2.0, i, j) / ((rows / 2.0) + (cols / 2.0)))

# 3. Vertical versus horizontal orientation
func computeScore3(a, b, verticalCount, totalCount):
	if (verticalCount > totalCount / 2.0):
		return a
	elif (verticalCount < totalCount / 2.0):
		return b
	else:
		return 0.5
		
# 4. Word length
func computeScore4(val, word):
	return word.length() / float(val)




#Word functions
func addWord(best, words, table):
#	uncomment this to test if the best variable table returns the proper once
#	print(best)#," -- ", words)#," -- ", table
	var bestScore = best[0]
	var word = best[1]
	var index = best[2]
	var bestI = best[3]
	var bestJ = best[4]
	var bestO = best[5]

	words[index].startx = bestJ + 1;
	words[index].starty = bestI + 1;

	if bestO == 0:
		for k in range(word.length()):
			table[bestI][bestJ + k] = word[k]
		words[index].orientation = "across"
	else:
		for k in range(word.length()):
			table[bestI + k][bestJ] = word[k]
		words[index].orientation = "down"
#	print(word, ", ", bestScore)

func assignPositions(words):
	var positions = {}
	for index in words.size():
		var word = words[index]
#		var word = index
		if word.orientation != "none":
			var tempStr = str(word.starty) + "," + str(word.startx)
#			print(tempStr)
			if tempStr in positions:
				word.position = positions[tempStr]
#				print(tempStr)
			else:
				# Object.keys is supported in ES5-compatible environments
				# It returns an array (Array ["a", "b", "c"]) of an object or dict
				# So this will just give the number of keys in the array ie: 3 + 1
				positions[tempStr] = positions.size() + 1
#				print(positions)
				word.position = positions[tempStr]

func computeDimension(words, factor):
	var temp = 0;
	for i in range(words.size()):
		if temp < words[i].answer.length():
			temp = words[i].answer.length()
	return temp * factor;




# Table functions
func initTable(rows, cols):
	var table = [];
	for i in range(rows):
		for j in range(cols):
			if (j == 0):
				table.insert(i, ["-"])
			else:
				table[i].insert(j, "-")
	return table

func isConflict(table, isVertical, character, i, j):
	if character != table[i][j] and table[i][j] != "-":
		return true
	elif (table[i][j] == "-" && !isVertical && (i + 1) in table && table[i + 1][j] != "-"):
		return true
	elif (table[i][j] == "-" && !isVertical && (i - 1) in table && table[i - 1][j] != "-"):
		return true
	elif(table[i][j] == "-" && isVertical && (j + 1) in table[i] && table[i][j + 1] != "-"):
		return true
	elif(table[i][j] == "-" && isVertical && (j - 1) in table[i] && table[i][j - 1] != "-"):
		return true
	else:
		return false

func attemptToInsert(rows, cols, table, weights, verticalCount, totalCount, word, index):
#	print("attenmpToInsert")
	var bestI = 0;
	var bestJ = 0;
	var bestO = 0;
	var bestScore = -1;
	

	# Horizontal
	for i in range(rows):
		for j in range(cols - word.length() + 1):
			var isValid = true;
			var atleastOne = false;
			var connections = 0;
			var prevFlag = false;

			for k in range(word.length()):
				if (isConflict(table, false, word[k], i, j + k)):
					isValid = false;
					break
				elif(table[i][j + k] == "-"):
					prevFlag = false;
					atleastOne = true
				else:
					if (prevFlag):
						isValid = false;
						break;
					else:
						prevFlag = true;
						connections += 1;

			if (((j - 1) in table[i]) && (table[i][j - 1]) != "-"):
				isValid = false;
			elif((j + word.length()) in table[i] && table[i][j + word.length()] != "-"):
				isValid = false

			if (isValid && atleastOne && (word.length() > 1)):
				var tempScore1 = computeScore1(connections, word);
				var tempScore2 = computeScore2(rows, cols, i, j + (word.length() / 2.0));
				var tempScore3 = computeScore3(1, 0, verticalCount, totalCount);
				var tempScore4 = computeScore4(rows, word);
				var tempScore = weightedAverage(weights, [tempScore1, tempScore2, tempScore3, tempScore4]);
				
#				if (i == 0 && j == 0):
#				print("hori = ",word,"  ", tempScore, "-",i,":",j)


				if (tempScore > bestScore):
					bestScore = tempScore;
					bestI = i;
					bestJ = j;
					bestO = 0;
#	if tempScore:
#		print("tempsc  ",tempScore)
#		print("endof of nested loop")		
					
	# Vertical
	for i in range(rows - word.length() + 1):
		for j in range(cols):
			var isValid = true;
			var atleastOne = false;
			var connections = 0;
			var prevFlag = false;

			for k in range(word.length()):
				if(isConflict(table, true, word[k], i + k, j)):
					isValid = false;
					break;
				elif(table[i + k][j] == "-"):
					prevFlag = false;
					atleastOne = true;
				else:
					if(prevFlag):
						isValid = false;
						break;
					else:
						prevFlag = true;
						connections += 1;

			if (((i - 1) in table) && (table[i - 1][j]) != "-"):
				isValid = false;
			elif((i + word.length()) in table && table[i + word.length()][j] != "-"):
				isValid = false;

			if(isValid && atleastOne && (word.length() > 1)):
				var tempScore1 = computeScore1(connections, word);
#				var tempScore2 = computeScore2(rows, cols, i + (word.lenth() / 2), j, word);
				var tempScore2 = computeScore2(rows, cols, i + (word.length() / 2.0), j);
				var tempScore3 = computeScore3(0, 1, verticalCount, totalCount);
				var tempScore4 = computeScore4(rows, word);
				var tempScore = weightedAverage(weights, [tempScore1, tempScore2, tempScore3, tempScore4]);
#				print("tempScore = ", tempScore)
				
#				if (i == 0 && j == 0):
#					print("vert = ", tempScore, "-",i,":",j)
				
				if(tempScore > bestScore):
					bestScore = tempScore;
					bestI = i;
					bestJ = j;
					bestO = 1;
					
	if(bestScore > -1):
		return [bestScore, word, index, bestI, bestJ, bestO];
	else:
		return [-1];

func generateTable(table, rows, cols, words, weights):
	var verticalCount = 0;
	var totalCount = 0;

	for outerIndex in words.size():
		var best = [-1];
		for innerIndex in words.size():
			if("answer" in words[innerIndex] && !("startx" in words[innerIndex])):
#				var temp = attemptToInsert(rows, cols, table, weights, verticalCount, totalCount, innerIndex.answer, words.find(innerIndex));
				var temp = attemptToInsert(rows, cols, table, weights, verticalCount, totalCount, words[innerIndex].answer, innerIndex);
				
				#print(rows,"  ", verticalCount, "  ", totalCount, "  ",words[innerIndex].answer, "  ", innerIndex)
				######print("temp = ", temp, " ---- ", innerIndex)

				if(temp[0] > best[0]):
					best = temp;

		if(best[0] == -1):
			break;
		else:
			addWord(best, words, table);
		if (best[5] == 1):
			verticalCount += 1;
		totalCount += 1;

	for index in words.size():
		if(!("startx" in words[index])):
			words[index].orientation = "none";

	return {"table": table, "result": words};

func removeIsolatedWords(data):
	var oldTable = data.table;
	var words = data.result;
	var rows = oldTable.size();
	var cols = oldTable[0].size();
	var newTable = initTable(rows, cols);

	# Draw intersections as "X"'s
	for wordIndex in words.size():
		var word = words[wordIndex];
		if(word.orientation == "across"):
			var i = word.starty - 1;
			var j = word.startx - 1;
			for k in range(word.answer.length()):
				if(newTable[i][j + k] == "-"):
					newTable[i][j + k] = "O";
				elif(newTable[i][j + k] == "O"):
					newTable[i][j + k] = "X";
		elif(word.orientation == "down"):
			var i = word.starty - 1;
			var j = word.startx - 1;
			for k in range(word.answer.length()):
				if(newTable[i + k][j] == "-"):
					newTable[i + k][j] = "O";
				elif(newTable[i + k][j] == "O"):
					newTable[i + k][j] = "X";

	# Set orientations to "none" if they have no intersections
	for wordIndex in words.size():
		var word = words[wordIndex];
		var isIsolated = true;
		if(word.orientation == "across"):
			var i = word.starty - 1;
			var j = word.startx - 1;
			for k in range(word.answer.length()):
				if(newTable[i][j + k] == "X"):
					isIsolated = false;
					break;
		elif (word.orientation == "down"):
			var i = word.starty - 1;
			var j = word.startx - 1;
			for k in range(word.answer.length()):
				if(newTable[i + k][j] == "X"):
					isIsolated = false;
					break;
		if(word.orientation != "none" && isIsolated):
			words[wordIndex].erase("startx")
			words[wordIndex].erase("starty")
			words[wordIndex].erase("position")
			words[wordIndex].orientation = "none";

	# Draw new table
	newTable = initTable(rows, cols);
	for wordIndex in words.size():
		var word = words[wordIndex];
		if(word.orientation == "across"):
			var i = word.starty - 1;
			var j = word.startx - 1;
			for k in range(word.answer.length()):
				newTable[i][j + k] = word.answer[k];
		elif(word.orientation == "down"):
			var i = word.starty - 1;
			var j = word.startx - 1;
			for k in range(word.answer.length()):
				newTable[i + k][j] = word.answer[k];

	return {"table": newTable, "result": words};

func trimTable(data):
	var table = data.table;
	var rows = table.size();
	var cols = table[0].size();

	var leftMost = cols;
	var topMost = rows;
	var rightMost = -1;
	var bottomMost = -1;

	for i in range(rows):
		for j in range(cols):
			if(table[i][j] != "-"):
				var x = j;
				var y = i;

				if(x < leftMost):
					leftMost = x;
				if(x > rightMost):
					rightMost = x;
				if(y < topMost):
					topMost = y;
				if(y > bottomMost):
					bottomMost = y;

	var trimmedTable = initTable(bottomMost - topMost + 1, rightMost - leftMost + 1);
	for i in range(topMost, bottomMost + 1):
		for j in range(leftMost, rightMost + 1):
			trimmedTable[i - topMost][j - leftMost] = table[i][j];

	var words = data.result;
	for entry in words.size():
		if("startx" in words[entry]):
			words[entry].startx -= leftMost;
			words[entry].starty -= topMost;

	return {"table": trimmedTable, "result": words, "rows": max(bottomMost - topMost + 1, 0), "cols": max(rightMost - leftMost + 1, 0)};

func tableToString(table, delim):
	var rows = table.size();
	if(rows >= 1):
		var cols = table[0].size();
		var output = "";
		for i in range(rows):
			for j in range(cols):
				output += table[i][j];
			output += delim;
		return output;
	else:
		return "";

func generateSimpleTable(words):
	var rows = computeDimension(words, 3);
	var cols = rows;
	var blankTable = initTable(rows, cols);
	var table = generateTable(blankTable, rows, cols, words, [0.7, 0.15, 0.1, 0.05]);
#	print("table = ", table)
	var newTable = removeIsolatedWords(table);
#	print("newtable = ", newTable)
	var finalTable = trimTable(newTable);
#	print("finalTable = ", finalTable)
	assignPositions(finalTable.result);
#	print("finalTable = ", finalTable)
	return finalTable;

func generateLayout(words_json):
	var layout = generateSimpleTable(words_json);
#	layout.table_string = tableToString(layout.table, "<br>");
	return layout;





# Called when the node enters the scene tree for the first time.
func _ready():
	return
#	var input_json = [{"answer":"hey"},{"answer":"hello"}]
	var input_json = [{"answer":"standard"},{"answer":"computer"},{"answer":"equipment"},{"answer":"port"},{"answer":"interface"}]
	var layout = generateLayout(input_json);
	print("layout= ", layout)
	for i in layout.table:
		print(i)
