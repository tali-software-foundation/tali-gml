/**
 * Parse a given character sequence into tokens
 */
function tokenize(_seq) {
	var i = 1
	var c = string_char_at(_seq, i);
	var ts = ds_list_create();
	while (c != "") {
		if c == " " or c == "\n" or c == "\t" {
			i += 1
			c = string_char_at(_seq, i);
		}
		else if (c == "(") {
			ds_list_add(ts, new Token("LPAREN", "("));
			i += 1;
			c = string_char_at(_seq, i);
		}
		else if (c == ")") {
			ds_list_add(ts, new Token("RPAREN", ")"));
			i += 1;
			c = string_char_at(_seq, i);
		}
		else if (c == "[") {
			ds_list_add(ts, new Token("LSQUARE", "["));
			i += 1;
			c = string_char_at(_seq, i);
		}
		else if (c == "]") {
			ds_list_add(ts, new Token("RSQUARE", "]"));
			i += 1;
			c = string_char_at(_seq, i);
		}
		else if (c == ":") {
			ds_list_add(ts, new Token("COLON", ":"));
			i += 1;
			c = string_char_at(_seq, i);
		}
		else {
			i += 1; 
			var n = string_char_at(_seq, i);
			while  n != "("
				&& n != ")"
				&& n != "["
				&& n != "]"
				&& n != ":"
				&& n != " " 
				&& n != "\n"
				&& n != "\t"
				&& n != "" {
				c = c + n;
				i += 1;
				n = string_char_at(_seq, i);
			}
			ds_list_add(ts, new Token("ATOM", c));
			c = n;
		}
	}
	return ts;
}

function Token(_name, _value) constructor {
	name = _name;
	value = _value;
}
