tool
class_name Tiles extends Resource

# (X, Y) coords
# Row 1
export var medieval_grass_dark = Vector2(0, 0)
export var medieval_grass_light = Vector2(1, 0)
export var medieval_grass_dark_striped = Vector2(2, 0)
export var medieval_grass_light_striped = Vector2(3, 0)
export var medieval_dark_trees = Vector2(4, 0)
export var medieval_light_trees = Vector2(5, 0)
export var medieval_tree_cluster = Vector2(6, 0)
# Row 2
export var medieval_small_house = Vector2(0, 1)

func get_background_tile_coords():
	var background_tile_coords = [
	medieval_grass_dark, medieval_grass_light, medieval_grass_dark_striped,
	medieval_grass_light_striped]
	return background_tile_coords
	
func get_foreground_tile_coords():
	var foreground_tile_coords = [
		medieval_dark_trees, medieval_light_trees, medieval_tree_cluster,
		medieval_small_house
	]
	return foreground_tile_coords
