module wlr

#flag -lwayland-server
#flag -lwlroots
#include <wayland-server.h>
#include <wlr/backend.h>

@[typedef]
struct C.wl_display {}

@[typedef]
struct C.wlr_backend {}

fn C.wl_display_create() &C.wl_display

pub fn create_display() &C.wl_display {
	return C.wl_display_create()
}
