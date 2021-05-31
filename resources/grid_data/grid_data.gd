class_name GridData extends Resource

var current_level = [
		[9, 9, 3, 3, 3, 3, 297, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3],
		[3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 9],
		[3, 3, 3, 3, 3, 3, 3, 10, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 9],
		[4, 3, 3, 3, 3, 3, 3, 10, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 9],
		[4, 5, 3, 3, 3, 3, 3, 11, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 9],
		[4, 6, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 9],	
		[3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 9],
		[3, 3, 3, 3, 300, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 9],
		[3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 9],
		[3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 9],
		[3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 9]
	]

func get_cell(row: int, col: int):
	return current_level[row][col]

func set_cell(row: int, col: int, value: int):
	current_level[row][col] = value

func get_cell_global_position(cell, tile_size) -> Vector2:
	# Cell is a row, col
	return (Vector2(cell[1], cell[0]) * tile_size)

func get_cell_bounds(position, tile_size) -> Vector2:
	var row = 0
	var col = 0
	row = floor(position.y / tile_size)
	col = floor(position.x / tile_size)
	return Vector2(row, col)
	
