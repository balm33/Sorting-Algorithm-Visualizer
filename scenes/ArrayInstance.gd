extends Node2D

var value : int = 30

func start():
	$Label.text = str(value)
	updateSize(1.0)

func updateSize(scale : float):
	self.scale *= scale
	$ColorRect.rect_size.y = 25 + value * 4
	$Label.rect_position.y = $ColorRect.rect_size.y / -2

func setValue(val : int):
	self.value = val
	$Label.text = str(value)
	updateSize(self.scale.x)
