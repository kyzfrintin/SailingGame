extends KinematicBody

"""
All Items shall inherit from this script.
Here also all children instances can be stored, so that other script can acces the correct stuff from here. 
EG dont use $Mesh1 in some script but define mesh var here and access this var.
"""

## settings
export(bool) var movable = true
export(float) var penetrationFactor = 2 # penetration factor used for bullets
var maxHealth = 100
var damageMultiplier = 10 # multiple base damage by this value, just so that the maxHealth values can be bigger integers


var myShip # obj ship that this is on
var gridMesh # green/red mesh that displays the hitbox of items
var pAudio # audio player thats emitting when item is placed
var itemPlaceParticle # dynamically loaded particles 
var currentHealth = maxHealth
var particleRes = load("res://ObjectNodes/Items/ItemPlaceParticle.tscn") # universal placement particles
var isPlayerControlable = false # if player can control this item (also maybe click on it)

func _ready():
	gridMesh = get_node("GridShowMesh")
	pAudio = $PlaceAudio

	
	itemPlaceParticle = particleRes.instance()
	itemPlaceParticle.one_shot = true
	itemPlaceParticle.emitting = false
	add_child(itemPlaceParticle)
	fetchMyShip() # TODO: should be called only when onPlaced. and onPlacement needs to be called when static items are already on ship

func fetchMyShip():
	## TODO: this gets also called when item is picked in shop
	myShip = get_parent().get_parent().get_parent()
	if myShip != null:
		if "isPlayer" in myShip:
			if myShip.isPlayer:
				isPlayerControlable = true


func on_placement():
	"""
	Gets called every time the item is placed onto the ship (shopping, replacing).
	"""
	if gridMesh!=null:
		gridMesh.visible = false # make the grid item invisible again
	itemPlaceParticle.emitting = true
	
	if pAudio!=null:
		pAudio.set_pitch_scale(pAudio.pitch_scale+rand_range(-0.2,0.2))
		pAudio.play()

func giveDmg(damage : float):
	"""
	reports damage taken by bullet to this object.
	"""
	currentHealth = clamp(currentHealth - damage*damageMultiplier,0,maxHealth)

func createInfo(placeholder):
	"""
	Instances the correponding item info panel and moves it to placeholder.rect_position.
	The instanced info box connects to this item and communicates user input and item stati.
	"""
	pass

func removeInfo():
	"""
	removes info panel again
	"""
	pass
