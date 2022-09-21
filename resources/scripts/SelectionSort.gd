extends Node

onready var stop = false

func SelectionSort(Main : Node2D):
	Main.time = 0
	Main.running = true
	Main.recursive = false
	
	var arr = Main.arr
	var instances = Main.instances
	var t = Main.timeMult
	var n = len(arr)
	
	print("Selection Sort \n" + str(arr))
	for i in range(n):
		if stop:
			break
		for j in range(i+1):
			if stop:
				instances.get_children()[i].modulate = Color.white
				instances.get_children()[j].modulate = Color.white
				break
			instances.get_children()[i].modulate = Color.limegreen
			instances.get_children()[j].modulate = Color.yellow
			
			t = Main.timeMult
			yield(get_tree().create_timer(.1/t), "timeout")
			if arr[i] < arr[j]:
				var temp = arr[i]
				Main.temp = temp
				arr[i] = arr[j]
				arr[j] = temp
				Main.update()
			instances.get_children()[i].modulate = Color.white
			instances.get_children()[j].modulate = Color.white
	Main.running = false
	if !stop:
		for x in range(len(arr)):
			if stop:
				break
			t = Main.timeMult
			instances.get_children()[len(arr)-x-1].modulate = Color.green
			yield(get_tree().create_timer(.1/t), "timeout")
	stop = false
	print(arr)
