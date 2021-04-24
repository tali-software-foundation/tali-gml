/// @description Collection of utility functions

// TODO: Genericicize print to check type and prints accordingly
function print(_v) {
	show_debug_message(string(_v));
}

/// @description Print a list to console
function print_list(_xs) {
	var i;
	for (i = 0; i < ds_list_size(_xs); i++) {
		print(ds_list_find_value(_xs, i));
	}
}

function print_map(_m) {
	var s = ds_map_size(_m);
	var k = ds_map_find_first(_m);
	var v;
	var i;
	print("{");
	for (i = 0; i < s; i++) {
		v = ds_map_find_value(_m, k);
		print(string(k) +  ":" + string(v));
		k = ds_map_find_next(_m, k);
	}
	print("}");
}

/// @description Combine two maps into a new map
function merge_pure(m1, m2) {
	var m3 = ds_map_create();
	merge_impure(m3, m1);
	merge_impure(m3, m2);
	return m3;
}

/// @description Update the first map to include the second's (k, v) pairs
function merge_impure(m1, m2) {
	var s = ds_map_size(m2);
	var k = ds_map_find_first(m2);
	var v;
	var i;
	for (i = 0; i < s; i++) {
		v = ds_map_find_value(m2, k);
		ds_map_add(m1, k, v);
		k = ds_map_find_next(m2, k);
	}
}