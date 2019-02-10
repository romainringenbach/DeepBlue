tool

extends MeshInstance

export (float) var frequency = 5 setget update_frequency
export (float, -10.0, 10.0) var z_torsion_frequency = -5 setget update_z_torsion_frequency
export (float, -20, 20) var z_wave_frequency = 5 setget update_z_wave_frequency

export (float, -5, 5) var translations_x = 0 setget update_translation_x
export (float, -5, 5) var translations_y = 0 setget update_translation_y
export (float, -5, 5) var translations_z = 0 setget update_translation_z

export (float, -1.0, 1.0) var yaw = 0 setget update_yaw
export (float, -1.0, 1.0) var pitch = 0 setget update_pitch
export (float, -1.0, 1.0) var roll = 0 setget update_roll

export (float, -1.0, 1.0) var z_torsion = 0 setget update_z_torsion
export (float, -1.0, 1.0) var z_wave = 0 setget update_z_wave

var translations = Vector3()
var nMaterials = 0

func update_yaw( v ):
	yaw = v
	update_shader()
	
func update_pitch( v ):
	pitch = v
	update_shader()

func update_roll( v ):
	roll = v
	update_shader()

func update_z_wave_frequency( v ):
	z_wave_frequency = v
	update_shader()

func update_z_wave( v ):
	z_wave = v
	update_shader()

func update_z_torsion_frequency( v ):
	z_torsion_frequency = v
	update_shader()

func update_z_torsion( v ):
	z_torsion = v
	update_shader()
	
func update_frequency( v ):
	frequency = v
	update_shader()

func update_translation_x( v ):
	update_translations( Vector3( v, translations.y, translations.z ) )
	
func update_translation_y( v ):
	update_translations( Vector3( translations.x, v, translations.z ) )
	
func update_translation_z( v ):
	update_translations( Vector3( translations.x, translations.y, v ) )

func update_translations( v ):
	translations = v;
	translations_x = translations.x
	translations_y = translations.y
	translations_z = translations.z
	update_shader()

func update_shader():
	for i in range(nMaterials):
		get_surface_material(i).set_shader_param( "frequency", frequency )
		get_surface_material(i).set_shader_param( "translations", translations )
		get_surface_material(i).set_shader_param( "yaw_value", yaw )
		get_surface_material(i).set_shader_param( "pitch_value", pitch )
		get_surface_material(i).set_shader_param( "roll_value", roll )
		get_surface_material(i).set_shader_param( "z_torsion_value", z_torsion )
		get_surface_material(i).set_shader_param( "z_torsion_frequency", z_torsion_frequency )
		get_surface_material(i).set_shader_param( "z_wave_value", z_wave )
		get_surface_material(i).set_shader_param( "z_wave_frequency", z_wave_frequency )

func _ready():
	nMaterials = self.mesh.get_surface_count()
	update_shader()
	set_process(true)