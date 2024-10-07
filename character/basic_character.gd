class_name BasicCharacter
extends CharacterBody2D
## Basic Character

## 图形资源组件
@export var graphics: Node2D
## 方向组件
@export var direction: Direction
## 状态机组件
@export var state_machine: StateMachine
## 动画控制器
@export var animation_player: AnimationPlayer

## 默认重力
var default_gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
## 重力
var garvity: int = default_gravity
## 通过玩家输入获取的方向, 与方向组件绑定
var expect_direction: int = 0:
	set(v):
		if v != 0:
			direction.value = v
		expect_direction = v
## 角色当前实际移动速度
var current_move_speed: float = 0
## 玩家输入jump动作
var input_jump: bool = false
## 是否允许玩家控制该角色
var input_lock: bool = true


func _ready() -> void:
	state_machine.start()
	
func _physics_process(delta: float) -> void:
	_take_gravity(delta)
	
	if not input_lock:
		check_input()
	
	velocity.x = current_move_speed * (expect_direction / 1.0)
	
	move_and_slide()
	

func check_input() -> void:
	basic_movement_input_check()


func basic_movement_input_check() -> void:
	expect_direction = Input.get_axis("move_left", "move_right") as int
	input_jump = true if Input.is_action_just_pressed("jump") else false


func _take_gravity(delta: float) -> void:
	velocity.y += garvity * delta


func unlock_input() -> void:
	input_lock = false


func lock_input() -> void:
	input_lock = true
