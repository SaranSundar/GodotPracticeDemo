tool
class_name CustomTileMap extends YSort

# Load Resources
var grid_data: GridData = preload("res://resources/grid_data/grid_data_resource.tres")
var common: Common = preload("res://resources/common/common_resource.tres")
var tiles: Tiles = preload("res://resources/tiles/tiles_resource.tres")
var tile_set_medieval = preload("res://resources/tiles/tile_set_medieval.tres")

# Map constants
var map_width_in_tiles: int = 20
var map_height_in_tiles: int = 11
onready var background_map: TileMap = $background_layer
onready var foreground_map: TileMap = $foreground_layer

# Editor toggles
export(bool)  var redraw  setget set_redraw
export(bool)  var save  setget save_scene

func setup_maps():
	setup_map($background_layer)
	setup_map($foreground_layer)

func setup_map(map: TileMap):
	map.clear()
	map.set_z_index(common.base_tile_z_index)
	map.set_cell_size(Vector2(common.tile_size, common.tile_size))
	# Maybe this sets the id 0 for set_call tile_atlas id
	map.set_tileset(tile_set_medieval)
	map.set_y_sort_mode(true)

func draw_maps():
	generate_map(tiles.get_background_tile_coords(), $background_layer)
	generate_map(tiles.get_foreground_tile_coords(), $foreground_layer)

func load_resources():
	# Load Resources
	grid_data = load("res://resources/grid_data/grid_data_resource.tres")
	common = load("res://resources/common/common_resource.tres")
	tiles = load("res://resources/tiles/tiles_resource.tres")
	tile_set_medieval = load("res://resources/tiles/tile_set_medieval.tres")

func set_redraw(_value=null):
	# only do this if we are working in the editor
	if !Engine.is_editor_hint(): return
	load_resources()
	setup_maps()
	draw_maps()

func save_scene(_value=null):
	var packed_scene = PackedScene.new()
	# get_tree().edited_scene_root
	# packed_scene.pack(get_tree().edited_scene_root)
	packed_scene.pack(self)
	ResourceSaver.save("res://scenes/world_map/world_map.tscn", packed_scene)
	
	
func generate_map(tile_coords, map: TileMap):
	for x in range(0, map_width_in_tiles):
		for y in range(0, map_height_in_tiles):
			randomize()
			var chance = randi() % 100
			if chance <= 30:
				map.set_cell(x, y, 0, false, false, false, tile_coords[0])
			elif 30 < chance and chance <= 60:
				map.set_cell(x, y, 0, false, false, false, tile_coords[1])
			elif 60 < chance and chance <= 80:
				map.set_cell(x, y, 0, false, false, false, tile_coords[2])
			elif 80 < chance and chance <= 100:
				map.set_cell(x, y, 0, false, false, false, tile_coords[3])
	map.update_dirty_quadrants()
			
