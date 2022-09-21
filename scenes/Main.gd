extends Node2D

var arr = []

onready var hBox = $CanvasLayer/HBox
onready var instances = $ArrayInstances
onready var sortSelect = $CanvasLayer/UIContainer/SortSelect

var arrSize = 5
var timeMult = 1
var running = false
var time = 0
var temp = 0
var recursive = false

var currentAlgorithm = null

func _ready():
	# init sorting algorithm select
	sortSelect.add_item("Select Sorting Algorithm")
	sortSelect.add_separator()
	
	sortSelect.add_item("Bubble Sort")
	sortSelect.add_item("Selection Sort")
	sortSelect.add_item("Insertion Sort")
	sortSelect.add_item("Shell Sort")
	sortSelect.add_item("Merge Sort")
	sortSelect.add_item("Quick Sort")

	update()

func _process(delta):
	if running:
		time += delta * timeMult
		$CanvasLayer/UIContainer/IndiciesContainer/IndiciesSliderContainer/IndexSlider.editable = false
		$CanvasLayer/UIContainer/RandomizeButton.disabled = true
		$CanvasLayer/UIContainer/SortButton.disabled = true
		$CanvasLayer/UIContainer/StopButton.disabled = false
	else:
		$CanvasLayer/UIContainer/IndiciesContainer/IndiciesSliderContainer/IndexSlider.editable = true
		$CanvasLayer/UIContainer/RandomizeButton.disabled = false
		$CanvasLayer/UIContainer/SortButton.disabled = false
		$CanvasLayer/UIContainer/StopButton.disabled = true
	
	$CanvasLayer/UIContainer/IndiciesContainer/IndiciesSliderContainer/SliderLabel.text = str($CanvasLayer/UIContainer/IndiciesContainer/IndiciesSliderContainer/IndexSlider.value)
	$CanvasLayer/UIContainer/SpeedContainer/SpeedSliderContainer/SpeedLabel.text = str($CanvasLayer/UIContainer/SpeedContainer/SpeedSliderContainer/SpeedSlider.value)
	$CanvasLayer/RightContainer/TimerBox/TimeSecs.text = str( "%.3f" % time) + "s"
	$CanvasLayer/RightContainer/TempBox/TempVal.text = str(temp)
	var containers = hBox.get_children()
	var inst = instances.get_children()
	
	if !recursive:
		for i in range(len(arr)):
			inst[i].global_position = containers[i].get_child(2).global_position

func update():
	while arrSize > len(arr): # array is smaller than needs to be
		var newVal = get_random()
		arr.append(newVal)
		var idx = len(arr) - 1
		var container = load("res://scenes/ArrayInstanceContainer.tscn").instance()
		hBox.add_child(container)
		var instance = load("res://scenes/ArrayInstance.tscn").instance()
		instances.add_child(instance)
		
		container.idx = idx
		container.start()
		instance.value = newVal
		instance.start()
		
	while arrSize < len(arr): # array is larger than needs to be
		arr.pop_back()
		hBox.remove_child(hBox.get_children()[hBox.get_child_count() - 1])
		instances.remove_child(instances.get_children()[instances.get_child_count() - 1])
	
	for i in range(len(arr)):
		instances.get_children()[i].setValue(arr[i])

func _on_IndexSlider_value_changed(value):
	arrSize = int(value)
	update()

func _on_RandomizeButton_pressed():
	for i in range(len(arr)):
		instances.get_children()[i].modulate = Color.white
		arr[i] = get_random()
		update()

func get_random() -> int:
	randomize()
	var upperBound = 100
	var rand = randi() % upperBound
	while true:
		if rand in arr:
			rand = randi() % upperBound
		else:
			return rand
	return rand

func _on_SortSelect_item_selected(index):
	match index:
		2:
			currentAlgorithm = "Bubble Sort"
		3:
			currentAlgorithm = "Selection Sort"
		4:
			currentAlgorithm = "Insertion Sort"
		5:
			currentAlgorithm = "Shell Sort"
		6:
			currentAlgorithm = "Merge Sort"
		7:
			currentAlgorithm = "Quick Sort"
		_:
			currentAlgorithm = null

func _on_SpeedSlider_value_changed(value):
	timeMult = value

func _on_SortButton_pressed():
	for i in range(len(arr)):
		instances.get_children()[i].modulate = Color.white
	match currentAlgorithm:
		"Bubble Sort":
			BubbleSort.stop = false
			BubbleSort.BubbleSort(self)
		"Selection Sort":
			SelectionSort.stop = false
			SelectionSort.SelectionSort(self)
		"Insertion Sort":
			InsertionSort.stop = false
			InsertionSort.InsertionSort(self)
		"Shell Sort":
			ShellSort.stop = false
			ShellSort.ShellSort(self)
		"Merge Sort":
			MergeSort.stop = false
			MergeSort.MergeSort(self)
		"Quick Sort":
			QuickSort.stop = false
			QuickSort.QuickSort(self)
		_:
			pass

func _on_StopButton_pressed():
	running = false
	BubbleSort.stop = true
	SelectionSort.stop = true
	InsertionSort.stop = true
	ShellSort.stop = true
	MergeSort.stop = true
