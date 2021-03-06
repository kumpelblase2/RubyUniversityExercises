$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
#require "ext_lists_v2"

# Checks if the given object is a point
# Any -> Bool
def point1d?(in_point)
	in_point.int?
end

def_class(:Range1d, [:first, :last]){
	def invariant?()
		point1d?(self.first) and point1d?(self.last)
	end
}

def_class(:Union1d, [:left, :right]){
	def invariant?()
		shape1d?(self.left) and shape1d?(self.right)
	end
}

# Checks if the given object is a 1 dimensional shape
# Any -> Boolean
def shape1d?(in_shape)
	in_shape.range1d? or in_shape.union1d?
end

def_class(:Point2d, [:x, :y]){
	def invariant?()
		point1d?(self.x) and point1d?(self.y)
	end
}

def_class(:Range2d, [:x_range, :y_range]){
	def invariant?()
		self.x_range.range1d? and self.y_range.range1d?
	end
}

def_class(:Union2d, [:left, :right]){
	def invariant?()
		shape2d?(self.left) and shape2d?(self.right)
	end
}

# Checks if the object is a 2 dimensional shape
# Any -> Boolean
def shape2d?(in_shape)
	in_shape.range2d? or in_shape.union2d?
end

# Checks if the object is a point (either 1 or 2 dimensional)
# Any -> Boolean
def point?(in_point)
	point1d?(in_point) or in_point.point2d?
end

# Checks if the object is a primitive shape
# Any -> Boolean
def prim_shape?(in_prim_shape)
	in_prim_shape.range1d? or in_prim_shape.range2d?
end

# Checks if the object is a union
# Any -> Boolean
def union_shape?(in_union)
	in_union.union1d? or in_union.union2d?
end

# Checks if the object is a comp shape
# Any -> Boolean
def comp_shape?(in_comp)
	union_shape?(in_comp)
end

# Checks if the object is a shape of any kind
# Any -> Boolean
def shape?(in_shape)
	union_shape?(in_shape) or prim_shape?(in_shape)
end

# Checks if the object is a graphical object
# Any -> Boolean
def graph_obj?(in_object)
	shape?(in_object) or point?(in_object)
end

# Checks if the shape includes the given point.
# shape_include ::= (in_shape, in_point) :: Shape x Point -> Boolean
def shape_include?(in_shape, in_point)
	check_pre(((point?(in_point)) and (shape?(in_shape))))
	if union_shape?(in_shape) then shape_include?(in_shape.left, in_point) or shape_include?(in_shape.right, in_point)
	elsif in_shape.range1d? then range1d_include?(in_shape, in_point)
	elsif in_shape.range2d? then shape_include?(in_shape.x_range, in_point.x) and shape_include?(in_shape.y_range, in_point.y)
	elsif check_pre(false)
	end
end

def range1d_include?(in_range, in_point)
	(in_range.first..in_range.last).include?(in_point)
end

# Translates the shape by a given point
# translate ::= (in_shape, in_point) :: Shape x Point -> Shape
def translate(in_shape, in_point)
	check_pre(((shape?(in_shape)) and (point?(in_point))))
	if    in_shape.union1d? then Union1d[translate(in_shape.left, in_point), translate(in_shape.right, in_point)]
	elsif in_shape.union2d? then Union2d[translate(in_shape.left, in_point), translate(in_shape.right, in_point)]
	elsif in_shape.range2d? then Range2d[translate(in_shape.x_range, in_point.x), translate(in_shape.y_range, in_point.y)]
  elsif in_shape.range1d? then Range1d[translate_point(in_shape.first, in_point), translate_point(in_shape.last, in_point)]
  else check_pre false
  end
end

def translate_point(in_point, in_point_trans)
	in_point + in_point_trans
end

