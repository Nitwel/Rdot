extends Node3D

@onready var sub = $CanvasLayer/Control/CenterContainer/VBoxContainer/Sub
@onready var add = $CanvasLayer/Control/CenterContainer/VBoxContainer/Add
@onready var label = $CanvasLayer/Control/CenterContainer/VBoxContainer/Label

func _ready():
	var some = R.state(2)

	var double = R.computed(func(_a):
		return some.value * 2
	)

	sub.button_down.connect(func():
		some.value -= 1
	)

	add.button_down.connect(func():
		some.value += 1
	)

	R.effect(func(_arg):
		print("effect", double.value)
		label.text="value: " + str(double.value)
	)
