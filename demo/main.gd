extends Node3D

@onready var sub = $CanvasLayer/Control/CenterContainer/VBoxContainer/VBoxContainer/Sub
@onready var add = $CanvasLayer/Control/CenterContainer/VBoxContainer/VBoxContainer/Add
@onready var label = $CanvasLayer/Control/CenterContainer/VBoxContainer/VBoxContainer/Label
@onready var input = $CanvasLayer/Control/CenterContainer/VBoxContainer/LineEdit
@onready var label2 = $CanvasLayer/Control/CenterContainer/VBoxContainer/Label

func _ready():
	var some = R.state(2)
	var input_value = R.state("")

	var double = R.computed(func(_a):
		return some.value * 2
	)

	sub.button_down.connect(func():
		some.value -= 1
	)

	add.button_down.connect(func():
		some.value += 1
		input_value.value=str(some.value)
	)

	input.text_changed.connect(func(value):
		input_value.value=value
	)

	R.effect(func(_arg):
		if input.text != input_value.value:
			input.text=input_value.value

		label2.text=input_value.value
	)

	R.effect(func(_arg):
		print("effect", double.value)
		label.text="value: " + str(double.value)
	)
