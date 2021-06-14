class_name AttackButton extends TextureButton

onready var attack_name = $attack_name
onready var attack_icon = $attack_icon
onready var attack_power = $attack_power

func set_attack_power(power: int):
	if power < 1 or power > 4:
		print("ERROR: POWER MUST BE IN RANGE 1-3")
		return
	attack_power.texture = load("res://assets/attack_menu/star" + str(power) + ".png")

func set_attack_name(name):
	attack_name.text = name

func set_attack_icon(path):
	attack_icon.texture = load(path)
