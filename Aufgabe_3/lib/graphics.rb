$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

def point1d?(in_point)
	in_point.int?
end

def_class(:Range1d, [:first, :last]){
	def invariant?()
		point1d?(self.first) and point1d?(self.last)
	end
}

def_class(:Union1d, [:first, :last]){
	def invariant?()
		shape1d?(self.left) and shape1d?(self.right)
	end
}

def shape1d?(in_shape)
	in_shape.range1d? or in_shape.union1d?
end

def_class(:Point2d, [:x, :y]){
	def invariant?()
		point1d(self.x) and point1d?(self.y)
	end
}

def_class(:Range2d, [:x_range, :y_range]){
	def invariant?()
		self.x_range.range1d? and self.y_range.range1d?
	end
}

def_class(:Union2d, [:left, :right]){
	def invariant?()
		shape2d(self.left) and shape2d?(self.right)
	end
}

def shape2d?(in_shape)
	in_shape.range2d? or in_shape.union2d?
end

def point?(in_point)
	point1d?(in_point) or in_point.point2d?
end

def prim_shape?(in_prim_shape)
	in_prim_shape.range1d? or in_prim_shape.range2d?
end

def union_shape?(in_union)
	in_union.union1d? or in_union.union2d?
end

def comp_shape?(in_comp)
	union_shape?(in_comp)
end

def shape?(in_shape)
	union_shape?(in_shape) or prim_shape?(in_shape)
end

def graph_obj?(in_object)
	shape?(in_object) or point?(in_object)
end

def shape_include?(in_shape, in_point)
	check_pre(((point?(in_point)) and (shape?(in_shape))))
	# (shape1d?(in_shape) ? shape1d_include?(in_shape, in_point) : shape2d_include?(in_shape, in_point))
	#(union_shape?(in_shape) ? union_include?(in_shape, in_point) : (shape1d?(in_shape) ? shape1d_include(in_shape, in_point) : shape2d_include?(in_shape, in_point)))
	#(shape1d?(in_shape) ? shape1d_include?(in_shape, in_point) : shape2d_include?(in_shape, in_point))
	(union_shape?(in_shape) ? union_include?(in_shape, in_point) : (shape1d?(in_shape) ? shape1d_include?(in_shape, in_point) : shape2d_include?(in_shape, in_point)))
end

def union_include?(in_union, in_point)
	shape_include?(in_union.left, in_point) or shape_include?(in_union.right, in_point)
end

def union1d_include?(in_union, in_point)
	shape1d_include?(in_union.left, in_point) or shape1d_include?(in_union.right, in_point)
end

def union2d_include?(in_union, in_point)
	shape2d_include?(in_union.left, in_point) or shape2d_include?(in_union.right, in_point)
end

def shape1d_include?(in_shape, in_point)
	check_pre((shape1d?(in_shape) and point1d?(in_point)))
	#(in_shape.range1d? ? range1d_include?(in_shape, in_point) : point1d_include?(in_shape, in_point))
	(in_shape.union1d? ? union1d_include?(in_shape, in_point) : range1d_include?(in_shape, in_point))
end

def shape2d_include?(in_shape, in_point)
	(in_shape.union2d? ? union2d_include?(in_shape, in_point) : range2d_include?(in_shape, in_point))
end

def point1d_include?(in_point1, in_point2)
	in_point1 == in_point2
end

def range1d_include?(in_range, in_point)
	#(in_range.first..in_range.last).include?(in_point.point)
	in_point.point.in?(in_range.first..in_range.last)
end

def point2d_include?(in_point1, in_point2)
	(in_point1.x == in_point2.x) and (in_point1.y == in_point2.y)
end

def range2d_include?(in_range, in_point)
	range1d_include?(in_range.x_range, in_point.x) and range1d_include?(in_range.y_range, in_point.y)
end

def translate(in_shape, in_point)
	check_pre(((shape?(in_shape)) and (point?(in_point))))
	(shape1d?(in_shape) ? translate1d(in_shape, in_point) : translate2d(in_shape, in_point))
