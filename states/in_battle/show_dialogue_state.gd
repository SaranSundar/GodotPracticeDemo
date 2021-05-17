class_name ShowDialogueState extends State

const dialogue_scene = preload("res://interfaces/dialogue_boxes/dialogue_box.tscn")

var dialogue_box

var is_dialogue_complete = false

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
	is_dialogue_complete = true

# Virtual function. Corresponds to the `_process()` callback.
func update(delta: float, transition_to: FuncRef) -> void:
	if is_dialogue_complete:
		is_dialogue_complete = false
		# Create new instance of exit state to reset it
		self.queue_free()
		transition_to.call_func()
