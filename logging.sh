#!/bin/bash
#------------------------------------------------------------------------------
#     DESCRIPTION : This file provides colored logging functionality
#                   Multiple log levels are provided.
#          AUTHOR : Murali Paluru
#
#      CREATED ON : 06-Oct-2015
#
#------------------------------------------------------------------------------

# 
# Customization variables
#   These variables need to be set before including/sourcing logging.sh file.
#
#   LOGGING_FUNCTIONS_PREFIX
#       This is used as a prefix for the different functions provided by this
#       file. For example if the prefix used is "mp_", then the available 
#       functions become:
#           - mp_print_debug
#           - mp_print_info
#           - mp_print_warning
#           - mp_print_error
#           - mp_print_critical
#
#       The same prefix is passed on to the colorize.sh script for accessing
#       the various colors.
#
#   LOGGING_PREFIX_STR
#       This is the string which shows up in all the messages.
#       For example: If this is set to "[PrefixString] " it shows up as
#           [PrefixString] [D]: [logging.sh] - This is a debug message 
#           [PrefixString] [I]: [logging.sh] - This is a info message
#           [PrefixString] [W]: [logging.sh] - This is a warning message
#           [PrefixString] [E]: [logging.sh] - This is an error message
#           [PrefixString] [C]: [logging.sh] - This is an critical message
#
#   LOGGING_LEVEL
#       {critical, error, warning, info, debug} Default: critical
#       This is used to change the log level.
#
#   LOGGING_USE_COLOR
#       {Default: true}
#       If for some reason we don't want to show the output in colors but in 
#       plain normal text, this variable can be used.
#       This is useful when redirecting the output of the script to file to
#       avoid the escape characters showing up in the log file.
#
#   LOGGING_SHOW_FILENAME
#       {Default: true}
#       This is used to show the filename which has included this logging.sh file

# This should be the first code to be executed, else not working
if [ "$_" == "$0" ]; then
    SCRIPT_MODE=1
else
    SCRIPT_MODE=0
fi

#LOGGING_FUNCTIONS_PREFIX=mp_
#LOGGING_PREFIX_STR="[PrefixString] "

__file_name__=`basename "$0"`

SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [ ! "${LOGGING_USE_COLOR}" == false ]; then
    COLORIZE_COLORS_PREFIX=$(echo ${LOGGING_FUNCTIONS_PREFIX} | tr [a-z] [A-Z])
    COLORIZE_COLORS_PREFIX_LC=${LOGGING_FUNCTIONS_PREFIX}
    COLORIZE_SRC_FILE=${SCRIPT_DIR}/colorize-sh/colorize.sh

    if [ ! -f "${COLORIZE_SRC_FILE}" ]; then
        printf "Error: Couldn't find file: ${COLORIZE_SRC_FILE}"
        exit 1
    else
        . ${COLORIZE_SRC_FILE}
    fi 
fi

__LEVEL_CRITICAL=10
__LEVEL_ERROR=20
__LEVEL_WARNING=30
__LEVEL_INFO=40
__LEVEL_DEBUG=50

case ${LOGGING_LEVEL} in
    "critical" | "CRITICAL" | "Critical")
        __LOGGING_LEVEL=${__LEVEL_CRITICAL}
        ;;
    "error" | "ERROR" | "Error")
        __LOGGING_LEVEL=${__LEVEL_ERROR}
        ;;
    "warning" | "WARNING" | "Warning")
        __LOGGING_LEVEL=${__LEVEL_WARNING}
        ;;
    "info" | "INFO" | "Info")
        __LOGGING_LEVEL=${__LEVEL_INFO}
        ;;
    "debug" | "DEBUG" | "Debug")
        __LOGGING_LEVEL=${__LEVEL_DEBUG}
        ;;
    *)
        __LOGGING_LEVEL=${__LEVEL_CRITICAL}
        ;;
esac

# Debug
_fname=${LOGGING_FUNCTIONS_PREFIX}print_debug
if [ ${__LOGGING_LEVEL} -ge ${__LEVEL_DEBUG} ]; then
    eval "
        function ${_fname}()
        {
            _debug_color_name=Cyan
            _c=${COLORIZE_COLORS_PREFIX}\${_debug_color_name}
            _c_bold=${COLORIZE_COLORS_PREFIX}Bold\${_debug_color_name}
            _c_reset=${COLORIZE_COLORS_PREFIX}ColorReset
            _c_u=${COLORIZE_COLORS_PREFIX}UnderlineWhite
            printf \"${LOGGING_PREFIX_STR}\${!_c}[\${!_c_bold}D\${!_c_reset}\${!_c}]\${!_c_reset}: [\${!_c_u}${__file_name__}\${!_c_reset}] - \${!_c}%s\${!_c_reset}\n\" \"\$1\"
        }
    "
