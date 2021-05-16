class_name State extends Node

# Each state can have a exit transition state
var exit_state: State = null

# Virtual function. Receives events from the `_unhandled_input()` callback.
func handle_input(event: InputEvent, transition_to: FuncRef) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func update(delta: float, transition_to: FuncRef) -> void:
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
func exit() -> State:
	return exit_state
