extends Control

@onready var input = $VBoxContainer/LineEdit
@onready var label = $VBoxContainer/Label

@export var something: R.State = R.state(1):
	set(value):
		print("Setting value to ", value, " ", typeof(value))

@export var test_resource: PhysicsMaterial

func _ready():
	var text = R.state("Change Me")

	R.bind(input, "text", text, input.text_changed)

	R.effect(func(_arg):
		label.text=text.value
	)

	print(something.value)
