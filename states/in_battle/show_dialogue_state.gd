class_name ShowDialogueState extends State

const dialogue_scene = preload("res://interfaces/dialogue_boxes/dialogue_box.tscn")

var dialogue_box: DialogueBox

func _init():
	set_name("ShowDialogueState")
	dialogue_box = dialogue_scene.instance()
	dialogue_box.set_dialogue([
		"Welcome to Ethereal's battle tutorial!",
		"This is the beginning of your journey!"
		])
	dialogue_box.connect("dialogue_complete", self, "dialogue_complete")
	add_child(dialogue_box)
	

func dialogue_complete():
	print("Time to remove this resource")

# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(event: InputEvent, transition_to: FuncRef) -> void:
	#	if event.is_action("ui_cancel"):
	#		transition_to.call_func()
	pass
