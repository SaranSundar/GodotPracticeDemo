class_name InBattleScene extends Node2D

onready var custom_tile_map = $custom_tile_map
onready var player = $player
onready var camera = $camera

func _init():
	self.set_name("InBattleScene")

func update_scene(delta: float):
	player.update_player(delta)
	camera.update_camera(delta)
