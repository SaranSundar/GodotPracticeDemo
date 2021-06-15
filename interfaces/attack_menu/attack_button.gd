class_name AttackButton extends TextureButton

onready var attack_name = $attack_name
onready var attack_icon = $attack_icon
onready var attack_power = $attack_power

var attack_info = {}

signal attack_clicked(attack_details)

func _ready():
	self.connect("pressed", self, "clicked_attack")

func set_attack_details(attack_details):
	attack_info = attack_details
	set_attack_power(attack_info.power)
	set_attack_name(attack_info.name)
	
func clicked_attack():
	print(attack_name.text, " was clicked")
	emit_signal("attack_clicked", attack_info)

func set_attack_power(power: int):
	if power < 1 or power > 4:
		print("ERROR: POWER MUST BE IN RANGE 1-3")
		return
	attack_power.texture = load("res://assets/attack_menu/power/star" + str(power) + ".png")

func set_attack_name(name):
	attack_name.text = name

func set_attack_icon(path):
	attack_icon.texture = load(path)
