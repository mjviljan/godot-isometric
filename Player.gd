extends CharacterBody2D

enum Direction { SW, NW, NE, SE, NONE }

const X_STEP_SIZE = 65
const Y_STEP_SIZE = 32

func get_moving_direction():
	var horizontal_movement = int(Input.is_action_just_pressed("ui_right")) - int(Input.is_action_just_pressed("ui_left"))
	
	if (horizontal_movement < 0):
		return Direction.SW
	if (horizontal_movement > 0):
		return Direction.NE

	var vertical_movement = int(Input.is_action_just_pressed("ui_up")) - int(Input.is_action_just_pressed("ui_down"))
	
	if (vertical_movement < 0):
		return Direction.SE
	if (vertical_movement > 0):
		return Direction.NW

	return Direction.NONE

func get_movement_deltas():
	match get_moving_direction():
		Direction.SW:
			return Vector2(-X_STEP_SIZE, Y_STEP_SIZE)
		Direction.NW:
			return Vector2(-X_STEP_SIZE, -Y_STEP_SIZE)
		Direction.NE:
			return Vector2(X_STEP_SIZE, -Y_STEP_SIZE)
		Direction.SE:
			return Vector2(X_STEP_SIZE, Y_STEP_SIZE)
			
	return Vector2.ZERO
	
func _physics_process(_delta):
	var movement_deltas = get_movement_deltas()

	if (movement_deltas != Vector2.ZERO):
		position.x = position.x + movement_deltas.x
		position.y = position.y + movement_deltas.y
		move_and_slide()
