class_name MainMenuScene extends Control

onready var begin_battle_button = $Panel/begin_battle_button
onready var exit_game_button = $Panel/exit_game_button

func _ready():
	set_name("BeginBattleMenu")
