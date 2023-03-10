extends KinematicBody2D

var gravity = 1000
var velocity = Vector2.ZERO
var maxHorizontalSpeed = 140
var jumpSpeed = 360
var horizontalAcceleration = 2000
var jumpTerminationMultiplier = 3

func _ready():
	pass # Replace with function body.



func _process(delta):
	var moveVector = Vector2.ZERO
	moveVector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	moveVector.y = -1 if Input.is_action_just_pressed("move_up") else 0
	velocity.x += moveVector.x * horizontalAcceleration * delta
	
	if (moveVector.x == 0 ):
		velocity.x = lerp(0, velocity.x, pow(2,-50 * delta))
	
	velocity.x = clamp(velocity.x, -maxHorizontalSpeed, maxHorizontalSpeed)
	
	if ( moveVector.y < 0  && is_on_floor()):
		velocity.y = moveVector.y * jumpSpeed
	
	if(velocity.y < 0 && !Input.is_action_just_pressed("move_up")):
		velocity.y += gravity * jumpTerminationMultiplier * delta
	else:
		velocity.y += gravity * delta
	move_and_slide(velocity, Vector2.UP)
