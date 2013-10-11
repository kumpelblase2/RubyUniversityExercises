# To change this template, choose Tools | Templates
# and open the template in the editor.
$:.unshift File.join(File.dirname(__FILE__),'..','lib')
require 'hollow_cube_volume'

puts hollow_cube_volume(3,3)
