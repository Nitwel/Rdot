extends Control

@onready var sub_button = $VBoxContainer/HBoxContainer/Sub
@onready var add_button = $VBoxContainer/HBoxContainer/Add
@onready var label = $VBoxContainer/HBoxContainer/Label
@onready var slider = $VBoxContainer/HSlider

func _ready():
	var counter = R.state(0)

	sub_button.button_down.connect(func():
		counter.value -= 1
	)

	add_button.button_down.connect(func():
		counter.value += 1
	)

	R.bind(slider, "value", counter, slider.value_changed)

	R.effect(func(_arg):
		label.text=str(counter.value)
	)
