extends Node

var current_level:String = "res://Level/Test.tscn"
var main_menu:String = "res://Main_Menu/Main_Menu.tscn"
# You can use this function to make the movement stop of the character throught the game this can
# also help during animations or pausing the game.
var movement:bool = true 
var inventory:Dictionary = {}

func reset() -> void:
	movement = true
	inventory = {}
