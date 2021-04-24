/// @description Render the S-Expressions the user types


// Draw everything in history
// TODO: account for newlines
var i;
for (i = 0; i < ds_list_size(history); i+= 1) {
	draw_text(5, 5 + i * 15, ds_list_find_value(history, i));
}

// Then draw the current message
draw_text(5, 5 + i * 15, expr + cursor);