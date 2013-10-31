$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

ANGENEHM_LOWER = 16
ANGENEHM_UPPER = 22
ANGENEHM_RANGE = ANGENEHM_LOWER..ANGENEHM_UPPER


def zu_kalt?(in_temp)
	check_pre((in_temp.int?))
	in_temp < ANGENEHM_LOWER
end

def zu_warm?(in_temp)
	check_pre((in_temp.int?))
	in_temp > ANGENEHM_UPPER
end

def angenehm?(in_temp)
	check_pre((in_temp.int?))
	ANGENEHM_RANGE === in_temp
end

def unangenehm?(in_temp)
	check_pre((in_temp.int?))
	!(ANGENEHM_RANGE === in_temp)
end

def angenehm2?(in_temp)
	!unangenehm?(in_temp)
end

def angenehm3?(in_temp)
	!zu_warm?(in_temp) and !zu_kalt?(in_temp)
end

def angenehm4?(in_temp)
	check_pre((in_temp.int?))
	in_temp >= ANGENEHM_LOWER and in_temp <= ANGENEHM_UPPER
end