else
    eval "function ${_fname}() { :; }"
fi

# Info
_fname=${LOGGING_FUNCTIONS_PREFIX}print_info
if [ ${__LOGGING_LEVEL} -ge ${__LEVEL_INFO} ]; then
    eval "
        function ${_fname}()
        {
            _info_color_name=Green
            _c=${COLORIZE_COLORS_PREFIX}\${_info_color_name}
            _c_bold=${COLORIZE_COLORS_PREFIX}Bold\${_info_color_name}
            _c_reset=${COLORIZE_COLORS_PREFIX}ColorReset
            _c_u=${COLORIZE_COLORS_PREFIX}UnderlineWhite
            printf \"${LOGGING_PREFIX_STR}\${!_c}[\${!_c_bold}I\${!_c_reset}\${!_c}]\${!_c_reset}: [\${!_c_u}${__file_name__}\${!_c_reset}] - \${!_c}%s\${!_c_reset}\n\" \"\$1\"
        }
    "
else
    eval "function ${_fname}() { :; }"
fi

# Warning
_fname=${LOGGING_FUNCTIONS_PREFIX}print_warning
if [ ${__LOGGING_LEVEL} -ge ${__LEVEL_INFO} ]; then
    eval "
        function ${_fname}()
        {
            _warning_color_name=Yellow
            _c=${COLORIZE_COLORS_PREFIX}\${_warning_color_name}
            _c_bold=${COLORIZE_COLORS_PREFIX}Bold\${_warning_color_name}
            _c_reset=${COLORIZE_COLORS_PREFIX}ColorReset
            _c_u=${COLORIZE_COLORS_PREFIX}UnderlineWhite
            printf \"${LOGGING_PREFIX_STR}\${!_c}[\${!_c_bold}W\${!_c_reset}\${!_c}]\${!_c_reset}: [\${!_c_u}${__file_name__}\${!_c_reset}] - \${!_c_bold}%s\${!_c_reset}\n\" \"\$1\"
        }
    "
else
    eval "function ${_fname}() { :; }"
fi

# Error
_fname=${LOGGING_FUNCTIONS_PREFIX}print_error
if [ ${__LOGGING_LEVEL} -ge ${__LEVEL_ERROR} ]; then
    eval "
        function ${_fname}()
        {
            _info_color_name=WhiteOnRed
            _c=${COLORIZE_COLORS_PREFIX}\${_info_color_name}
            _c_bold=${COLORIZE_COLORS_PREFIX}Bold\${_info_color_name}
            _c_reset=${COLORIZE_COLORS_PREFIX}ColorReset
            _c_u=${COLORIZE_COLORS_PREFIX}UnderlineWhite
            printf \"${LOGGING_PREFIX_STR}\${!_c}[\${!_c}E\${!_c_reset}\${!_c}]\${!_c_reset}: [\${!_c_u}${__file_name__}\${!_c_reset}] - \${!_c}%s\${!_c_reset}\n\" \"\$1\"
        }
    "
else
    eval "function ${_fname}() { :; }"
fi

# Critical
_fname=${LOGGING_FUNCTIONS_PREFIX}print_critical
if [ ${__LOGGING_LEVEL} -ge ${__LEVEL_CRITICAL} ]; then
    eval "
        function ${_fname}()
        {
            _info_color_name=WhiteOnRed
            _c=${COLORIZE_COLORS_PREFIX}\${_info_color_name}
            _c_bold=${COLORIZE_COLORS_PREFIX}Bold\${_info_color_name}
            _c_reset=${COLORIZE_COLORS_PREFIX}ColorReset
            _c_u=${COLORIZE_COLORS_PREFIX}UnderlineWhite
            printf \"${LOGGING_PREFIX_STR}\${!_c}[\${!_c_bold}C\${!_c_reset}\${!_c}]\${!_c_reset}: [\${!_c_u}${__file_name__}\${!_c_reset}] - \${!_c_bold}%s\${!_c_reset}\n\" \"\$1\"
        }
    "
else
    eval "function ${_fname}() { :; }"
fi

function __print_diff_log_levels__
{
    ${LOGGING_FUNCTIONS_PREFIX}print_debug "This is a debug message"
    ${LOGGING_FUNCTIONS_PREFIX}print_info "This is a info message"
    ${LOGGING_FUNCTIONS_PREFIX}print_warning "This is a warning message"
    ${LOGGING_FUNCTIONS_PREFIX}print_error "This is an error message"
    ${LOGGING_FUNCTIONS_PREFIX}print_critical "This is an critical message"
}

if [ ${SCRIPT_MODE} -eq 1 ]; then
    __print_diff_log_levels__
fi
