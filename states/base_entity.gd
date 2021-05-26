class_name BaseEntity extends Node2D

# Virtual function. Receives events from the `_unhandled_input()` callback.
func process_input(event: InputEvent) -> void:
	pass


# Virtual function. Corresponds to the `_process()` callback.
func process_update(delta: float) -> void:
	pass


# Virtual function. Corresponds to the `_physics_process()` callback.
func process_physics_update(delta: float) -> void:
	pass
