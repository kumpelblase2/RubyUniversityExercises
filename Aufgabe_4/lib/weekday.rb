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
DAYNUM = WEEK_START..WEEK_END

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
  def shift(in_shift) self.to_day_num().shift(in_shift).to_day_sym() end
  
    
  def ==(in_obj)
    in_obj.day_sym? and in_obj.sym == self.sym
  end
  
  def +(in_shift)
    self.shift(in_shift)
  end
  
  def -(in_shift)
    check_pre((in_shift.int?))
    self.shift(-in_shift)
  end
  
  def to_s() "DaySym[#{self.sym}]" end
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
    in_obj.day_num? and in_obj.num == self.num
  end
  
  def +(in_shift)
    self.shift(in_shift)
  end
  
  def -(in_shift)
    check_pre((in_shift.int?))
    self.shift(-in_shift)
  end
  
  def to_s() "DayNum[#{self.num}]" end
end

# Checks if the given input is representing a valid day, either number or symbol
# Any -> Bool
# Test (DaySym[:Mo]) => true, (DayNum[1]) => true
#def day?(in_day)
#  in_day.day_num? or in_day.day_sym?
#end

# Converts the given day number into the representing symbol
# DayNum -> DaySym
# Test (DaySym[:Mo]) => Err, (DayNum[1]) => DaySym[:Mo]
#def day_num_to_day_sym(in_number)
#  check_pre((in_number.day_num?))
#  DaySym[DAYSYM[to_internal(in_number.num)]]
#end

# Converts the given day symbol into the representing number
# DaySym -> DayNum
# Tests (:Mo) => 1, (:So) => 7, (:we) => Err, (1) => Err
# (DaySym[:Mo]) => DayNum[1], (DayNum[1]) => Err
#def day_sym_to_day_num(in_symbol)
#  check_pre((in_symbol.day_sym?))
#  DayNum[to_external(DAYSYM.index(in_symbol.sym))]
#end

# Converts the given day input into the corresponding day symbol
# DayNum|DaySym -> DaySym
# Tests (:Mo) => :Mo, (1) => :Mo, (7) => :So, (:So) => :So
# (DaySym[:Mo]) => DaySym[:Mo], (DayNum[1]) => DaySyn[:Mo]
#def to_day_sym(in_day)
#  (in_day.day_sym? ? in_day : day_num_to_day_sym(in_day))
#end

# Converts the given day input into the corresponding day number
# DayNum|DaySym -> DayNum
# Tests (:Mo) => 1, (1) => 1, (:So) => 7, (0) => Err, (:We) => Err
# (DaySym[:Mo]) => DaySym[1], (DayNum[1]) => DayNum[1]
#def to_day_num(in_day)
#  (in_day.day_num? ? in_day : day_sym_to_day_num(in_day))
#end

# Gives the successor of the given day number
# DayNum -> DayNum
# Tests (1) => 2, (:Mo) => Err, (0) => Err, (:We) => Err
# (DaySym[:Mo]) => Err, (DayNum[1]) => DayNum[2]
#def day_num_succ(in_number)
#  check_pre((in_number.day_num?))
#  DayNum[to_external(to_internal(in_number.num).succ % WEEK_END)]
#end

# Gives the successor of the given day symbol
# DaySym -> DaySym
# Tests (1) => Err, (:Mo) => :Di, (0) => Err, (:We) => Err
# (DaySym[:Mo]) => DaySym[:Di], (DayNum[1]) => Err
#def day_sym_succ(in_sym)
#  check_pre((in_sym.day_sym?))
#  day_num_to_day_sym(day_num_succ(day_sym_to_day_num(in_sym)))
#end

# Gives the predecessor of the given day number
# DayNum -> DayNum
# Tests (1) => 7, (:Mo) => Err, (7) => 6, (0) => Err
# (DaySym[:Mo]) => Err, (DayNum[1]) => DayNum[7]
#def day_num_pred(in_number)
#  check_pre((in_number.day_num?))
#  DayNum[to_external(to_internal(in_number.num).pred % WEEK_END)]
#end

# Gives the predecessor of the given day symbol
# DaySym -> DaySym
# Tests (1) => Err, (:Mo) => :So, (0) => Err, (:We) => Err
# (DaySym[:Mo]) => DaySym[:So], (DayNum[1]) => Err
#def day_sym_pred(in_sym)
#  check_pre((in_sym.day_sym?))
#  day_num_to_day_sym(day_num_pred(day_sym_to_day_num(in_sym)))
#end

# Gives the successor of the given day
# DaySym -> DaySym
# DayNum -> DayNum
# Tests (1) => 2, (:Mo) => :Di, (0) => Err, (:We) => Err
# (DaySym[:Mo]) => DaySym[:Di], (DayNum[1]) => DayNum[2]
#def day_succ(in_day)
#    in_day.day_sym? ? day_sym_succ(in_day) : day_num_succ(in_day)
#end

# Gives the predecessor of the given day
# DaySym -> DaySym
# DayNum -> DayNum
# Tests (1) => 7, (:Mo) => :So, (0) => Err, (:We) => Err
# (DaySym[:Mo]) => DaySym[:So], (DayNum[1]) => DayNum[7]
#def day_pred(in_day)
#  (in_day.day_sym? ? day_sym_pred(in_day) : day_num_pred(in_day))
#end

def to_internal(in_index)
  in_index - 1
end

def to_external(in_index)
  in_index + 1
end

# Converts a day to the given representation
# Day x Day -> Day :: (representation x day)
# Tests (1, DayNum[4]) => 4, (:Mo, DayNum[2]) => :Di, (:We, DayNum[2]) => Err
# (DayNum[1], :Mo) => DayNum[1], (DaySym[:Mo], DayNum[3]) => :Mi
#def to_day(in_representation, in_day)
#  check_pre(((day?(in_day)) and (day?(in_representation))))
#
#  if (in_representation.day_sym?) then
#      to_day_sym(in_day)
#  else
#    to_day_num(in_day)
#  end
#end

# Shifts the day by a given amount
# Day x Int -> Day
# Tests (DayNum[1], 2) => DayNum[3], (DaySym[:Di], 2) => DaySym[:Do], (1, 1) => 2
# (:Mo, 2) => :Mi, (1, -1) => 7, (-1, 1) => Err
#def day_shift(in_day, in_shift)
#  check_pre(((day?(in_day)) and (in_shift.int?)))
#  to_day(in_day, DayNum[to_external(day_num_shift(to_internal(to_day_num(in_day).num), in_shift))])
#end
#
#def day_num_shift(in_day_num, in_shift)
#  (in_day_num + in_shift) % WEEK_END
#end