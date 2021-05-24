class_name State extends Node

# Each state can hold a high level container scene that the states interact with
# This container state scene is different from the one in state machine
var state_scene = null
var transition_to: FuncRef = null

# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func update(delta: float) -> void:
	pass


# Virtual function. Corresponds to the `_physics_process()` callback.
func physics_update(delta: float) -> void:
	pass


# Virtual function. Called by the state machine upon changing the active state. The `data` parameter
# is a dictionary with arbitrary data the state can use to initialize itself.
func enter(data := {}) -> void:
	pass


# Virtual function. Called by the state machine before changing the active state. Use this function
# to clean up the state.
func exit() -> void:
	queue_free()
