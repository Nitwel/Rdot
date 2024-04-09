extends Control

@onready var input = $VBoxContainer/LineEdit
@onready var input2 = $VBoxContainer/LineEdit2
@onready var label = $VBoxContainer/Label

func _ready():
	var store = R.store({
        "text": "Hello, World!",
        "text2": "Some Text!"
    })

	R.bind(input, "text", store, "text", input.text_changed)
	R.bind(input2, "text", store, "text2", input2.text_changed)

	R.effect(func(_arg):
		label.text=store.text + "\n" + store.text2
	)
