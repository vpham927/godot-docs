extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#We create a new array and we get the animation names from the AnimatedSprite2D
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	#Randomly pick an animation from the array 
	$AnimatedSprite2D.animation = mob_types.pick_random()
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
