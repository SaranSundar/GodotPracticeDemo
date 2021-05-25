class_name DialogueBox extends CanvasLayer

var dialogue = [
	'Welcome to the world of Ethereal!',
]

var dialogue_index = 0
var finished = false

onready var text_label = $dialogue_box_container/dialogue_box/RichTextLabel
onready var tween = $dialogue_box_container/dialogue_box/Tween
onready var next_indicator = $dialogue_box_container/dialogue_box/next_indicator
	
	
