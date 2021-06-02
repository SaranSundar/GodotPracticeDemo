class_name GridNode extends Reference

# Cell positon (Row, Coll)
var position : Vector2

# Cost to get to this node
var cumulative_cost : float

# Previous grid node
var prev_grid_node: GridNode

func _init(_position: Vector2, _cumulative_cost: float, _prev_grid_node: GridNode):
	position = _position
	cumulative_cost = _cumulative_cost
	prev_grid_node = _prev_grid_node
	
func print_node():
	if prev_grid_node == null:
		return str("Position: ", position, " Cumulative Cost: ", cumulative_cost, " Prev: null")
	else:
		return str("Position: ", position, " Cumulative Cost: ", cumulative_cost, " Prev: ", prev_grid_node.position, " ", prev_grid_node.cumulative_cost)
