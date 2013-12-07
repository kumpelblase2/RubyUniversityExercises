$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

class Object
	def shape1d?() false end
	def shape2d?() false end
	def shape?() self.comp_shape?() or self.prim_shape?() end
	def point?() self.point1d?() or self.point2d?() end
	def prim_shape?() false end
	def union_shape?()  end
	def comp_shape?() self.union_shape?() end
	def graph_obj?() self.shape?() or self.point?() end
end

class Integer
	def point1d?() true end
	
	def same_dim?(in_obj)
		in_obj.shape1d? or in_obj.point1d?
	end
	
	def translate(in_point)
		self + in_point
	end
	
	def same_tree?(in_obj)
		in_obj.point1d? and in_obj == self
	end
	
	def get_translation_to(in_obj)
		(in_obj.point1d? ? in_obj - self : nil)
	end
end

def_class(:Range1d, [:first, :last]){
	def invariant?()
		point1d?(self.first) and point1d?(self.last)
	end
}

class Range1d
	def shape1d?() true end
	def prim_shape?() true end
	
	def include?(in_point)
		check_pre((in_point.point1d?))
		(self.first..self.last).include?(in_point)
	end
	
	def translate(in_point)
		check_pre((in_point.point1d?))
		Range1d[self.first.translate(in_point), self.last.translate(in_point)]
	end
	
	def same_dim?(in_obj)
		in_obj.shape1d? or in_obj.point1d?
	end
	
	def bounds()
		
	end
	
	def bounding_range()
		
	end
	
	def same_tree?(in_obj)
		in_obj.range1d? and self.first.same_tree?(in_obj.first) and self.last.same_tree?(in_obj.last)
	end
	
	def get_translation_to(in_obj)
		check_pre((in_obj.range1d?))
		first = in_obj.first - self.first
		last = in_obj.last - self.last
		(first == last ? first : nil)
	end
end

def_class(:Union1d, [:left, :right]){
	def invariant?()
		shape1d?(self.left) and shape1d?(self.right)
	end
}

class Union1d
	def shape1d?() true end
	def union_shape?() true end
	
	def include?(in_point)
		self.left.include?(in_point) or self.right.include?(in_point)
	end
	
	def translate(in_point)
		check_pre((self.same_dim?(in_point)))
		Union1d[self.left.translate(in_point), self.right.translate(in_point)]
	end
	
	def same_dim?(in_obj)
		in_obj.shape1d? or in_obj.point1d?
	end
	
	def same_tree?(in_obj)
		in_obj.union1d? and ((self.left.same_tree?(in_obj.left) and (self.right.same_tree?(in_obj.right))) or ((self.left.same_tree?(in_obj.right)) and (self.right.same_tree?(in_obj.left))))
	end
	
	def bounds()
		
	end
	
	def bounding_range()
		
	end
	
	def get_translation_to(in_obj)
		self.bounds().get_translation_to((in_obj.union_shape? ? in_obj.bounds() : in_obj))
	end
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

class Range2d
	def shape2d?() true end
	def prim_shape?() true end
	
	def include?(in_point)
		check_pre((in_point.point2d?))
		self.x_range.include?(in_point.x) and self.y_range.include?(in_point.y)
	end
	
	def translate(in_point)
		check_pre((in_point.point2d?))
		Range2d[self.x_range.translate(in_point.x), self.y_range.translate(in_point.y)]
	end
	
	def same_dim?(in_obj)
		in_obj.shape2d? or in_obj.point2d?
	end
	
	def bounds()
		
	end
	
	def bounding_range()
		
	end
	
	def same_tree?(in_obj)
		in_obj.range2d? and self.x_range.same_tree?(in_obj.x_range) and self.y_range.same_tree?(in_obj.y_range)
	end
	
	def get_translation_to(in_obj)
		if not in_obj.range2d? then
			return nil
		end
		
		x_point = self.x_range.get_translation_to(in_obj.x_range)
		y_point = self.y_range.get_translation_to(in_obj.y_range)
		(x_point != nil and y_point != nil ? Point2d[x_point, y_point] : nil )
	end
end

def_class(:Union2d, [:left, :right]){
	def invariant?()
		shape2d?(self.left) and shape2d?(self.right)
	end
}

class Union2d
	def shape2d?() true end
	def union_shape?() true end
	
	def include?(in_point)
		self.left.include?(in_point) or self.right.include?(in_point)
	end
	
	def translate(in_point)
		check_pre((self.same_dim?(in_point)))
		Union2d[self.left.translate(in_point), self.right.translate(in_point)]
	end
	
	def same_dim?(in_obj)
		in_obj.shape2d? or in_obj.point2d?
	end
	
	def bounds()
		
	end
	
	def bounding_range()
		
	end
	
	def same_tree?(in_obj)
		in_obj.union2d? and ((self.left.same_tree?(in_obj.left) and (self.right.same_tree?(in_obj.right))) or ((self.left.same_tree?(in_obj.right)) and (self.right.same_tree?(in_obj.left))))
	end
	
	def get_translation_to(in_obj)
		self.bounds().get_translation_to((in_obj.union_shape? ? in_obj.bounds() : in_obj))
	end
