class_name InBattleScene extends Node2D

onready var custom_tile_map = $custom_tile_map
onready var player = $player
onready var camera = $camera

func _init():
	self.set_name("InBattleScene")

func update_scene():
	player.update_player()
	camera.update_camera()
