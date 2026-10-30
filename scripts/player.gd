extends CharacterBody2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var health_bar: ProgressBar = $HealthBar
@onready var label: Label = $Label


const SPEED = 700.0
const JUMP_VELOCITY = -2400.0
@export var hp = 100
var wet = 0
var freezed = 0
var poisoned = 0

func _ready():
	health_bar.value = hp
	$Water.hide()
	$Vapour.hide()
	$Snowflake.hide()

func _physics_process(delta: float) -> void:
	
	health_bar.value = hp
	label.text = str(GameManager.feathers)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	
		
	if Input.is_action_just_pressed("jump") and ray_cast_2d.is_colliding():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if freezed:
		velocity.x = 0
	else:	
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	
	if freezed:
		$AnimatedSprite2D.play("freezed")	
	elif velocity.x != 0 and ray_cast_2d.is_colliding():
		$AnimatedSprite2D.play("run")
	else:
		$AnimatedSprite2D.play("idle")
		
	if poisoned:
		hp -= 0.1
		if hp <= 0:
			killPlayer()

	move_and_slide()

func wetStatusOn():
	if poisoned:
		poisoned = 0
		$Vapour.hide()	
	wet = 1
	$Water.show()
	pass
	
func wetStatusOff():
	await get_tree().create_timer(6).timeout
	wet = 0
	$Water.hide()
	pass	

func healthChange(hpAmount, type):

	hp += hpAmount
	if hp <= 0:
		killPlayer()
		pass
	if wet:
		if type == "ice":
			freezed = 1
			wet = 0
			$Water.hide()
			$Snowflake.show()
			await get_tree().create_timer(3).timeout
			freezed = 0
			$Snowflake.hide()
	else:
		if type == "poison":
			poisoned = 1
			$Vapour.show()
			await get_tree().create_timer(6).timeout
			poisoned = 0
			$Vapour.hide()		

func killPlayer():
	position = %RespawnPoint.position
	$AnimatedSprite2D.flip_h = false
	hp = 100



#func _on_death_area_body_entered(body: Node2D) -> void:
	#killPlayer()
