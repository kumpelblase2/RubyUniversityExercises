$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions/lib')
require "ext_checks_v1"
require "ext_elems_v2"
require "ext_modules_v2"
require "ext_lists_v2"

# Defines the lower border of the temperature
ANGENEHM_LOWER = 16
# Defines the upper border of the temperature
ANGENEHM_UPPER = 22
# Range of humid temperatures
ANGENEHM_RANGE = ANGENEHM_LOWER..ANGENEHM_UPPER

# Checks if the given temperature is too cold
# Int -> Bool
def zu_kalt?(in_temp)
	check_pre((in_temp.int?))
	in_temp < ANGENEHM_LOWER
end

# Checks if the given temperature is too warm
# Int -> Bool
def zu_warm?(in_temp)
	check_pre((in_temp.int?))
	in_temp > ANGENEHM_UPPER
end

# Checks if the given temperature is just right
# Int -> Bool
def angenehm?(in_temp)
	check_pre((in_temp.int?))
#	ANGENEHM_RANGE === in_temp
  in_temp.in?(ANGENEHM_RANGE)
end

# Checks if the temperature is either too cold or too warm
# Int -> Bool
def unangenehm?(in_temp)
	check_pre((in_temp.int?))
	not angenehm?(in_temp)
end

def angenehm2?(in_temp)
	not unangenehm?(in_temp)
end

def angenehm3?(in_temp)
	not zu_warm?(in_temp) and not zu_kalt?(in_temp)
end

def angenehm4?(in_temp)
	check_pre((in_temp.int?))
	not (zu_warm?(in_temp) or zu_kalt?(in_temp))
end

def angenehmK?(in_temp)
	check_pre((in_temp.int?))
	((zu_warm?(in_temp) ? true : zu_kalt?(in_temp)) ? false : true)
end