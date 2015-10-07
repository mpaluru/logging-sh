# logging.sh
Logging functionality for Shell Scripts

This utlility script provides easy console logging functinality with different levels.


## Download

```
cd your_project_dir
git clone --recursive https://github.com/mpaluru/logging-sh.git
```

## Example Usage

### Simple Usage
```
#!/bin/bash

# Set the log level
LOGGING_LEVEL=debug

# Import the logging.sh file
. logging-sh/logging.sh

# Start using
print_debug "This is a debug message"
print_info "This is a info message"
print_warning "This is a warning message"
print_error "This is an error message"
print_critical "This is an critical message"
```

### Advanced Usage:

You can specify your own prefix for the functions. See the file: `example_usage.sh`

```
#!/bin/bash

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
```

## Run the example
```
git clone --recursive https://github.com/mpaluru/logging-sh.git

cd logging-sh

./example_usage.sh
```

## Dependencies

This project uses the colorize.sh script to bring in the colors.
See `https://github.com/mpaluru/colorize-sh.git`

## Screenshots

![All Colors](screenshots/example_usage.png?raw=true "Example Usage")

## License
MIT License
