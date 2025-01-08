module librewm

#flag -lwayland-server
#flag -I/usr/include/libdrm
#flag -lwlroots-0.18
#flag -I/usr/include/wlroots-0.18
#flag -I/usr/include/wayland
#flag -I/usr/include/pixman-1
#flag -DWLR_USE_UNSTABLE
#flag -lxcb

#include <wayland-server.h>
#include <wlr/backend.h>

struct C.wl_display {}
struct C.wl_event_loop {}
struct C.wl_display_get_event_loop {}

struct C.wlr_backend {}

struct C.wlr_renderer {}

struct C.wlr_allocator {}

fn C.wl_display_create() &C.wl_display
fn C.wl_display_get_event_loop(display &C.wl_display) &C.wl_event_loop
fn C.wlr_backend_autocreate(event_loop &C.wl_event_loop, session &C.wlr_session) &C.wlr_backend
fn C.wlr_backend_start(backend &C.wlr_backend) bool

fn main() {
    display := C.wl_display_create()
    event_loop := C.wl_display_get_event_loop(display)
    backend := C.wlr_backend_autocreate(event_loop, unsafe { nil })
    
    if !C.wlr_backend_start(backend) {
        println('Failed to start backend')
        exit(1)
    }
}
