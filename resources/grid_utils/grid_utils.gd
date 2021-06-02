class_name GridUtils extends Resource

func get_valid_neighbor_cells(start: Vector2):
	# TODO: Check if neighbor cell is valid
	var directions = [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]
	var neighbors = []
	
	for dir in directions:
		neighbors.append(start + dir)
		
	return neighbors
	
func get_cost_of_cell(position: Vector2):
	# TODO: Factor in all costs including player and cell
	return 1
	
func sort_grid_nodes(a: GridNode, b: GridNode):
	return a.cumulative_cost < b.cumulative_cost

func search_for_tiles(start: Vector2, limit: int):
	var locations = {}
	# This needs to be priority queue
	var cells_to_visit = [GridNode.new(start, 0, null)]
	
	while len(cells_to_visit) > 0:
		var cell: GridNode = cells_to_visit.pop_front()
		if cell.position in locations:
			if locations[cell.position].cumulative_cost > cell.cumulative_cost:
				locations[cell.position] = cell
		else:
			locations[cell.position] = cell
		
		var neighbors = get_valid_neighbor_cells(cell.position)
		
		for i in range(len(neighbors) - 1, -1, -1):
			if neighbors[i] in locations:
				neighbors.remove(i)
			else:
				var cost_to_move = cell.cumulative_cost + get_cost_of_cell(cell.position)
				if cost_to_move <= limit:
					cells_to_visit.append(GridNode.new(neighbors[i], cost_to_move, cell))
		
		cells_to_visit.sort_custom(self, "sort_grid_nodes")
	
	return locations
	
