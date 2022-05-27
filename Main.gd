extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var readyPlayers = {}
func _get_custom_rpc_methods():
	return [
		"playerIsReady",
		"DetermineWinner"
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/ReadyScreen.connect("PlayerReady",self, "playerReady")
	$Players.connect("GameOver",self, "onGameOver")
	pass # Replace with function body.

func playerReady():
	for session_id in readyPlayers:
		pass
		#rpc_id( "playerIsReady", [session_id])
	
	
remotesync func playerIsReady(id):
	$Control/ReadyScreen.setReadyStatus(id, "Ready")
	
	if get_tree().is_network_server():
		readyPlayers[id] = true
		if readyPlayers.size() == OnlineMatch.players.size():
			OnlineMatch.start_playing()
			$Players.StartGame(OnlineMatch.get_player_names_by_peer_id())
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func startGame():
	print("All Players Are Ready Lets Start The Game!")

func HideMatchMakeInterface():
	$Control.hide()
func onGameOver(alivePlayers):
	rpc("DetermineWinner" , [alivePlayers])
	
remotesync func DetermineWinner(alivePlayers :Dictionary):
	print(alivePlayers)
	$Control2.show()
	if OnlineMatch.get_network_unique_id() in alivePlayers:
		$Control2/Label.text = "I lose"
	else:
		$Control2/Label.text = "I Win"
