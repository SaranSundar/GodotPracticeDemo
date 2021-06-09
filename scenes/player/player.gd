tool
class_name Player extends KinematicBody2D 


# Load Resources
const common: Common = preload("res://resources/common/common_resource.tres")
const mage_male_sprite_frames: SpriteFrames = preload("res://resources/character_sprite_frames/mage_male_sprite_frames.tres")

export(bool)  var redraw  setget set_redraw

# Movement variables
const ACCELERATION = 500
const MAX_SPEED = 80
const FRICTION = 500

var velocity = Vector2.ZERO
var input_vector = Vector2(0, 0)

onready var animated_sprite = $AnimatedSprite
var current_animation = "move_down"

func set_redraw(_value = null):
	# only do this if we are working in the editor
	if !Engine.is_editor_hint(): return
	self.set_z_index(600)
	self.set_scale(Vector2(0.5, 0.5))
	$AnimatedSprite.centered = false
	$AnimatedSprite.set_sprite_frames(load("res://resources/character_sprite_frames/mage_male_sprite_frames.tres"))
	$AnimatedSprite.set_animation(current_animation)

func _ready():
	self.set_z_index(common.character_z_index)
	# Player sprites are 32x32 so we need to cut scale by half
	self.set_scale(Vector2(0.5, 0.5))
	animated_sprite.centered = false
	animated_sprite.set_sprite_frames(mage_male_sprite_frames)
	animated_sprite.set_animation(current_animation)

func process_update(delta: float):
	pass

func update_animation(prev_pos: Vector2, next_pos: Vector2):
	input_vector = next_pos - prev_pos
	input_vector = input_vector.normalized()
	
	if input_vector.x > 0:
		current_animation = "move_right"
	elif input_vector.x < 0:
		current_animation = "move_left"
	elif input_vector.y < 0:
		current_animation = "move_up"
	elif input_vector.y > 0:
		current_animation = "move_down"
	
	animated_sprite.set_animation(current_animation)
	animated_sprite.play()

func free_movement(delta: float):
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	
	if input_vector.x > 0:
		current_animation = "move_right"
	elif input_vector.x < 0:
		current_animation = "move_left"
	elif input_vector.y < 0:
		current_animation = "move_up"
	elif input_vector.y > 0:
		current_animation = "move_down"
	
	animated_sprite.set_animation(current_animation)
	
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		animated_sprite.play()
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		animated_sprite.stop()
	
	velocity = move_and_slide(velocity)