# Gets the bounds of the given shape
# bounds ::= (in_shape) :: Shape -> Range1d | Range2d
def bounds(in_shape)
	check_pre((shape?(in_shape)))
	if (in_shape.range1d? or in_shape.range2d?) then in_shape
	elsif (in_shape.union1d? or in_shape.union2d?) then bounding_range(bounds(in_shape.left), bounds(in_shape.right))
	else check_pre(false)
	end
end

def combine_range(in_range1, in_range2)
	Range1d[smallest(in_range1.first, in_range2.first), biggest(in_range1.last, in_range2.last)]
end

def biggest(in_first, in_second)
	(in_first > in_second ? in_first : in_second)
end

def smallest(in_first, in_second)
	(in_first < in_second ? in_first : in_second)
end

def combine_range2d(in_range, in_range2)
	Range2d[combine_range(in_range.x_range, in_range2.x_range), combine_range(in_range.y_range, in_range2.y_range)]
end

# Gets the smallest range which contains both given ranges
# bounding_range ::= (in_range, in_range2) :: (Range1d x Range1d -> Range1d) | (Range2d x Range2d -> Range2d) 
def bounding_range(in_range, in_range2)
	in_range.range2d? ? combine_range2d(in_range, in_range2) : combine_range(in_range, in_range2)
end

# Checks if the given objects are in the same dimension
# equal_by_dim ::= (in_obj, in_obj2) :: GraphObj x GraphObj -> Boolean
def equal_by_dim?(in_obj, in_obj2)
	check_pre((graph_obj?(in_obj) and graph_obj?(in_obj2)))
	get_dim(in_obj) == get_dim(in_obj2)
end

def get_dim(in_obj)
	((shape1d?(in_obj) or point1d?(in_obj)) ? 1 : 2)
end

# Checks if the given graph objects are equal in their tree
# equal_by_tree ::= (in_obj1, in_obj2) :: GraphObj x GraphObj -> Boolean
def equal_by_tree?(in_obj1, in_obj2)
	check_pre((equal_by_dim?(in_obj1, in_obj2)))
	if union_shape?(in_obj1) then (union_shape?(in_obj2) and equal_union?(in_obj1, in_obj2))
	elsif in_obj1.range1d? then (in_obj2.range1d? and equal_range?(in_obj1, in_obj2))
	elsif in_obj1.range2d? then (in_obj2.range2d? and equal_by_tree?(in_obj1.x_range, in_obj2.x_range) and equal_by_tree?(in_obj1.y_range, in_obj2.y_range))
	else false
	end
end

def equal_union?(in_obj1, in_obj2)
	((equal_by_tree?(in_obj1.left, in_obj2.left) and equal_by_tree?(in_obj1.right, in_obj2.right)) or (equal_by_tree?(in_obj1.left, in_obj2.right) and equal_by_tree?(in_obj1.right, in_obj2.left)))
end

def equal_range?(in_range1, in_range2)
	(in_range1.first == in_range2.first) and (in_range1.last == in_range2.last)
end

# Checks if the first object can be translated that both objects are equal in their tree
# equal_by_trans ::= (in_obj1, in_obj2) :: GraphObj x GraphObj -> Boolean
def equal_by_trans?(in_obj1, in_obj2)
  if not equal_by_dim?(in_obj1, in_obj2) then false
  elsif point?(in_obj1) or point?(in_obj2) then point?(in_obj1) and point?(in_obj2)
  elsif shape?(in_obj1) and shape?(in_obj2) then equal_by_tree?(translate(in_obj1, get_tralsation(bounds(in_obj1), bounds(in_obj2))), in_obj2)
  else false
  end
end

def get_translation(in_shape1, in_shape2)
  if in_shape1.range1d? and in_shape2.range1d? then in_shape2.first - in_shape1.first
  elsif in_shape1.range2d? and in_shape2.range2d? then Point2d[get_translation(in_shape1.x_range, in_shape2.x_range), get_translation(in_shape1.ym_range, in_shape2.y_range)]
  else check_pre(false)
  end
end

def equal_by_points?(in_obj1, in_obj2)

end