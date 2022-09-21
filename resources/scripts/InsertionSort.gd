extends Node

onready var stop = false

func InsertionSort(Main : Node2D):
	Main.time = 0
	Main.running = true
	Main.recursive = false
	
	var arr = Main.arr
	var instances = Main.instances
	var t = Main.timeMult
	var n = len(arr)
	
	print("Insertion Sort \n" + str(arr))
	for i in range(1, n):
		if stop:
			break
		var a = arr[i]
		Main.temp = a
		var j = i-1
		
		instances.get_children()[i].modulate = Color.limegreen
		
		while j >= 0 and a < arr[j]:
			if stop:
				instances.get_children()[i].modulate = Color.white
				instances.get_children()[j].modulate = Color.white
				break
			t = Main.timeMult
			instances.get_children()[j].modulate = Color.yellow
			yield(get_tree().create_timer(.1/t), "timeout")
			arr[j+1] = arr[j]
			instances.get_children()[j].modulate = Color.white
			j -= 1
			Main.update()
		arr[j+1] = a
		Main.update()
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
