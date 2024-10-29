class_name BasicCharacter
extends CharacterBody2D
## Basic Character

## 图形资源组件
@export var graphics: Node2D
## 方向组件
@export var direction: Direction
## 状态机组件
@export var state_machine: StateMachine
## 属性组件
@export var stats: Stats
## 动画控制器
@export var animation_player: AnimationPlayer
## 对话气泡生成的位置
@export var bubble_marker: Marker2D

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
## 是否冻结速度
var move_lock: bool = false
## 推动动作
var input_push: bool = false
## 特殊能力
var input_ablitity: bool = false
## 是否受伤
var is_hurt: bool = false


## 是否为当前玩家扮演的角色
var is_player: bool = false


func _ready() -> void:
	state_machine.start()

	
func _physics_process(delta: float) -> void:
	# 承受重力
	_take_gravity(delta)
	
	# 控制是否为玩家操控的角色
	if not input_lock:
		check_input()
	
	if not move_lock:
	# 控制水平移动(除了idle以外的任何状态都可以随时水平移动,因此放在basic_character里)
		velocity.x = (current_move_speed * stats.SPD) * (expect_direction / 1.0)
	#print(velocity.x)
	move_and_slide()
	
	
	
func check_input() -> void:
	basic_movement_input_check()
	input_push = true if Input.is_action_pressed("push") else false


func basic_movement_input_check() -> void:
	expect_direction = Input.get_axis("move_left", "move_right") as int
	input_jump = true if Input.is_action_just_pressed("jump") else false
	


func _take_gravity(delta: float) -> void:
	velocity.y += garvity * delta


func unlock_input() -> void:
	input_lock = false


func lock_input() -> void:
	expect_direction = 0
	input_lock = true


func change_to_player(from: BasicCharacter) -> void:
	if from:
		from.is_player = false
	is_player = true
	Store.user_store.MAX_HP = stats.MAX_HP
	Store.user_store.HP = stats.HP
	
	
