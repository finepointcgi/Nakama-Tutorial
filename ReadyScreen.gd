extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var UserReady = preload("res://UserReady.tscn")
signal PlayerReady()
# Called when the node enters the scene tree for the first time.
func _ready():
	OnlineMatch.connect("player_joined", self, "PlayerJoined")
	OnlineMatch.connect("player_left", self, "PlayerLeft")
	OnlineMatch.connect("player_status_changed", self, "PlayerStatusChanged")
	OnlineMatch.connect("match_ready", self, "MatchReady")
	OnlineMatch.connect("match_not_ready", self, "MatchNotReady")
	OnlineMatch.connect("matchmaker_matched",self, "AddPlayers")
	pass # Replace with function body.

func AddPlayers(players):
	for id in players:
		var userReady = UserReady.instance()
		$VBoxContainer.add_child(userReady)
		userReady.setUsername(players[id]["username"])
		userReady.name = id

func PlayerJoined(player):
	pass
	
func PlayerLeft(player):
	pass
	
func PlayerStatusChanged(player, status):
	pass
	
func MatchReady(player):
	pass
	
func MatchNotReady(player):
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func setReadyStatus(id, status):
	var statusObject = $VBoxContainer.get_node_or_null(id)
	if statusObject:
		statusObject.setReady(status)
	
func _on_Button_button_down():
	emit_signal("PlayerReady")
	pass # Replace with function body.
