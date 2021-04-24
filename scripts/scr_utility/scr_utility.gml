/// @description Collection of utility functions

function print_list(xs) {
	var i;
	for (i = 0; i < ds_list_size(ts); i++) {
		show_debug_message(ds_list_find_value(xs, i));
	}
}