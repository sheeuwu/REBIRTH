extends MarginContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	for button in $TextureRect.get_children():
		button.connect("pressed", self, "on_Button_pressed", [button.scene_to_load])

func on_TextureButton_pressed(scene_to_load):
	get_tree().change_scene(scene_to_load)



	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


	pass # Replace with function body.
