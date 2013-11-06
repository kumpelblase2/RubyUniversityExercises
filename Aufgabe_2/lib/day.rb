$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

DayNum = 1..7
DaySym = [ :Mo, :Di, :Mi, :Do, :Fr, :Sa, :So ]
Day = (DayNum | DaySym)

def day_num?(in_number)
  DayNum === in_number
end

def day_sym?(in_symbol)
  DaySym === in_symbol
end

def day?(in_day)
  Day === in_day
end

def day_num_to_day_sym(in_number)
  check_pre((day_num?(in_number)))
  DaySym[in_number - 1]
end

def day_sym_to_day_num(in_symbol)
  check_pre((day_num?(in_symbol)))
  DaySym.index(in_symbol)
end

def to_day_sym(in_day)
  (day_sym?(in_day) ? in_day : day_num_to_day_sym(in_day))
end

def to_day_num(in_day)
  (day_num?(in_day) ? in_day : day_sym_to_day_num(in_day))
end

def day_num_succ(in_number)
  check_pre((day_num?(in_number)))
  (day_num?(in_number.succ) ? in_number.succ : 1)
end

def day_sym_succ(in_sym)
  check_pre((day_sym?(in_sym)))
  day_num_to_day_sym(day_num_succ(day_sym_to_day_num(in_sym)))
end

def day_num_pred(in_number)
  check_pre((day_num?(in_number)))
  (day_num?(in_number.pred) ? in_number.pred : 7)
end

def day_sym_pred(in_sym)
  check_pre((day_sym?(in_sym)))
  day_num_to_day_sym(day_num_pred(day_sym_to_day_num(in_sym)))
end

def day_succ(in_day)
  (day_sym?(in_day) ? day_sym_succ(in_day) : day_num_succ(in_day))
end

def day_pred(in_day)
  (day_sym?(in_day) ? day_sym_pred(in_day) : day_num_pred(in_day))
end