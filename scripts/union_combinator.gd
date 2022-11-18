extends Node2D


func diffrence(arr1, arr2):
	var only_in_arr1 = []
	for v in arr1:
		if not (v in arr2):
			only_in_arr1.append(v)
	return only_in_arr1
	
func intersect(arr1, arr2):
	var intersection = []
	for item in arr1:
		if arr2.has(item):
			intersection.append(item)
	return intersection
	
func array_to_string(arr):
	var s = ""
	for i in arr:
		s += String(i)
	return s
	
func string_to_array(s):
	var arr = []
	for c in s:
		arr.append(c)
	return arr

func in_array(arr1, arr2):
	for v in arr1:
		if arr2.has(v):
			pass
		else:
			return false
	
	return true
	
#most proud of this function does its work well,
func in_array_advanc(arr1, arr2):
	var temp_arr1 = []
	var temp_arr2 = []
	temp_arr1.append_array(arr1)
#	for i in range(arr1.size()):
#		temp_arr1.append(arr1[i])
	var i = 0
	while i < (temp_arr1.size()):
		if arr2 == temp_arr2:
			break
		if temp_arr1[i] == arr2[i]:
			pass
			temp_arr2.append(temp_arr1[i])
			i += 1
		else:
			temp_arr1.remove(i)
#	print("advance check")
#	print(temp_arr1)
#	print(arr2, temp_arr2)
	if arr2 == temp_arr2:
		return true


func simple_union(arr1, arr2):
	var arr = []
	if arr1.size() != arr2.size():
		return arr

	for index in range(arr1.size()):
		var i = arr1[index]
		var j = arr2[index]
		if i == j:
			arr.append(i)
		else:
			arr.append(i)
			arr.append(j)
	return arr
	
func union(arr1, arr2):
	arr1 = string_to_array(arr1)
	arr2 = string_to_array(arr2)
	arr1.sort()
	arr2.sort()
	var arr = []

#	if arr1.size() == arr2.size():
#		var temp_arr1 = arr1
#		var temp_arr2 = arr2
#		arr1 = temp_arr2
#		arr2 = temp_arr1
	
	var a = diffrence(arr2,arr1)
	var b = diffrence(arr1,arr2)
	var c1 = diffrence(arr2,diffrence(arr2,arr1))
	var c2 = diffrence(arr1,diffrence(arr1,arr2))
	var c3 = simple_union(c1,c2)
	a.sort()
	b.sort()
	
	c1.sort()
	c2.sort()
	c3.sort()
	
#
#	print("printing C")
#	print(c1)
#	print(c2)
#	print(c3)
#
#	print("printing input sorted")
#	print(arr1)
#	print(arr2)
#	print()
#
	arr.append_array(a)
	arr.append_array(b)
	

#	if c1.size() > c2.size(): 
#		arr.append_array(c1)
#	if c1.size() == c2.size(): 
#		arr.append_array(c3)
#	else:
#		arr.append_array(c2)

	var temp_arrC1 = []
	temp_arrC1.append_array(arr)
	temp_arrC1.append_array(c1)
	temp_arrC1.sort()
	
	var temp_arrC2 = []
	temp_arrC2.append_array(arr)
	temp_arrC2.append_array(c2)
	temp_arrC2.sort()
	
	var temp_arrC3 = []
	temp_arrC3.append_array(arr)
	temp_arrC3.append_array(c3)
	temp_arrC3.sort()
	
	if in_array_advanc(temp_arrC1, arr1) and in_array_advanc(temp_arrC1, arr2):
		arr.append_array(c1)
		arr.sort()
#		print("c1")
	elif in_array_advanc(temp_arrC2, arr1) and in_array_advanc(temp_arrC2, arr2):
		arr.append_array(c2)
		arr.sort()
#		print("c2")
	elif in_array_advanc(temp_arrC3, arr1) and in_array_advanc(temp_arrC3, arr2):
		arr.append_array(c3)
		arr.sort()
#		print("c3")

	
	
	
	return arr
	
func example_for_difference():
	var b = array_to_string("attack")
	var a = "attack"#[1,1,5,6]
	var f = []
	
#	print(diffrence(b,a))
#	print(diffrence(a,b))
#	print(diffrence(b,diffrence(b,a)))
#
#	print("------------")
	
#	f.append_array(diffrence(b,a))
#	f.append_array(diffrence(a,b))
#	f.append_array(diffrence(b,diffrence(b,a)))
#	print(f)
	
	print(union(a,b))

var combinator_array = []

#onready var input_json = get_parent().input_json

# Called when the node enters the scene tree for the first time.
func _ready():
	var input_json = Levels.levels_json[GlobalState.configFile.get_value("Level_Index","index")]
#	example_for_difference()
#	combinator_array.append_array(string_to_array(get_parent().input_json[0].answer))
	var i = 1
#	the new json array is not a dictionary 
	combinator_array = input_json[0][0]
#	combinator_array = get_parent().input_json[0].answer
	while i < input_json.size():
#		union(i,combinator_array[])
		var a = input_json
		combinator_array = union(combinator_array, a[i][0])
#		combinator_array = union(combinator_array, a[i].answer)
#		print(combinator_array)
		i += 1
	print("___final result combiantor_____")
	print(combinator_array)
	pass # Replace with function body.
