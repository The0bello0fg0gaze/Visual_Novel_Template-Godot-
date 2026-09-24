extends Area2D

@onready var tag:Label = $Label
@onready var Dialogbox:Control = get_tree().get_first_node_in_group("DialogBox")
var conv1:String = "Hello this is a test to the game that i am building the slow animation text is: "

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(delta: float) -> void:
	if tag.visible and Input.is_action_just_pressed("ui_accept"):
		DataManager.movement = !DataManager.movement
		Dialogbox.visible = !Dialogbox.visible
		render_dialog_box()

# Here is a good example for how we can use movement from the global script to check for other 
# stuff
func render_dialog_box() -> void:
	if DataManager.movement:
		return
		
	tag.visible = false
	
	if Dialogbox.has_method("clear") and Dialogbox.has_method("dialog"):
		Dialogbox.clear()
		for x in conv1.split(" ",false):
			await delay_text(x)
		await Dialogbox.animation1(" Test ",0.1)
		Dialogbox.animation1("1 2 3",0.2)
		
	tag.visible = true	
	
# if there is a more cleaner option to add delay pleas do add
func delay_text(text:String) -> void:
	Dialogbox.dialog(text)
	Dialogbox.dialog(" ")
	await get_tree().create_timer(0.2).timeout


#This is only activated when the player enters or exits the Area 2D around the object.

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		tag.visible = true

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group('Player'):
		tag.visible = false
