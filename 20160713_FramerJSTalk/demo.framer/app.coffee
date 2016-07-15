
# Create color variables
gallery = "#7A7E8A"
clear = "#fff"
grey = "#676973"
shadow = "rgba(0,0,0,0.1)"

# Create new background layer
BG = new BackgroundLayer
	width: Screen.width
	height: Screen.height
	backgroundColor: gallery

# Create our manipulatable shape
editableShape = new Layer
	size: 332
	y: 240
	backgroundColor: clear
	shadowY: 2
	shadowBlur: 6
	shadowColor: shadow
editableShape.centerX()

# Create our first slider track
sliderTrackOne = new Layer
	width: (Screen.width - 60)
	height: 8
	y: 960
	borderRadius: 4
	backgroundColor: grey
sliderTrackOne.centerX()

# Create our first slider handle
sliderHandleOne = new Layer
	size: 44
	borderRadius: 22
	backgroundColor: clear
	shadowY: 2
	shadowBlur: 6
	shadowColor: shadow
	y: -17
	parent: sliderTrackOne

# Enable dragging 
sliderHandleOne.draggable.enabled = true
sliderHandleOne.draggable.vertical = false
sliderHandleOne.draggable.constraints =
 	y: sliderTrackOne.y
 	x: 0
 	width: sliderTrackOne.width
 	height: sliderTrackOne.height
sliderHandleOne.draggable.overdrag = false
sliderHandleOne.draggable.momentum = false

# On move, transition border radius from one value to another
sliderHandleOne.on Events.DragMove, (offset) ->
	
	# Map the dragging distance to a number between 0 and 1 
 	changeRadius = Utils.modulate(offset.x, [0, sliderTrackOne.width], [0,editableShape.width/2], true)
 	# Make the value of our modulate function the value of border radius for our shape
 	editableShape.borderRadius = changeRadius

# Create our second slider track
sliderTrackTwo = new Layer
	width: (Screen.width - 60)
	height: 8
	y: sliderTrackOne.y + 88
	borderRadius: 4
	backgroundColor: grey
sliderTrackTwo.centerX()

# Create our second slider handle
sliderHandleTwo = new Layer
	size: 44
	borderRadius: 22
	backgroundColor: clear
	shadowY: 2
	shadowBlur: 6
	shadowColor: shadow
	y: -17
	parent: sliderTrackTwo

# Enable dragging
sliderHandleTwo.draggable.enabled = true
sliderHandleTwo.draggable.vertical = false
sliderHandleTwo.draggable.constraints =
	y: sliderTrackTwo.y
	x: 0
	width: sliderTrackTwo.width
	height: sliderTrackTwo.height
sliderHandleTwo.draggable.overdrag = false
sliderHandleTwo.draggable.momentum = false

# On move, transition border radius from one value to another
sliderHandleTwo.on Events.Move, (offset) ->
	# Map the dragging distance to a number between 0 and 1 
	fraction = Utils.modulate(offset.x, [0, sliderTrackTwo.width], [0, 1], true)
	# Mix the colors, enable the limit, transition in HUSL
	editableShape.backgroundColor =
		Color.mix(clear, grey, fraction, true, "husl")
	