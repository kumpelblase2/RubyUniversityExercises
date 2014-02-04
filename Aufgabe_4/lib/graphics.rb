$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

class Object
	def point1d?() false end
	def point2d?() false end
	def shape1d?() false end
	def shape2d?() false end
	def range1d?() false end
	def range2d?() false end
	def union1d?() false end
	def union2d?() false end
	def diff1d?() false end
	def diff2d?() false end
	def shape?() false end
	def point?() false end
	def prim_shape?() false end
	def union_shape?() false end
	def comp_shape?() false end
	def graph_obj?() false end
	def diff_shape?() false end
end

class GraphObj
	def graph_obj?() true end
	def get_dim() 0 end
	def same_dim?(in_obj) (in_obj.graph_obj? ? self.get_dim() == in_obj.get_dim() : false) end
	def self.[](*in_args) check_inv(self.new(*in_args)) end
end

class Point < GraphObj
	def point?() true end
	def include?(in_obj) self == in_obj end
end

class Shape < GraphObj
	def shape?() true end
	def equal_by_trans?(in_obj) self.translate(self.get_translation_to(in_obj)).same_tree?(in_obj) end
end

class Shape1d < Shape
	def shape1d?() true end
	def get_dim() 1 end
	def +(in_obj)
		check_pre((in_obj.shape1d?))
		Union1d[self, in_obj]
	end
	
	def -(in_obj)
		check_pre((in_obj.shape1d?))
		Diff1d[self, in_obj]
	end
end

class Shape2d < Shape
	def shape2d?() true end
	def get_dim() 2 end
	def +(in_obj)
		check_pre((in_obj.shape2d?))
		Union2d[self, in_obj]
	end
	
	def -(in_obj)
		check_pre((in_obj.shape2d?))
		Diff2d[self, in_obj]
	end
end

class Point1d < Point
	def point1d?() true end
	
	def initialize(in_point) @point = in_point end
	def invariant?() self.point.int? end
	def point() @point end
	
	def get_dim() 1 end
	
	def translate(in_point)
		check_pre((in_point.point1d?))
		Point1d[self.point + in_point.point]
	end

	def same_tree?(in_obj)
		in_obj.point1d? and in_obj.point == self.point
	end

	def get_translation_to(in_obj)
		(in_obj.point1d? ? in_obj.point - self.point : nil)
	end
	
	def ==(in_obj)
		self.equal?(in_obj) or (in_obj.point1d? and self.point == in_obj.point)
	end
	
	def to_s()
		"Point1d[#{self.point().to_s}]"
	end
	
	def +(in_obj)
		check_pre((in_obj.point1d?))
		self.translate(in_obj)
	end
	
	def -(in_obj)
		check_pre((in_obj.point1d?))
		self.translate(Point1d[-(in_obj.point)])
	end
end

class Range1d < Shape1d
	def range1d?() true end
	def prim_shape?() true end
	
	def initialize(in_first, in_last)
		@first = in_first
		@last = in_last
	end
	def invariant?() self.first.point1d? and self.last.point1d? end
	def first() @first end
	def last() @last end
	
	def include?(in_point)
		check_pre((in_point.point1d?))
		(self.first.point()..self.last.point()).include?(in_point.point)
	end
	
	def translate(in_point)
		check_pre((in_point.point1d?))
		Range1d[self.first.translate(in_point), self.last.translate(in_point)]
	end
	
	def bounds()
		self
	end
	
	def same_tree?(in_obj)
		in_obj.range1d? and self.first.same_tree?(in_obj.first) and self.last.same_tree?(in_obj.last)
	end
	
	def get_translation_to(in_obj)
		check_pre((in_obj.range1d?))
		in_obj.first - self.first
	end
	
	def equal_by_trans?(in_obj)
		in_obj.range1d? and self.translate(self.get_translation_to(in_obj)).same_tree?(in_obj)
	end
	
	def ==(in_obj)
		self.equal?(in_obj) or (in_obj.range1d? and in_obj.first == self.first and in_obj.last == self.last)
	end
	
	def to_s()
		"Range1d[#{self.first.to_s},#{self.last.to_s}]"
	end
end

class Union1d < Shape1d
	def union1d?() true end
	def union_shape?() true end
	def comp_shape?() true end
	
	def initialize(in_left, in_right)
		@left = in_left
		@right = in_right
	end
	def invariant?() self.left.shape1d? and self.right.shape1d? end
	def left() @left end
	def right() @right end

	def include?(in_point)
		self.left.include?(in_point) or self.right.include?(in_point)
	end
	
	def translate(in_point)
		check_pre((in_point.point1d?))
		Union1d[self.left.translate(in_point), self.right.translate(in_point)]
	end
	
	def same_tree?(in_obj)
		in_obj.union1d? and ((self.left.same_tree?(in_obj.left) and (self.right.same_tree?(in_obj.right))) or ((self.left.same_tree?(in_obj.right)) and (self.right.same_tree?(in_obj.left))))
	end
	
	def bounds()
		bounding_range(self.left.bounds, self.right.bounds)
	end
	
	def get_translation_to(in_obj)
		self.bounds().get_translation_to((in_obj.union_shape? ? in_obj.bounds() : in_obj))
	end
	
	def ==(in_obj)
		self.equal?(in_obj) or (in_obj.union1d? and self.left == in_obj.left and self.right == in_obj.right)
	end
	
	def to_s()
		"Union1d[#{self.left.to_s}, #{self.right.to_s}]"
	end
end

