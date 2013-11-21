$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_pr1_v4"

# Definition for the first week day as number
WEEK_START = 1

# Definition for the last week day as number
WEEK_END = 7

# Definition for all valid day numbers
DAYNUM = WEEK_START..WEEK_END

# Definition for all valid day symbols
DAYSYM = [ :Mo, :Di, :Mi, :Do, :Fr, :Sa, :So ]

# Checks if the given number is representing a valid day number.
# Any -> Bool
def day_num?(in_number)
  DAYNUM === in_number
end

# Checks if the given symbol is representing a valid day symbol
# Any -> Bool
def day_sym?(in_symbol)
  DAYSYM.include?(in_symbol)
end

# Checks if the given input is representing a valid day, either number or symbol
# Any -> Bool
def day?(in_day)
  day_num?(in_day) or day_sym?(in_day)
end

# Converts the given day number into the representing symbol
# DayNum -> DaySym
def day_num_to_day_sym(in_number)
  check_pre((day_num?(in_number)))
  DAYSYM[to_internal(in_number)]
end

# Converts the given day symbol into the representing number
# DaySym -> DayNum
def day_sym_to_day_num(in_symbol)
  check_pre((day_sym?(in_symbol)))
  to_external(DAYSYM.index(in_symbol))
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
  to_external((to_internal(in_number).succ % WEEK_END))
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
  to_external((to_internal(in_number).pred % WEEK_END))
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

def to_internal(in_index)
  in_index - 1
end

def to_external(in_index)
  in_index + 1
end