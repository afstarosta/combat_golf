extends KinematicBody2D

const SPEED_BASE: float = 25.0
const SPEED_DECAY: float = 50.0

var current_direction: Vector2 = Vector2(0, 0)
var current_speed: float = 0.0
var is_running: bool = false

func _ready():
    launch(Vector2(1, 1), 10)
    
func _physics_process(delta):
    if is_running:
        var collision: KinematicCollision2D = move_and_collide(current_direction * current_speed * delta)
        if collision:
            process_collision(collision)
        decay_speed(delta)

func process_collision(collision: KinematicCollision2D):
    current_direction = current_direction.bounce(collision.normal)

func decay_speed(delta: float):
    current_speed -= delta * SPEED_DECAY
    if current_speed <= 0.0:
        is_running = false
        
func launch(direction: Vector2, force: int):
    if !is_running:
        current_direction = direction
        current_speed = SPEED_BASE * force
        is_running = true

