#!/bin/bash
#------------------------------------------------------------------------------
#     DESCRIPTION : Example usage of logging.sh file
#
#          AUTHOR : Murali Paluru
#
#      CREATED ON : 06-Oct-2015
#
#------------------------------------------------------------------------------

LOGGING_FUNCTIONS_PREFIX=mp_
LOGGING_PREFIX_STR="[Murali Paluru] "
LOGGING_LEVEL=debug

LOGGING_SRC_FILE=${PWD}/logging.sh

if [ ! -f "${LOGGING_SRC_FILE}" ]; then
    printf "Error: Couldn't find file: ${LOGGING_SRC_FILE}"
    exit 1
else
    . ${LOGGING_SRC_FILE}
fi

mp_print_debug "This is a debug message"
mp_print_info "This is a info message"
mp_print_warning "This is a warning message"
mp_print_error "This is an error message"
mp_print_critical "This is an critical message"
