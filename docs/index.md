# Treasure-Hunter

## 目录结构

- `assets`: 存放艺术资源
- `component`: 组件,给某个节点赋予一个功能
  - `direction`: 方向组件
  - `state_machine`: 状态机组件

- `character`: 逻辑上的游戏角色
  - `captain_clown_nose`: 游戏主角,小丑鼻子

- `entity`: 逻辑上的游戏物品
  - `interactable`: 可互动实体
  - `stuff`: 不可互动实体
    - `dust`: 角色运动时生成的灰尘
- `scene`: 游戏世界场景,关卡

## 架构

### 角色

- 角色父节点: `BasicCharacter`
  - 图形组件: `Graphics`
  - 方向组件: `Direction`
  - 状态机组件: `StateMachine`



### 对话系统

气泡管理器

对话气泡

情绪气泡





## 项目设置

首先开启高级设置选项,此选项会开放更多的设置内容

<img src="assets/image-20241007143743438.png" alt="image-20241007143743438" style="zoom: 50%;" />



2d像素游戏中,需要修改纹理过滤方式为`Nearest`, 以便得到清晰的像素图形

<img src="assets/image-20241007144425604.png" alt="image-20241007144425604" style="zoom:50%;" />



调整窗口大小以及画面缩放比例

窗口高度/宽度覆盖表示固定窗口的尺寸的大小

视口高度/宽度表示实际显示的游戏游戏画面的大小,这里将视口宽高设为窗口宽高的1/3

然后将画面拉伸模式设为`canvas_items`:  将游戏画面拉伸至覆盖整个屏幕

最终效果就是游戏画面放大3倍显示

![image-20241007144612191](assets/image-20241007144612191.png)

<img src="assets/image-20241007145234903.png" alt="image-20241007145234903" style="zoom:50%;" />

## 详解

### Dust

角色运动时产生的灰尘

**1.结构:**`/entity/stuff/dust`

- `dust_creater.gd`:
  - `generete(dust_scene, parent, pos) -> Dust:`: 生成指定的灰尘场景
- `run_dust.tscn`: 奔跑灰尘场景
- `fall_dust.tscn`: 降落灰尘场景
- `jump_dust.tscn`: 起跳灰尘场景



**2. 生成灰尘流程**

以奔跑灰尘举例:

进入run状态后,调用`dust_creater`的`generate`方法在指定父节点的指定位置生成灰尘

<img src="assets/image-20241007214657980.png" alt="image-20241007214657980" style="zoom:50%;" />



在退出run状态时,调用灰尘的`free_defeered`方法,等待当前灰尘播放完动画后自我释放

<img src="assets/image-20241007214436440.png" alt="image-20241007214436440" style="zoom:50%;" />