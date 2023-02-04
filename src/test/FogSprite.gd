extends Sprite2D

var fog_image = Image.create(1024, 1024, false, Image.FORMAT_R8)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. '_delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func update_image():
	self.texture = ImageTexture.create_from_image(fog_image)
