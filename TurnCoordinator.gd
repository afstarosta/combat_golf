extends Node2D

var players: Array = []
var current_player:int
var ball: KinematicBody2D


func _physics_process(delta):
    if Input.is_action_just_pressed("ui_accept"):
        ball.launch(Vector2(randf(), randf()), 10)

func _ready():
    players = get_tree().get_nodes_in_group("player")
    current_player = 0
    ball = get_tree().get_nodes_in_group("ball")[0]
    ball.connect("ball_stopped", self, "handle_ball_stop")

func handle_ball_stop():
    print("BALL STOPPED")
    skip_turn()
    adjust_turn()

func skip_turn():
    current_player = (current_player + 1) % len(players)
    
func adjust_turn():
    players[current_player].position = ball.position
