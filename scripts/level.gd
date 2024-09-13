extends Node

@export var ball_scene: PackedScene
var speed = 0.01
var array_follows := []

func _ready() -> void:
	Global.connect("on_ball_add_to_path", player_ball_add_to_path2d)
	create_ball()

func _process(delta: float) -> void:
	for follow in array_follows:
		follow.progress_ratio += speed * delta
	
func create_ball():
	var ball = ball_scene.instantiate()
	var new_pathFollow = PathFollow2D.new()
	ball.path_follow_ref = new_pathFollow
	
	
	$Walk/Path2D.add_child(new_pathFollow)
	new_pathFollow.add_child(ball)
	
	
	array_follows.append(new_pathFollow)

func _on_timer_create_ball_timeout() -> void:
	pass
	#create_ball()
	
func player_ball_add_to_path2d(player_ball, progress_ratio):
	print(player_ball)
	var new_pathFollow = PathFollow2D.new()
	$Walk/Path2D.add_child(new_pathFollow)
	new_pathFollow.add_child(player_ball)
	#new_pathFollow.progress_ratio = progress_ratio + 0.01
	array_follows.append(new_pathFollow)
