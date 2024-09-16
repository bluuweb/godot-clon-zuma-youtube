extends Node

@export var pathfollow_ball_scene: PackedScene
@onready var path_2d: Path2D = $Path2D
var array_follows := []

func _ready() -> void:
	#create_ball()
	pass

func create_ball():
	var ball = pathfollow_ball_scene.instantiate()
	ball.id = array_follows.size() + 1
	path_2d.add_child(ball)
	array_follows.append({
		"id": ball.id,
		"ball": ball,
		"color": ball.get_color()
	})

func add_ball_to_path2D(ball_ref, new_ball):
	#print(ball_ref.id)
	#print(new_ball)
	for item in array_follows:
		if item.id < ball_ref.id:
			item.ball.progress_ratio += 0.01
		else:
			item.id += 1
			item.ball.id = item.id
	
	new_ball.id = ball_ref.id
	array_follows.append({
		"id": new_ball.id,
		"ball": new_ball,
		"color": new_ball.get_color()
	})
	
	#print(array_follows)

func _on_timer_create_ball_timeout() -> void:
	create_ball()
