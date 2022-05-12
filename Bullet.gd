extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 750
var playerWhoShot
var timeToLive = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	timeToLive -= delta
	if timeToLive < 0:
		queue_free()
	position += transform.x * speed * delta
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Bullet_body_entered(body):
	print("hit player: " + str(body))
	if body.name != playerWhoShot:
		if OnlineMatch.is_network_master_for_node(self):
			OnlineMatch.custom_rpc_sync(body, "Die")
		
	pass # Replace with function body.
