extends Control

@onready var lable:Label = $MarginContainer/Label

# its like a append function but for a string you can add more functonalities here for more complex
# animations. Example in  Game_Objects/Interactive/template.gd
func delay(sec:float) -> void:
	await get_tree().create_timer(sec).timeout

func animation1(text:String,sec:float) -> void:
	for x in text:
		await delay(sec)
		lable.text += x

func dialog( text:String ) -> void:
	lable.text += text

# Just clear the text box and reuse it for new text.
func clear() -> void:
	lable.text = ""
