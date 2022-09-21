extends Node

onready var stop = false

func ShellSort(Main : Node2D):
	Main.time = 0
	Main.running = true
	Main.recursive = false
	
	var arr = Main.arr
	var instances = Main.instances
	var t = Main.timeMult
	var n = len(arr)
	
	var k = int(log(n)/log(2))
	var interval = pow(2, k) -1
	
	print("Shell Sort \n" + str(arr))
	while interval > 0:
		if stop:
			break
		for i in range(interval, n):
			if stop:
				break
			var temp = arr[i]
			Main.temp = temp
			var j = i
			while j >= interval and arr[j - interval] > temp:
				if stop:
					instances.get_children()[i].modulate = Color.white
					instances.get_children()[j].modulate = Color.white
					break
				instances.get_children()[i].modulate = Color.limegreen
				instances.get_children()[j].modulate = Color.yellow
				t = Main.timeMult
				yield(get_tree().create_timer(.1/t), "timeout")
				arr[j] = arr[j - interval]
				instances.get_children()[i].modulate = Color.white
				instances.get_children()[j].modulate = Color.white
				j -= interval
				
			arr[j] = temp
			Main.update()
		k -= 1
		interval = pow(2, k) -1
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
