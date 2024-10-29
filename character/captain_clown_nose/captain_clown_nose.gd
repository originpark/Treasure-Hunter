class_name CaptainClownNose
extends BasicCharacter


@export var run_speed: float = 120.0
@export var jump_power: float = -294.0
## 角色当前实际推力
@export var push_force: float = 250

## 小丑鼻子技能相关, 技能检测区域
@onready var detection_area: Area2D = $DetectionArea
## 小丑鼻子技能相关, 探测区域检测到的物体
var obj_list:Array[Node2D]
## 小丑鼻子技能相关, 剪切的物品
var cut_obj: Node2D = null
var cut_obj_added: bool = false
var copy_mode: bool = false

func _ready() -> void:
	super()
	current_move_speed = run_speed
	unlock_input()
	change_to_player(null)



func _physics_process(delta: float) -> void:
	#print(velocity.x)
	super(delta)
	if input_ablitity and not cut_obj:
		#print("进入cut模式")
		var overlapping_bodies := detection_area.get_overlapping_bodies()
		obj_list = overlapping_bodies
		#print("obj_list: ", overlapping_bodies)
		for obj in overlapping_bodies:
			#print(obj.name, "进入了", name, "的技能区域")
			if obj.interactable.mouse_selected: 
				#print("鼠标选中了 ", obj.name)
				(obj.interactable.shader_material as ShaderMaterial).set_shader_parameter("width", 1.0)
				if Input.is_action_just_pressed("left_click"):
					input_ablitity = false
					captain_skill(obj)
	if input_ablitity and cut_obj:
		#print("进入paste模式")
		if not cut_obj_added:
			#print("添加", cut_obj.name, "到场景树")
			cut_obj.interactable.register_outline_shader()
			if cut_obj.has_method("disable"):
				cut_obj.disable()
			owner.add_child(cut_obj)
			cut_obj_added = true
		cut_obj.global_position = get_global_mouse_position()
		if Input.is_action_just_pressed("left_click"):
			var map_position := (owner.tile_map as TileMapLayer).local_to_map(get_global_mouse_position())
			if (owner.tile_map as TileMapLayer).get_cell_source_id(map_position) != -1:
				print("你放到墙里了")
				return
			if cut_obj.has_method("enable"):
				cut_obj.enable()	
				input_ablitity = false
				cut_obj = null
				cut_obj_added = false
		
	
func check_input() -> void:
	super()
	if Input.is_action_just_pressed("spicial_ability") and not input_ablitity:
		#print("开启特殊能力")
		input_ablitity = true
		return
	if Input.is_action_just_pressed("spicial_ability") and input_ablitity:
		#print("关闭特殊能力")
		if cut_obj and cut_obj_added:
			owner.remove_child(cut_obj)
			cut_obj_added = false 
		input_ablitity = false
		for obj in obj_list:
			(obj.interactable.shader_material as ShaderMaterial).set_shader_parameter("width", 0.0)
		return


func _on_detection_area_body_exited(body: Node2D) -> void:
	(body.interactable.shader_material as ShaderMaterial).set_shader_parameter("width", 0.0)


func captain_skill(obj: Node2D) -> void:
	var interactable: Interactable = obj.interactable
	interactable.regisiter_teleport_shader()
	var shader_material: ShaderMaterial = interactable.animation_sprite.material
	var tween: Tween = create_tween()
	tween.set_loops(20)
	tween.tween_callback(func (): shader_material.set_shader_parameter("progress", shader_material.get_shader_parameter("progress") + 0.05)).set_delay(0.05)
	await tween.finished
	owner.remove_child(obj)
	cut_obj = obj
	#print(cut_obj)
