class_name DialogueState extends State

func _ready():
	set_name("DialogueState")
	add_local_scene(preload("res://interfaces/dialogue_boxes/dialogue_box.tscn").instance())
	local_scene.dialogue = [
		'Welcome to the world of Ethereal!',
		'Lets start the battle tutorial!'
	]
	local_scene.tween.connect("tween_completed", self, "dialogue_animation_complete")
	load_dialogue()
	
func dialogue_complete():
	state_machine.transition_to(null)

func set_dialogue(dialogue):
	# TODO: Should take in list of dialogue, and figure out how to break it to fit screen size.
	local_scene.dialogue = dialogue
	local_scene.dialogue_index = 0

func dialogue_animation_complete(object, key):
	local_scene.finished = true
	
func process_update(delta):
	local_scene.next_indicator.visible = local_scene.finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialogue()

func load_dialogue():
	# TODO: Implement back button for dialogue, and first ui_accept should show current sentence completed
	# before moving to next sentence
	if local_scene.dialogue_index < local_scene.dialogue.size():
		local_scene.finished = false
		local_scene.text_label.bbcode_text = local_scene.dialogue[local_scene.dialogue_index]
		start_dialogue_animation()
		local_scene.dialogue_index += 1
	else:
		dialogue_complete()

func start_dialogue_animation():
	local_scene.text_label.percent_visible = 0
	local_scene.tween.interpolate_property(local_scene.text_label, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	local_scene.tween.start()
