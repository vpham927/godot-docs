extends Area2D

signal hit

@export var speed: int = 400

var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size
	#Hide the player when the game starts 
	hide()
func _process(delta: float) -> void:
	# We need to set the velocity to 0,0 as the start of the frame 
	var velocity = Vector2.ZERO 
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 10
	if Input.is_action_pressed("move_left"):
		velocity.x -= 10
	if Input.is_action_pressed("move_up"):
		velocity.y -= 10
	if Input.is_action_pressed("move_down"):
		velocity.y += 10
	
	#We always need to normalize the movement 
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
		
		#Clamp the player position
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)

	#Animation for player
	if velocity.x != 0: 
		$AnimatedSprite2D.animation = ("walk")
		$AnimatedSprite2D.flip_v = false
		
		#not sure what this bit does
		$AnimatedSprite2D.flip_h = velocity.x < 0
	
	elif velocity.y != 0: 
		$AnimatedSprite2D.animation = ("up")	
		$AnimatedSprite2D.flip_v = velocity.y > 0
	else:
		$AnimatedSprite2D.stop()


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
