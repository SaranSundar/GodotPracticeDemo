class_name DialogueState extends State

func _ready():
	.set_name("DialogueState")
	self.add_state_scene(preload("res://interfaces/dialogue_boxes/dialogue_box.tscn").instance())
	self.state_scene.dialogue = [
		'Welcome to the world of Ethereal!',
		'Let\'s start the battle tutorial!'
	]
	self.state_scene.connect("dialogue_complete", self, "dialogue_complete")
	self.state_scene.tween.connect("tween_completed", self, "dialogue_animation_complete")
	load_dialogue()
	
func dialogue_complete():
	self.state_machine.transition_to(null)

func set_dialogue(dialogue):
	# TODO: Should take in list of dialogue, and figure out how to break it to fit screen size.
	self.state_scene.dialogue = dialogue
	self.state_scene.dialogue_index = 0

func dialogue_animation_complete(object, key):
	self.state_scene.finished = true
	
func update_state(delta):
	self.state_scene.next_indicator.visible = self.state_scene.finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialogue()

func load_dialogue():
	# TODO: Implement back button for dialogue, and first ui_accept should show current sentence completed
	# before moving to next sentence
	if self.state_scene.dialogue_index < self.state_scene.dialogue.size():
		self.state_scene.finished = false
		self.state_scene.text_label.bbcode_text = self.state_scene.dialogue[self.state_scene.dialogue_index]
		start_dialogue_animation()
		self.state_scene.dialogue_index += 1
	else:
		dialogue_complete()

func start_dialogue_animation():
	self.state_scene.text_label.percent_visible = 0
	self.state_scene.tween.interpolate_property(self.state_scene.text_label, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	self.state_scene.tween.start()
