extends Node

onready var stop = false

func QuickSort(Main : Node2D):
	Main.time = 0
#	Main.running = true
	Main.recursive = false
	
	var arr = Main.arr
	var t = Main.timeMult
	var instances = Main.instances
	
	
	var h = 0
	var l = len(arr) - 1
	
	print("Quick Sort \n" + str(arr))
	# Create an auxiliary stack
	var size = h - l + 1
	var stack = [0] * (size)
  
	# initialize top of stack
	var top = -1
  
	# push initial values of l and h to stack
	top = top + 1
	stack[top] = l
	top = top + 1
	stack[top] = h
  
	# Keep popping from stack while is not empty
	while top >= 0:
  
		# Pop h and l
		h = stack[top]
		top = top - 1
		l = stack[top]
		top = top - 1
  
		# Set pivot element at its correct position in
		# sorted array
		var p = partition( arr, l, h )
  
		# If there are elements on left side of pivot,
		# then push left side to stack
		if p-1 > l:
			top = top + 1
			stack[top] = l
			top = top + 1
			stack[top] = p - 1
  
		# If there are elements on right side of pivot,
		# then push right side to stack
		if p+1 < h:
			top = top + 1
			stack[top] = p + 1
			top = top + 1
			stack[top] = h
#	Main.running = false
#	if !stop:
#		for x in range(len(arr)):
#			if stop:
#				break
#			t = Main.timeMult
#			instances.get_children()[len(arr)-x-1].modulate = Color.green
#			yield(get_tree().create_timer(.1/t), "timeout")
#	stop = false
	
	print(Main.arr)

func partition(arr,l,h):
	var i = ( l - 1 )
	var x = arr[h]
  
	for j in range(l , h):
		if   arr[j] <= x:
  
			# increment index of smaller element
			i = i+1
			var temp = arr[i]
			arr[i] = arr[j]
			arr[j] = temp
	var temp = arr[i+1]
	arr[i+1] = arr[h]
	arr[h] = temp
	return (i+1)