end

def translate1d(in_shape, in_point)
	check_pre((shape1d?(in_shape) and point1d?(in_point)))
	(union_shape?(in_shape) ? Union1d[translate1d(in_shape.left, in_point), translate1d(in_shape.right, in_point)] : translate_range1d(in_shape, in_point))
end

def translate_range1d(in_range, in_point)
	Range1d[translate_point(in_range.first, in_point), translate_point(in_range.last, in_point)]
end

def translate_point(in_point, in_point_trans)
	Point1d[in_point + in_point_trans]
end

def translate2d(in_shape, in_point)
	check_pre(((shape2d?(in_shape)) and (in_point.point2d?)))
	(union_shape?(in_shape) ? Union2d[translate2d(in_shape.left, in_point), translate2d(in_shape.right, in_point)] : translate_shape2d(in_shape, in_point))
end

def translate_range2d(in_range, in_point)
	Range2d[translate_range1d(in_range.x_range, in_point.x), translate_range1d(in_range.y_range, in_point.y)]
end

def bounds(in_shape)
	check_pre((shape?(in_shape)))
	(shape1d?(in_shape) ? bounds1d(in_shape) : bounds2d(in_shape))
end

def bounds1d(in_shape)
	in_shape.range1d? ? in_shape : bounding_range(bounds1d(in_shape.left), bounds1d(in_shape.right))
end

def combine_range(in_range1, in_range2)
	smallest(in_range1.begin, in_range2.begin)..biggest(in_range1.end, in_range2.end)
end

def biggest(in_first, in_second)
	(in_first > in_second ? in_first : in_second)
end

def smallest(in_first, in_second)
	(in_first < in_second ? in_first : in_second)
end

def bounds2d(in_shape)
	in_shape.range2d? ? in_shape : bounding_range(bounds2d(in_shape.left), bounds2d(in_shape.right))
end

def combine_range2d(in_range, in_range2)
	Range2d[combine_range(in_range.x_range, in_range2.x_range), combine_range(in_range.y_range, in_range2.y_range)]
end

def bounding_range(in_range, in_range2)
	in_range.range2d? ? combine_range2d(in_range, in_range2) : combine_range(in_range, in_range2)
end

def equal_by_dim?(in_obj, in_obj2)
	get_dim(in_obj) == in_obj2
end

def get_dim(in_obj)
	((shape1d?(in_obj) or point1d?(in_obj)) ? 1 : 2)
end

def equal_by_tree?(in_obj1, in_obj2)
	(equal_by_dim?(in_obj1, in_obj2) ? equal(in_obj1, in_obj2) : false)
end

def equal(in_obj1, in_obj2)
	if union_shape?(in_obj1) then
		(union_shape?(in_obj2) and equal(in_obj1.left, in_obj2.left) and equal(in_obj1.right, in_obj2.right))
	else
		((not union_shape?(in_obj2)) and ((point?(in_obj1) and point?(in_obj1)) or (prim_shape?(in_obj1) and prim_shape?(in_obj2))))
	end
end

def equal_by_trans?(in_obj1, in_obj2)
	equal_by_tree?(in_obj1, in_obj2) and get_trans(in_obj1, in_obj2) != nil
end

def get_trans(in_obj1, in_obj2)
	(shape1d?(in_obj1) ? get_trans1d(in_obj1, in_obj2) : get_trans2d(in_obj1, in_obj2))
end

def get_trans1d(in_obj1, in_obj2)
	
end

def get_trans2d(in_obj1, in_obj2)
	
end

def are_multiple?(in_range1, in_range2)
	if shape1d?(in_range1) then
		get_trans_num(in_range1, in_range2) != nil
	else
		(are_multiple?(in_range1.x_range, in_range2.x_range) and are_multiple?(in_range1.y_range, in_range2.y_range))
	end
end

def get_trans_num(in_range1, in_range2)
	first = in_range1.first / in_range2.first
	second = in_range1.last / in_range2.last
	(first == second ? first : nil)
end