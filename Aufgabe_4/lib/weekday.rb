$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

# Definition for the first week day as number
WEEK_START = 1

# Definition for the last week day as number
WEEK_END = 7

# Definition for all valid day numbers
DAYNUM = (WEEK_START..WEEK_END).to_a

# Definition for all valid day symbols
DAYSYM = [ :Mo, :Di, :Mi, :Do, :Fr, :Sa, :So ]

class Object
  def day?() false end
  def day_num?() false end
  def day_sym?() false end
end

class Day
  def day?() true end
  def succ() self.shift(1) end
  def pred() self.shift(-1) end
  def to_representation(in_representation) 
	  check_pre((in_representation.day?))
	  (in_representation.day_num? ? self.to_day_num() : self.to_day_sym())
  end
  
  def self.[](*in_args) check_inv(self.new(*in_args)) end
end

class DaySym < Day
  def initialize(in_sym) @sym = in_sym end
  def invariant?() self.sym.in?(DAYSYM) end
  def sym() @sym end
  
  def to_s()
	  "DaySym[#{@sym}]"
  end
  
  def ==(in_obj)
	  self.equal?(in_obj) or (in_obj.day_sym? and in_obj.sym == self.sym)
  end
	
  def day_sym?() true end
  def to_num() to_external(DAYSYM.index(self.to_sym())) end
  def to_sym() self.sym end
  def to_day_num() DayNum[self.to_num()] end
  def to_day_sym() self end
  def shift(in_shift) to_day_num().shift(in_shift).to_day_sym() end
end

class DayNum < Day
  def initialize(in_num) @num = in_num end
  def invariant?() self.num.in?(DAYNUM) end
  def num() @num end
  
  def to_s()
	  "DayNum[#{@num}]"
  end
  
  def ==(in_obj)
	  self.equal?(in_obj) or (in_obj.day_num? and self.num == in_obj.num)
  end
	
  def day_num?() true end
  def to_num() self.num end
  def to_sym() DAYSYM[to_internal(self.to_num())] end
  def to_day_num() self end
  def to_day_sym() DaySym[self.to_sym()] end
  def shift(in_shift) DayNum[to_external((to_internal(self.to_num()) + in_shift) % WEEK_END)] end
end

def to_internal(in_index)
  in_index - 1
end

def to_external(in_index)
  in_index + 1
end