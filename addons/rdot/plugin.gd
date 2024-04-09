@tool
extends EditorPlugin

var inspector_plugin = ReactiveInspector.new()

func _enter_tree():
	print("Plugin Started")
	add_inspector_plugin(inspector_plugin)

func _exit_tree():
	remove_inspector_plugin(inspector_plugin)

class ReactiveInspector extends EditorInspectorPlugin:

	func _can_handle(object):
		print("Can handle: ", object)
		return true

	func __parse_begin(object):
		print("Parsing begin: ", object)

	func _parse_category(object, category):
		print("Parsing category: ", object, category)

	func _parse_property(object, type, name, hint_type, hint_string, usage_flags, wide) -> bool:

		if hint_string == "State":
			print("State found")
			add_property_editor(name, ReactiveProperty.new(), false)
			return true

		return false

class ReactiveProperty extends EditorProperty:

	var input := LineEdit.new()
	var current_value = 0
	var updating = false

	func _init():
		add_child(input)
		add_focusable(input)
		refresh_input()
		
		input.text_changed.connect(func(value: String):
			if updating:
				return
			
			current_value=int(value)

			emit_changed(get_edited_property() + ".value", current_value)
		)

	func _update_property():
		var new_value = get_edited_object()[get_edited_property() + ".value"]
		if (new_value == current_value):
			return

		# Update the control with the new value.
		updating = true
		current_value = new_value
		refresh_input()
		updating = false

	func refresh_input():
		input.text = str(current_value)
