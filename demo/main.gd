extends Node3D

@onready var add_button = $CanvasLayer/Control/CenterContainer/VBoxContainer/VBoxContainer/Add
@onready var label = $CanvasLayer/Control/CenterContainer/VBoxContainer/VBoxContainer/Label

func _ready():
	var counter = R.state(0)

	var displayText = R.computed(func(_arg):
		return "Value: " + str(counter.value)
	)
	add_button.button_down.connect(func():
		counter.value += 1
	)

	R.effect(func(_arg):
		label.text=displayText.value
	)
