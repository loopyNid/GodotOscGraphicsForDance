extends Spatial

var oscrcv
var party
var sky
var prevArgs
var weight = 0.0000000001
var piNumber
var instancesArr = []

onready var dancer = preload("res://dancer.tscn")

func _ready():
	party = get_node("../Particles")
	oscrcv = load("res://addons/gdosc/bin/gdoscreceiver.gdns").new()
	oscrcv.max_queue( 20 )
	oscrcv.avoid_duplicate( true )	# receiver will only keeps the "latest" message for each address
	oscrcv.setup( 14000 )			# listening to port 14000
	oscrcv.start()					# starting the reception of messages

	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	while( oscrcv.has_message() ): 	# check if there are pending messages
		var msg = oscrcv.get_next()	# retrieval of the messages as a dictionary
		# piNumber = int(msg["address"][3])
		# print(instancesArr)
		# if piNumber % 2 == 1:
		# 	if piNumber in instancesArr:
		# 		pass
		# 	else:
		# 		instancesArr.append(piNumber)
		# 		var dancerIns = dancer.instance()
		# 		dancerIns.name = msg["address"]
		# 		get_node("../Particles").add_child(dancerIns)
		# using message data
		var args = msg["args"]
		if prevArgs == null:
			prevArgs = args
		if msg["address"] == "/pi1":
			# here goes the address array check
			get_node("../Particles/pi1").translation = Vector3( (lerp(float(prevArgs[0]), float(args[0]), weight)/5), (lerp(float(prevArgs[1]), float(args[1]), weight)/5), (lerp(float(prevArgs[2]), float(args[2]), weight)/5) )
		if msg["address"] == "/pi3":
			# here goes the address array check
			get_node("../Particles/pi3").translation = Vector3( (lerp(float(prevArgs[0]), float(args[0]), weight)/5), (lerp(float(prevArgs[1]), float(args[1]), weight)/5), (lerp(float(prevArgs[2]), float(args[2]), weight)/5) )
		if msg["address"] == "/pi5":
			# here goes the address array check
			get_node("../Particles/pi5").translation = Vector3( (lerp(float(prevArgs[0]), float(args[0]), weight)/5), (lerp(float(prevArgs[1]), float(args[1]), weight)/5), (lerp(float(prevArgs[2]), float(args[2]), weight)/5) )
		prevArgs = args
	pass

func _exit_tree ( ):
	oscrcv.stop()					# stops listening to port, highly recommended!
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
