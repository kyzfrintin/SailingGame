extends Sprite3D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var time
var rand
var start_opacity

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	rand = rand_range(-1,1)
	time = 0
	start_opacity = rand_range(0,0.3)
	# print(rand)
	# layers = 2 # change the cull mask layers visibility to 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	global_rotate(Vector3(0,1,0),0.0001*rand)
	opacity = start_opacity #-clamp(sin(time*0.005),0,1)