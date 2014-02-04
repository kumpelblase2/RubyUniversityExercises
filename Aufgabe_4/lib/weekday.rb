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
  def day_sym?() false end
  def day_num?() false end
end

def Day
  def self.[](*args) check_inv(self.new(*args)) end
  def day?() true end
  def to_representation(in_representation) (in_representation.day_num? ? self.to_day_num() : self.to_day_sym()) end
  def +(in_amount)
	  check_pre((in_amount.int?))
	  self.shift(in_amount)
  end
  
  def -(in_amount)
	  check_pre((in_amount.int?))
	  self.shift(-in_amount)
  end
end

class DaySym
  def initialize(in_sym) @sym = in_sym end
  def invariant?() DAYSYM.include?(self.sym) end
  
  def day_sym?() true end
  def sym() @sym end
  def to_day_num() DayNum[to_external(DAYSYM.index(self.sym))] end
  def to_day_sym() self end
  def succ() self.shift(1) end
  def pred() self.shift(-1) end
  def shift(in_shift)
	self.to_day_num().shift(in_shift).to_day_sym()
  end
  
  def ==(in_obj)
    self.equal?(in_obj) or (in_obj.day_sym? and in_obj.sym == self.sym)
  end
  
  def to_s() "DaySym[#{self.sym.to_s}]" end
end

class DayNum
  def initialize(in_num) @num = in_num end
  def invariant?() self.num.in?(DAYNUM) end
  
  def day_num?() true end
  def num() @num end
  def to_day_num() self end
  def to_day_sym() DaySym[DAYSY[to_internal(self.num())]] end
  def succ() self.shift(1) end
  def pred() self.shift(-1) end
  def shift(in_shift)
    check_pre((in_shift.int?))
    DayNum[to_external((to_internal(self.to_num()) + in_shift) % WEEK_END)]
  end

  def ==(in_obj)
	self.equal?(in_obj) or (in_obj.day_num? and in_obj.num == self.num)
  end
  
  def to_s() "DayNum[#{self.num.to_s}]" end
end

def to_internal(in_index)
  in_index - 1
end

def to_external(in_index)
  in_index + 1
end
