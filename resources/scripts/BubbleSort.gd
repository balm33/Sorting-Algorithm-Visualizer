extends Node

onready var stop = false

func BubbleSort(Main : Node2D):
	Main.time = 0
	Main.running = true
	Main.recursive = false
	
	var arr = Main.arr
	var instances = Main.instances
	var t = Main.timeMult
	var n = len(arr)
	
	print("Bubble Sort\n" + str(arr))
	# cycle through every element
	for i in range(n):
		if stop:
			stop = false
			break
		#cycle array from 0 to n-i-1
		for j in range(0, n-i-1):
			if stop:
				instances.get_children()[j].modulate = Color.white
				instances.get_children()[j+1].modulate = Color.white
				break
			instances.get_children()[j].modulate = Color.limegreen
			instances.get_children()[j+1].modulate = Color.yellow
			t = Main.timeMult
			yield(get_tree().create_timer(.1/t), "timeout")
			if arr[j] > arr[j+1]:
				var temp = arr[j]
				Main.temp = temp
				arr[j] = arr[j+1]
				arr[j+1] = temp
				Main.update()
			instances.get_children()[j].modulate = Color.white
			instances.get_children()[j+1].modulate = Color.green
	instances.get_children()[0].modulate = Color.green
		
	Main.running = false
	print(arr)
