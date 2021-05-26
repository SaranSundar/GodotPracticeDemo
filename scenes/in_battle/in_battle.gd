class_name InBattleScene extends Node2D

onready var custom_tile_map = $custom_tile_map
onready var player = $player
onready var camera = $camera

func _ready():
	set_name("InBattleScene")

func process_update(delta: float):
	player.process_update(delta)
	camera.process_update(delta)
