require 'mkmf'
$CFLAGS << ' -Wall -Werror'
create_makefile("visibility_monitor_c")
