class_name BeginBattleMenu extends Control

onready var begin_battle = $Panel/begin_battle_button
onready var exit_game = $Panel/exit_game_button

signal begin_battle

func _ready():
	set_name("BeginBattleMenu")
	begin_battle.connect("pressed", self, "begin_battle_pressed")
	exit_game.connect("pressed", self, "exit_game_pressed")

func begin_battle_pressed():
	emit_signal("begin_battle")

func exit_game_pressed():
	get_tree().quit()