end

#def shape_include?(in_shape, in_point)
#	check_pre(((point?(in_point)) and (shape?(in_shape))))
#	if union_shape?(in_shape) then shape_include?(in_shape.left, in_point) or shape_include?(in_shape.right, in_point)
#  elsif in_shape.range1d? then range1d_include?(in_shape, in_point)
#  elsif in_shape.range2d? then shape_include?(in_shape.x_range, in_point.x) and shape_include?(in_shape.y_range, in_point.y)
#  elsif check_pre(false)
#  end
#end

#def range1d_include?(in_range, in_point)
#	(in_range.first..in_range.last).include?(in_point)
#end

#def translate(in_shape, in_point)
#	check_pre(((shape?(in_shape)) and (point?(in_point))))
#  if in_shape.union1d? then Union1d[translate(in_shape.left, in_point), translate(in_shape.right, in_point)]
#  elsif in_shape.union2d? then Union2d[translate(in_shape.left, in_point), translate(in_shape.right, in_point)]
#  elsif in_shape.range2d? then Range2d[translate(in_shape.x_range, in_point.x), translate(in_shape.y_range, in_point.y)]
#  else Range1d[translate_point(in_shape.first, in_point), translate_point(in_shape.last, in_point)]
#  end
#end
#
#def translate_point(in_point, in_point_trans)
#	in_point + in_point_trans
#end

def bounds(in_shape)
	check_pre((shape?(in_shape)))
  if (in_shape.range1d? or in_shape.range2d?) then in_shape
  elsif (in_shape.union1d? or in_shape.union2d?) then bounding_range(bounds(in_shape.left), bounds(in_shape.right))
  else check_pre(false)
  end
end

def combine_range(in_range1, in_range2)
	Range1d[smallest(in_range1.first, in_range2.first),biggest(in_range1.last, in_range2.last)]
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

def bounding_range(in_range, in_range2)
	in_range.range2d? ? combine_range2d(in_range, in_range2) : combine_range(in_range, in_range2)
end

#def equal_by_dim?(in_obj, in_obj2)
#  check_pre((graph_obj?(in_obj) and graph_obj?(in_obj2)))
#	get_dim(in_obj) == get_dim(in_obj2)
#end
#
#def get_dim(in_obj)
#	((shape1d?(in_obj) or point1d?(in_obj)) ? 1 : 2)
#end

#def equal_by_tree?(in_obj1, in_obj2)
#  check_pre((equal_by_dim?(in_obj1, in_obj2)))
#  if union_shape?(in_obj1) then (union_shape?(in_obj2) and equal_union?(in_obj1, in_obj2))
#  elsif in_obj1.range1d? then (in_obj2.range1d? and equal_range?(in_obj1, in_obj2))
#  elsif in_obj1.range2d? then (in_obj2.range2d? and equal_by_tree?(in_obj1.x_range, in_obj2.x_range) and equal_by_tree?(in_obj1.y_range, in_obj2.y_range))
#  else false
#  end
#end
#
#def equal_union?(in_obj1, in_obj2)
#  ((equal_by_tree?(in_obj1.left, in_obj2.left) and equal_by_tree?(in_obj1.right, in_obj2.right)) or (equal_by_tree?(in_obj1.left, in_obj2.right) and equal_by_tree?(in_obj1.right, in_obj2.left)))
#end
#
#def equal_range?(in_range1, in_range2)
#  (in_range1.first == in_range2.first) and (in_range1.last == in_range2.last)
#end

def equal_by_trans?(in_obj1, in_obj2)
  check_pre((equal_by_dim?(in_obj1, in_obj2)))
  translation = get_translation_point(bounds(in_obj1), bounds(in_obj2))
  if translation == nil then false
  else equal_by_points?(translate(in_obj1, translation), in_obj2)
  end
end

def get_translation_point(in_range1, in_range2)
  if in_range1.range1d? then get_trans_num(in_range1, in_range2)
  elsif in_range1.range2d? then
    x = get_translation_point(in_range1.x_range, in_range2.x_range)
    y = get_translation_point(in_range1.y_range, in_range2.y_range)
    if x == nil or y == nil then nil
    else Point2d[x, y]
    end
  else check_pre(false)
  end
end

def get_trans_num(in_range1, in_range2)
	first = in_range1.first - in_range2.first
	second = in_range1.last - in_range2.last
	(first == second ? first : nil)
end

def equal_by_points?(in_obj1, in_obj2)

end