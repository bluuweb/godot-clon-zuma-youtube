extends PathFollow2D

var speed = 0.01
var is_player_ball = false
var speed_ball_player = 500
var direction_to_mouse
var id
var ratio

func _ready() -> void:
	if is_player_ball:
		$Area2DBall/AnimatedSprite2D.play("red")
	else: 
		$Area2DBall/AnimatedSprite2D.play("blue")

func _process(delta: float) -> void:
	$Label.text = str(id)
	if not is_player_ball:
		progress_ratio += delta * speed
		ratio = progress_ratio
	elif direction_to_mouse:
		global_position += speed_ball_player * direction_to_mouse * delta

func get_color():
	return str($Area2DBall/AnimatedSprite2D.animation)
		
func create_ball_player(value, position_player):
	global_position = position_player
	is_player_ball = true
	direction_to_mouse = value
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
func _on_area_2d_ball_area_entered(area: Area2D) -> void:
	var followBallPlayer = area.get_parent()
	if followBallPlayer.is_player_ball:
		followBallPlayer.is_player_ball = false
		var path2d = get_parent()
		var level = followBallPlayer.get_parent()
		#level.move_child(followBallPlayer, 2)
		level.remove_child(followBallPlayer)
		path2d.add_child(followBallPlayer)
		level.add_ball_to_path2D(self, followBallPlayer)
		followBallPlayer.progress_ratio = progress_ratio + 0.01
