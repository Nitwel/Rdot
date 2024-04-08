extends Control

@onready var input = $VBoxContainer/LineEdit
@onready var label = $VBoxContainer/Label

func _ready():
	var text = R.state("Change Me")

	R.bind(input, "text", text, input.text_changed)

	R.effect(func(_arg):
		label.text=text.value
	)
