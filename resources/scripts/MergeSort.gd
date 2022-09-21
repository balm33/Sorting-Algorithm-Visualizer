extends Node

onready var stop = false

func MergeSort(Main : Node2D):
	Main.time = 0
	Main.running = true
	Main.recursive = false
	
	var arr = Main.arr
	var t = Main.timeMult
	var instances = Main.instances
	
	var low = 0
	var high = len(arr) - 1
	
	var temp = arr.duplicate(true)
	
	var m = 1
	print("Merge Sort \n" + str(arr))
	while m <= (high - low):
		if stop:
			break
		t = Main.timeMult
		yield(get_tree().create_timer(.1/t), "timeout")
		for i in range(len(arr)):
			instances.get_children()[i].modulate = Color.white
		for i in range(low, high, 2*m):
			instances.get_children()[i].modulate = Color.limegreen
			var frm = i
			var mid = i + m - 1
			var to = min(i + 2*m - 1, high)
			for j in range(frm+1, to+1):
				instances.get_children()[j].modulate = Color.yellow
			merge(arr, temp, frm, mid, to, Main)
		m = 2 * m
	for i in range(len(arr)):
			instances.get_children()[i].modulate = Color.white
	
	Main.running = false
	if !stop:
		for x in range(len(arr)):
			if stop:
				break
			t = Main.timeMult
			instances.get_children()[len(arr)-x-1].modulate = Color.green
			yield(get_tree().create_timer(.1/t), "timeout")
	stop = false
	
	print(Main.arr)

func merge(arr : Array, temp : Array, frm : int, mid : int, to : int, Main : Node2D): # merge sublists arr[frm:mid] and arr[mid+1:to]
	var k = frm
	var i = frm
	var j = mid + 1
	
	
	
	# loop until no elements left in left and right runs
	while i <= mid and j <= to:
		if arr[i] < arr[j]:
			temp[k] = arr[i]
			i += 1
		else:
			temp[k] = arr[j]
			j += 1
		
		k += 1
	
	# copy remaining elements
	while i < len(arr) and i <= mid:
		temp[k] = arr[i]
		k += 1
		i += 1

	 # copy back to the original list to reflect sorted order
	for x in range(frm, to + 1):
		arr[x] = temp[x]
		Main.update()
