extends Control

@onready var tab_bar = $VBoxContainer/TabBar
@onready var tabs = [$VBoxContainer/FirstTabLabel, $VBoxContainer/SecondTabLabel, $VBoxContainer/ThirdTabLabel]

func _ready():
	var selected_tab = R.state(0)

	R.bind(tab_bar, "current_tab", selected_tab, tab_bar.tab_changed)

	for i in range(tabs.size()):
		var tab = tabs[i]
		R.effect(func(_arg):
			tab.visible=selected_tab.value == i
		)
