class_name AttackMenu extends Control

# List of attack buttons
onready var attack_options = $ColorRect/VBoxContainer.get_children()

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

func attack_clicked(attack_info):
	print(attack_info)
