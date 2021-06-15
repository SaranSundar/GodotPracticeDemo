class_name AttackMenu extends CanvasLayer
# List of attack buttons
onready var attack_options = $Control/ColorRect/VBoxContainer.get_children()

signal attack_selected(attack_details)

onready var attacks = [
	{
		'name': 'Lance',
		'power': 1
	},
	{
		'name': 'Double Thrust',
		'power': 2
	},
	{
		'name': 'Rush',
		'power': 3
	},
	{
		'name': 'Pierce',
		'power': 4
	}
]

func _ready():
	for i in range(len(attacks)):
		var attack = attack_options[i] as AttackButton
		attack.set_attack_details(attacks[i])
		attack.connect("attack_clicked", self, "attack_clicked")
	
	focus_on_button(0)

func focus_on_button(index):
	attack_options[index].grab_focus()

func attack_clicked(attack_info):
	emit_signal("attack_selected", attack_info)
