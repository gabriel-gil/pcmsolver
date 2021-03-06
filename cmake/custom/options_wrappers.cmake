# Options handling utilities
include(CMakeDependentOption)
# Macro for printing an option in a consistent manner
# Written by Lori A. Burns (@loriab) and Ryan M. Richard (@ryanmrichard)
# Syntax: print_option(<option to print> <was specified>)
macro(print_option variable default)
  if(NOT DEFINED ${variable} OR "${${variable}}" STREQUAL "")
    message(STATUS "Setting (unspecified) option ${variable}: ${default}")
  else()
    message(STATUS "Setting option ${variable}: ${${variable}}")
  endif()
endmacro()

# Wraps an option with default ON/OFF. Adds nice messaging to option()
# Written by Lori A. Burns (@loriab) and Ryan M. Richard (@ryanmrichard)
# Syntax: option_with_print(<option name> <description> <default value>)
macro(option_with_print variable msge default)
  print_option(${variable} ${default})
  option(${variable} ${msge} ${default})
endmacro(option_with_print)

# Wraps an option with a default other than ON/OFF and prints it
# Written by Lori A. Burns (@loriab) and Ryan M. Richard (@ryanmrichard)
# NOTE: Can\'t combine with above b/c CMake handles ON/OFF options specially
# NOTE2: CMake variables are always defined so need to further check for if
#       they are the NULL string. This is also why we need the force
# Syntax: option_with_default(<option name> <description> <default value>)
macro(option_with_default variable msge default)
  print_option(${variable} "${default}")
  if(not defined ${variable} or "${${variable}}" strequal "")
    set(${variable} "${default}" cache string ${msge} force)
  endif()
endmacro(option_with_default)
