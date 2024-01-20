extends Area2D

@onready var obstacle = get_parent()

func _on_body_entered(body):
	if (body == %Player):
		obstacle.hide()

func _on_body_exited(body):
	if (body == %Player):
		obstacle.show()
