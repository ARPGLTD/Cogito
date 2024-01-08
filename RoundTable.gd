extends Carriable

@onready var mesh: MeshInstance3D = $Props_Table_Circle_1
@onready var colliders: Array[CollisionShape3D] = [$CollisionShape3D, $CollisionShape3D2, $CollisionShape3D3]

func disable_collisions():
	for c in colliders:
		c.set_disabled(true)

func enable_collisions():
	for c in colliders:
		c.set_disabled(false)
