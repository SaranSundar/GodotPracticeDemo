class_name State extends BaseEntity

# Each state can hold a high level container scene that the states interact with
# This container state scene is different from the one in state machine
var local_scene = null
var state_machine: StateMachine = null

func free_scene(scene):
	if is_instance_valid(scene):
		remove_child(scene)
		scene.queue_free()

func remove_scene(scene):
	if is_instance_valid(scene):
		remove_child(scene)

func add_scene(scene):
	add_child(scene)
	
func add_local_scene(new_local_scene):
	free_scene(local_scene)
	local_scene = new_local_scene
	add_child(local_scene)

# Virtual function. Called by the state machine upon changing the active state. The `data` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
# On Ready is called only once, but enter is called every time the state is added back to the top of the stack
func enter(data := {}) -> void:
	pass

# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	# Do any cleanup logic here to delete all states
	free_scene(local_scene)
	queue_free()
