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

def_class(:Daysym, [:sym]){
  def invariant?() DAYSYM.include?(self.sym) end
}

def_class(:Daynum, [:num]){
  def invariant?() self.num.in?(DAYNUM) end
}

DAY_SYM = DAYSYM.map{|sym| Daysym[sym]}

# Checks if the given number is representing a valid day number.
# Any -> Bool
# Tests (1) => true, (7) => true, (0) => false, ('1') => false
# (DaySym[:Mo]) => false, (DayNum[1]) => true
def day_num?(in_number)
  in_number.in?(DAYNUM) or in_number.daynum?
end

# Checks if the given symbol is representing a valid day symbol
# Any -> Bool
# Tests (:Mo) => true, (:So) => true, (:We) => false, (1) => false,
# # (DaySym[:Mo]) => true, (DayNum[1]) => false
def day_sym?(in_symbol)
  DAYSYM.include?(in_symbol) or in_symbol.daysym?
end

# Checks if the given input is representing a valid day, either number or symbol
# Any -> Bool
# Tests (1) => true, (:Mo) => true, (:So) => true, (7) => true, (:we) => false,
# (DaySym[:Mo]) => true, (DayNum[1]) => true
def day?(in_day)
  day_num?(in_day) or day_sym?(in_day)
end

# Converts the given day number into the representing symbol
# DayNum -> DaySym
# Tests (1) => :Mo, (7) => :So, (0) => Err, (8) => Err, (:Mo) => Err,
# (DaySym[:Mo]) => Err, (DayNum[1]) => DaySym[:Mo]
def day_num_to_day_sym(in_number)
  check_pre((day_num?(in_number)))
  struct = DAY_SYM[to_internal(get_day_num(in_number))]
  (in_number.daynum? ? struct : struct.sym)
end

# Converts the given day symbol into the representing number
# DaySym -> DayNum
# Tests (:Mo) => 1, (:So) => 7, (:we) => Err, (1) => Err
# (DaySym[:Mo]) => DayNum[1], (DayNum[1]) => Err
def day_sym_to_day_num(in_symbol)
  check_pre((day_sym?(in_symbol)))
  Daynum[to_external(DAYSYM.index(get_day_sym(in_symbol)))]
end

# Converts the given day input into the corresponding day symbol
# DayNum|DaySym -> DaySym
# Tests (:Mo) => :Mo, (1) => :Mo, (7) => :So, (:So) => :So
# (DaySym[:Mo]) => DaySym[:Mo], (DayNum[1]) => DaySyn[:Mo]
def to_day_sym(in_day)
  (day_sym?(in_day) ? in_day : day_num_to_day_sym(in_day))
end

# Converts the given day input into the corresponding day number
# DayNum|DaySym -> DayNum
# Tests (:Mo) => 1, (1) => 1, (:So) => 7, (0) => Err, (:We) => Err
# (DaySym[:Mo]) => DaySym[1], (DayNum[1]) => DayNum[1]
def to_day_num(in_day)
  (day_num?(in_day) ? in_day : day_sym_to_day_num(in_day))
end

# Gives the successor of the given day number
# DayNum -> DayNum
# Tests (1) => 2, (:Mo) => Err, (0) => Err, (:We) => Err
# (DaySym[:Mo]) => Err, (DayNum[1]) => DayNum[2]
def day_num_succ(in_number)
  check_pre((day_num?(in_number)))
  external = to_external(to_internal(get_day_num(in_number)).succ % WEEK_END)
  (in_number.daynum? ? Daynum[external] : external)
end

# Gives the successor of the given day symbol
# DaySym -> DaySym
# Tests (1) => Err, (:Mo) => :Di, (0) => Err, (:We) => Err
# (DaySym[:Mo]) => DaySym[:Di], (DayNum[1]) => Err
def day_sym_succ(in_sym)
  check_pre((day_sym?(in_sym)))
  daysym = day_num_to_day_sym(day_num_succ(day_sym_to_day_num(in_sym)))
  (in_sym.daysym? ? daysym : daysym.sym)
end

# Gives the predecessor of the given day number
# DayNum -> DayNum
# Tests (1) => 7, (:Mo) => Err, (7) => 6, (0) => Err
# (DaySym[:Mo]) => Err, (DayNum[1]) => DayNum[7]
def day_num_pred(in_number)
  check_pre((day_num?(in_number)))
  external = to_external(to_internal(get_day_num(in_number)).pred % WEEK_END)
  (in_number.daynum? ? Daynum[external] : external)
end

# Gives the predecessor of the given day symbol
# DaySym -> DaySym
# Tests (1) => Err, (:Mo) => :So, (0) => Err, (:We) => Err
# (DaySym[:Mo]) => DaySym[:So], (DayNum[1]) => Err
def day_sym_pred(in_sym)
  check_pre((day_sym?(in_sym)))
  daysym = day_num_to_day_sym(day_num_pred(day_sym_to_day_num(in_sym)))
  (in_sym.daysym? ? daysym : daysym.sym)
end

# Gives the successor of the given day
# DaySym -> DaySym
# DayNum -> DayNum
# Tests (1) => 2, (:Mo) => :Di, (0) => Err, (:We) => Err
# (DaySym[:Mo]) => DaySym[:Di], (DayNum[1]) => DayNum[2]
def day_succ(in_day)
  (day_sym?(in_day) ? day_sym_succ(in_day) : day_num_succ(in_day))
end

# Gives the predecessor of the given day
# DaySym -> DaySym
# DayNum -> DayNum
# Tests (1) => 7, (:Mo) => :So, (0) => Err, (:We) => Err
# (DaySym[:Mo]) => DaySym[:So], (DayNum[1]) => DayNum[7]
def day_pred(in_day)
  (day_sym?(in_day) ? day_sym_pred(in_day) : day_num_pred(in_day))
end

def get_day_num(in_daynum)
  (in_daynum.daynum? ? in_daynum.num : in_daynum)
end

def get_day_sym(in_daysym)
  (in_daysym.daysym? ? in_daysym.sym : in_daysym)
end

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
def to_day(in_representation, in_day)
  check_pre(((day?(in_day)) and (day?(in_representation))))

  if (day_sym?(in_representation)) then
    symbol = (day_sym?(in_day) ? get_day_sym(in_day) : get_day_sym(to_day_sym(get_day_num(in_day))))
    (in_representation.daysym? ? Daysym[symbol] : symbol)
  else
    external = (day_num?(in_day) ? get_day_num(in_day) : get_day_num(to_day_num(get_day_sym(in_day))))
    (in_representation.daynum? ? Daynum[external] : external)
  end
end

# Shifts the day by a given amount
# Day x Int -> Day
# Tests (DayNum[1], 2) => DayNum[3], (DaySym[:Di], 2) => DaySym[:Do], (1, 1) => 2
# (:Mo, 2) => :Mi, (1, -1) => 7, (-1, 1) => Err
def day_shift(in_day, in_shift)
  check_pre(((day?(in_day)) and (in_shift.int?)))
  to_day(in_day, to_external(day_num_shift(to_internal(to_day(1, in_day)), in_shift)))
end

def day_num_shift(in_day_num, in_shift)
  (in_day_num + in_shift) % WEEK_END
end