class Point2d < Point
	def point2d?() true end
	
	def initialize(in_x, in_y)
		@x = in_x
		@y = in_y
	end
	def invariant?() self.x.point1d? and self.y.point1d? end
	def x() @x end
	def y() @y end
	
	def get_dim() 2 end
	
	def translate(in_point)
		check_pre((in_point.point2d?))
		Point2d[self.x + in_point.x, self.y + in_point.y]
	end
	
	def same_tree?(in_obj)
		self == in_obj
	end
	
	def get_translation_to(in_obj)
		(in_obj.point2d? ? Point2d[self.x.get_translation_to(in_obj.x), self.y.get_translation_to(in_obj.y)] : nil)
	end
	
	def ==(in_obj)
		self.equal?(in_obj) or (in_obj.point2d? and self.x == in_obj.x and self.y == in_obj.y)
	end
	
	def to_s()
		"Point2d[#{self.x.to_s}, #{self.y.to_s}]"
	end
	
	def +(in_obj)
		check_pre((in_obj.point2d?))
		self.translate(in_obj)
	end
	
	def -(in_obj)
		check_pre((in_obj.point2d?))
		self.translate(Point2d[-(in_obj.x), -(in_obj.y)])
	end
end

class Range2d < Shape2d
	def range2d?() true end
	def prim_shape?() true end
	
	def initialize(in_x_range, in_y_range)
		@x_range = in_x_range
		@y_range = in_y_range
	end
	def invariant?() self.x_range.range1d? and self.y_range.range1d? end
	def x_range() @x_range end
	def y_range() @y_range end
	
	def include?(in_point)
		check_pre((in_point.point2d?))
		self.x_range.include?(in_point.x) and self.y_range.include?(in_point.y)
	end
	
	def translate(in_point)
		check_pre((in_point.point2d?))
		Range2d[self.x_range.translate(in_point.x), self.y_range.translate(in_point.y)]
	end
	
	def bounds()
		self
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
	
	def ==(in_obj)
		self.equal?(in_obj) or (in_obj.range2d? and self.x_range == in_obj.x_range and self.y_range == in_obj.y_range)
	end
	
	def to_s()
		"Range2d[#{self.x_range.to_s},#{self.y_range.to_s}]"
	end
end

class Union2d < Shape2d
	def union2d?() true end
	def union_shape?() true end
	
	def initialize(in_left, in_right)
		@left = in_left
		@right = in_right
	end
	def invariant?() self.left.shape2d? and self.right.shape2d? end
	def left() @left end
	def right() @right end
	
	def include?(in_point)
		self.left.include?(in_point) or self.right.include?(in_point)
	end
	
	def translate(in_point)
		check_pre((self.same_dim?(in_point)))
		Union2d[self.left.translate(in_point), self.right.translate(in_point)]
	end
	
	def bounds()
		bounding_range(self.left.bounds(), self.right.bounds())
	end
	
	def same_tree?(in_obj)
		in_obj.union2d? and ((self.left.same_tree?(in_obj.left) and (self.right.same_tree?(in_obj.right))) or ((self.left.same_tree?(in_obj.right)) and (self.right.same_tree?(in_obj.left))))
	end
	
	def get_translation_to(in_obj)
		self.bounds().get_translation_to((in_obj.union_shape? ? in_obj.bounds() : in_obj))
	end
	
	def equal_by_trans?(in_obj)
		
	end
	
	def ==(in_obj)
		self.equal?(in_obj) or (in_obj.union2d? and self.left == in_obj.left and self.right == in_obj.right)
	end
	
	def to_s()
		"Union2d[#{self.left.to_s}, #{self.right.to_s}]"
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

def equal_by_points?(in_obj1, in_obj2)

end


class Diff1d < Shape1d
	def diif1d?() true end
	def diff_shape?() true end
	
	def initialize(in_main, in_substract)
		@main = in_main
		@substract = in_substract
	end
	
	def invariant?() self.main.shape1d? and self.substract.shape1d? end
	def main() @main end
	def substract() @substract end
	
	def translate(in_point)
		check_pre((in_point.point1d?))
		Diff1d[self.main.translate(in_point), self.substract.translate(in_point)]
	end
	
	def same_tree?(in_obj)
		in_obj.diff1d? and self.main.same_tree?(in_obj.main) and self.substract.same_tree?(in_obj.substract)
	end
	
	def bounds()
		self.main.bounds()
	end
	
	def get_translation_to(in_obj)
		check_pre((in_obj.graph_obj?))
		self.bounds().get_translation_to(in_obj.bounds())
	end
	
	def ==(in_obj)
		self.equal?(in_obj) or (in_obj.diff1d? and self.main == in_obj.main and self.substract == in_obj.substract)
	end
	
	def to_s()
		"Diff1d[#{self.main.to_s}, #{self.substract.to_s}]"
	end
end

class Diff2d < Shape2d
	def diif2d?() true end
	def diff_shape?() true end
	
	def initialize(in_main, in_substract)
		@main = in_main
		@substract = in_substract
	end
	
	def invariant?() self.main.shape2d? and self.substract.shape2d? end
	def main() @main end
	def substract() @substract end
	
	def translate(in_point)
		check_pre((in_point.point2d?))
		Diff2d[self.main.translate(in_point), self.substract.translate(in_point)]
	end
	
	def same_tree?(in_obj)
		in_obj.diff2d? and self.main.same_tree?(in_obj.main) and self.substract.same_tree?(in_obj.substract)
	end
	
	def bounds()
		self.main.bounds()
	end
	
	def get_translation_to(in_obj)
		check_pre((in_obj.graph_obj?))
		self.bounds().get_translation_to(in_obj.bounds())
	end
	
	def ==(in_obj)
		self.equal?(in_obj) or (in_obj.diff2d? and self.main == in_obj.main and self.substract == in_obj.substract)
	end
	
	def to_s()
		"Diff2d[#{self.main.to_s}, #{self.substract.to_s}]"
	end
end