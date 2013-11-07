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
DayNum = WEEK_START..WEEK_END

# Definition for all valid day symbols
DaySym = [ :Mo, :Di, :Mi, :Do, :Fr, :Sa, :So ]

# Definition for all valid day inputs
Day = (DayNum.to_a | DaySym)

# Checks if the given number is representing a valid day number.
# Any -> Bool
def day_num?(in_number)
  DayNum === in_number
end

# Checks if the given symbol is representing a valid day symbol
# Any -> Bool
def day_sym?(in_symbol)
  DaySym.include?(in_symbol)
end

# Checks if the given input is representing a valid day, either number or symbol
# Any -> Bool
def day?(in_day)
  Day.include?(in_day)
end

# Converts the given day number into the representing symbol
# DayNum -> DaySym
def day_num_to_day_sym(in_number)
  check_pre((day_num?(in_number)))
  DaySym[in_number - 1]
end

# Converts the given day symbol into the representing number
# DaySym -> DayNum
def day_sym_to_day_num(in_symbol)
  check_pre((day_sym?(in_symbol)))
  DaySym.index(in_symbol) + 1
end

# Converts the given day input into the corresponding day symbol
# DayNum|DaySym -> DaySym
def to_day_sym(in_day)
  (day_sym?(in_day) ? in_day : day_num_to_day_sym(in_day))
end

# Converts the given day input into the corresponding day number
# DayNum|DaySym -> DayNum
def to_day_num(in_day)
  (day_num?(in_day) ? in_day : day_sym_to_day_num(in_day))
end

# Gives the successor of the given day number
# DayNum -> DayNum
def day_num_succ(in_number)
  check_pre((day_num?(in_number)))
  (day_num?(in_number.succ) ? in_number.succ : WEEK_START)
end

# Gives the successor of the given day symbol
# DaySym -> DaySym
def day_sym_succ(in_sym)
  check_pre((day_sym?(in_sym)))
  day_num_to_day_sym(day_num_succ(day_sym_to_day_num(in_sym)))
end

# Gives the predecessor of the given day number
# DayNum -> DayNum
def day_num_pred(in_number)
  check_pre((day_num?(in_number)))
  (day_num?(in_number.pred) ? in_number.pred : WEEK_END)
end

# Gives the predecessor of the given day symbol
# DaySym -> DaySym
def day_sym_pred(in_sym)
  check_pre((day_sym?(in_sym)))
  day_num_to_day_sym(day_num_pred(day_sym_to_day_num(in_sym)))
end

# Gives the successor of the given day
# DaySym -> DaySym
# DayNum -> DayNum
def day_succ(in_day)
  (day_sym?(in_day) ? day_sym_succ(in_day) : day_num_succ(in_day))
end

# Gives the predecessor of the given day
# DaySym -> DaySym
# DayNum -> DayNum
def day_pred(in_day)
  (day_sym?(in_day) ? day_sym_pred(in_day) : day_num_pred(in_day))
end