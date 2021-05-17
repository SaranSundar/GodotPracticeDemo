class_name DialogueBox extends CanvasLayer

var dialogue = [
	'Welcome to the world of Ethereal!',
	'Here is some content to read for testing',
	'Here is a lot more content to test with',
	'And lets test once more and once more!'
]

var dialogue_index = 0
var finished = false

onready var text_label = $dialogue_box_container/dialogue_box/RichTextLabel
onready var tween = $dialogue_box_container/dialogue_box/Tween
onready var next_indicator = $dialogue_box_container/dialogue_box/next_indicator

signal dialogue_complete

func _ready():
	tween.connect("tween_completed", self, "dialogue_animation_complete")
	load_dialogue()

func set_dialogue(dialogue):
	# TODO: Should take in list of dialogue, and figure out how to break it to fit screen size.
	self.dialogue = dialogue
	dialogue_index = 0

func dialogue_animation_complete(object, key):
	print("Anoim,ation finished")
	finished = true
	
func _process(delta):
	next_indicator.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		load_dialogue()

func load_dialogue():
	# TODO: Implement back button for dialogue, and first ui_accept should show current sentence completed
	# before moving to next sentence
	if dialogue_index < dialogue.size():
		finished = false
		text_label.bbcode_text = dialogue[dialogue_index]
		start_dialogue_animation()
		dialogue_index += 1
	else:
		emit_signal("dialogue_complete")

func start_dialogue_animation():
	text_label.percent_visible = 0
	tween.interpolate_property(text_label, "percent_visible", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
	
