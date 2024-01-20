extends Node2D

enum Direction { SW, NW, NE, SE, NONE }

const PLAYER_RENDER_OFFSET = Vector2(0, -28)

var valid_cells: Array[Vector2i] = []
var player_position: Vector2i = Vector2i.ZERO

@onready var shader_obstacle_material = $"Transparency shader obstacle".material as ShaderMaterial

func _ready():
	valid_cells = $Ground.get_used_cells(0)
	player_position = Vector2i(0, 6)
	$Player.position = player_position_to_coordinates()

func get_moving_direction() -> Direction:
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

func get_movement_deltas() -> Vector2i:
	match get_moving_direction():
		Direction.SW:
			return Vector2i(0, 1)
		Direction.NW:
			return Vector2i(-1, 0)
		Direction.NE:
			return Vector2i(0, -1)
		Direction.SE:
			return Vector2i(1, 0)
			
	return Vector2.ZERO

func player_position_to_coordinates() -> Vector2:
	return $Ground.map_to_local(player_position) + PLAYER_RENDER_OFFSET

func is_valid_position(target_position: Vector2i) -> bool:
	return valid_cells.has(target_position)
	
func _process(_delta):
	var movement_deltas = get_movement_deltas()

	if (movement_deltas != Vector2i.ZERO):
		if is_valid_position(player_position + movement_deltas):
			player_position += movement_deltas;
			$Player.position = player_position_to_coordinates()
			$Player.move_and_slide()
			shader_obstacle_material.set_shader_parameter("holeCenter", $Player.position)
