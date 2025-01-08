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
struct C.wl_listener {}
struct C.wl_signal {}

struct C.wlr_backend {}
struct C.wlr_renderer {}
struct C.wlr_allocator {}
struct C.wlr_session {}
struct C.wlr_output_layout {}
struct C.wlr_output {}

fn C.wl_display_create () &C.wl_display
fn C.wl_display_get_event_loop (display &C.wl_display) &C.wl_event_loop
fn C.wl_display_run (display &C.wl_display)

fn C.wlr_renderer_autocreate(backend &C.wlr_backend) &C.wlr_renderer
fn C.wlr_allocator_autocreate(backend &C.wlr_backend, renderer &C.wlr_renderer) &C.wlr_allocator
fn C.wlr_output_layout_create() &C.wlr_output_layout
fn C.wlr_renderer_begin(renderer &C.wlr_renderer, width int, height int)
fn C.wlr_renderer_clear(renderer &C.wlr_renderer, color &f32)
fn C.wlr_renderer_end(renderer &C.wlr_renderer)
fn C.wlr_backend_autocreate (event_loop &C.wl_event_loop, session &C.wlr_session) &C.wlr_backend
fn C.wlr_backend_start (backend &C.wlr_backend) bool
fn C.wlr_output_init_render (output &C.wlr_output, allocator &C.wlr_allocator, renderer &C.wlr_renderer)
fn C.wlr_output_create_global (output &C.wlr_output)

fn main() {
  display 	  	:= C.wl_display_create ()
  event_loop    := C.wl_display_get_event_loop (display)
  backend 	  	:= C.wlr_backend_autocreate (event_loop, unsafe { nil })
	renderer 	  	:= C.wlr_renderer_autocreate (backend)
	allocator 	  := C.wlr_allocator_autocreate (backend, renderer)
	output_layout := C.wlr_output_layout_create () 
	color		  		:= [f32(1.0), 0.0, 0.0, 1.0]
	    
  if !C.wlr_backend_start (backend) {
    println ("Failed to start backend, aborting...")
    exit(1)
  }

	C.wlr_renderer_begin (renderer, 1920, 1080)
  C.wlr_renderer_clear (renderer, &color[0])
  C.wlr_renderer_end (renderer)

	C.wl_display_run (display);	
}
