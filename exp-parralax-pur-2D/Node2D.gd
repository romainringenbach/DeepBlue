extends Node2D

func _ready():
    pass

func _draw():

    var pos = get_viewport_rect ( ).size/2 #get center of the screen
    var rect_size = Vector2(80,60) #the size of your rectangle

    #because the rectangle origin is his top-left
    #does some correction to make it centered
    var rect_pos = pos - rect_size/2 

    #create your Rect2
    var rect = Rect2(rect_pos, rect_size )

    #drawn Rect
    draw_rect( rect, Color(1,1,1) )

    #drawn circle (origin is center by default)
    draw_circle( pos, 10, Color(1,1,1,0) )
