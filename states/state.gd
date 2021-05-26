class_name State extends BaseEntity

# Each state can hold a high level container scene that the states interact with
# This container state scene is different from the one in state machine
var local_scene = null
var state_machine = null

# Virtual function. Called by the state machine upon changing the active state. The `data` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(data := {}) -> void:
	pass
	
func add_local_scene(new_local_scene):
	if is_instance_valid(self.local_scene):
		remove_child(self.local_scene)
		local_scene.queue_free()
	local_scene = new_local_scene
	add_child(local_scene)


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	# Do any cleanup logic here to delete all states
	remove_child(local_scene)
	local_scene.queue_free()
	queue_free()

# Calls method on parent FSM
func transition_to(transition_state, delete_state: bool = true, data: Dictionary = {}) -> void:
	state_machine.transition_to(transition_state, delete_state, data)
