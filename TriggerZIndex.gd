extends Area2D

# This trigger changes one of the obstacles to be completely view-blocking. A trigger is needed
# because the player object has two sprites with different Z-index values for one of them "glowing"
# through another obstacle. In a real scenario all obstacles would use one of these approaches and
# it could be handled with Z-indexes alone — i.e. this functionality is for demonstration only.

@onready var obstacle = get_parent()
@onready var original_z_index = obstacle.z_index

func _on_body_entered(body):
	if (body == %Player):
		obstacle.z_index = 10

func _on_body_exited(body):
	if (body == %Player):
		obstacle.z_index = original_z_index
