extends Object
class_name Modifier

class Modifiction:
	var property_name : String
	var value = 0
	func _init(_property_name : String, _value):
		property_name = _property_name
		value = _value

var object : Object

var modifictions := {}
var properties_origin := {}

func _init(_object):
	object = _object

func reset():
	for i in properties_origin:
		object.set(i, properties_origin[i])
	modifictions.clear()
	properties_origin.clear()

func register(_property_name : String, _value) -> Modifiction:
	if !modifictions.has(_property_name):
		modifictions[_property_name] = []
	if !properties_origin.has(_property_name):
		properties_origin[_property_name] = object.get(_property_name)
	var modifiction := Modifiction.new(
		_property_name,
		_value
	)
	modifictions[_property_name].append(modifiction)
	return modifiction
	

func unregister(modifiction : Modifiction):
	if modifictions.has(modifiction.property_name):
		if modifictions[modifiction.property_name].has(modifiction):
			modifictions[modifiction.property_name].erase(modifiction)
		

func activate(modifiction : Modifiction):
	object.set(modifiction.property_name, object.get(modifiction.property_name) + modifiction.value)

func inactivate(modifiction : Modifiction):
	object.set(modifiction.property_name, object.get(modifiction.property_name) - modifiction.value)
