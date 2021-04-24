/// @description Insert description here
// You can write your code in this editor

if keyboard_check(vk_control) && keyboard_check(ord("D")) {
	// CTRL-D quits
	game_end();	   
}
else if keyboard_check(vk_shift) && keyboard_check(ord("(")) {
	// Personal work-around for weird "(" behavior (backspaces)
    expr = expr + "(";
	keyboard_string = "";
}
else if keyboard_check(vk_shift) && keyboard_check(vk_enter) {
    expr = expr + "\n";
	keyboard_string = "";
}
else if keyboard_check(vk_enter) {
	ds_list_add(history, string_copy(expr, 1, string_length(expr)));
	ts = tokenize(expr);
	expr = "";
	keyboard_string = "";
}
else if keyboard_check(vk_backspace) {
	var temp = string_copy(expr, 1, string_length(expr) - 1);
	expr = temp;
	keyboard_string = "";
}
else {
	expr = expr + keyboard_string;
	keyboard_string = "";
}