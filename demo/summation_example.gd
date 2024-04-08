extends Control

@onready var input = $VBoxContainer/HBoxContainer/LineEdit1
@onready var input2 = $VBoxContainer/HBoxContainer/LineEdit2
@onready var label = $VBoxContainer/HBoxContainer/Label

func _ready():
	var first_value = R.state("1")
	var second_value = R.state("2")

	R.bind(input, "text", first_value, input.text_changed)
	R.bind(input2, "text", second_value, input2.text_changed)

	var sum = R.computed(func(_arg):
		return " = %s" % (int(first_value.value) + int(second_value.value))
	)

	R.bind(label, "text", sum)
