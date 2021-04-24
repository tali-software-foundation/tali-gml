function parse(_ts) {
	var ps = ds_list_create();
	var p = new Peekable(_ts);
	while p.has_next() {
		try {
			ds_list_add(ps, match_expr(p));
		}
		catch (e) {
			print(e);
			throw(e);
			return ds_list_create();
		}
	}
	return ps;
}

// TODO: All of these might be better as local functions under parse
// so that we can avoid polluting the global namespace.
function match_expr(_ts) {
	var t = _ts.next();
	if t.name == "ATOM" {
		return t.value;
	}
	else if t.name == "LPAREN" {
		match_lparen(t);
		var m = match_kv_map(_ts);
		match_rparen(_ts.next());
		return m;
	}
	else {
		match_lsquare(t);
		var m = match_list_map(_ts, 0);
		match_rsquare(_ts.next());
		return m;
	}
}

function  match_lparen(_t) {
	if _t.name != "LPAREN" {
		throw "Error: expected \"(\"";
	}
}

function match_rparen(_t) {
	if _t.name != "RPAREN" {
		throw "Error: expected \")\"";
	}
}

function match_lsquare(_t) {
	if _t.name != "LSQUARE" {
		throw "Error: expected \"[\"";
	}
}

function match_rsquare(_t) {
	if _t.name != "RSQUARE" {
		throw "Error: expected \"]\"";
	}
}

function match_kv_map(_ts) {
	var m = ds_map_create();
	var pair = match_kv_pair(_ts);
	ds_map_add(m, pair.k, pair.v);
	
	var t = _ts.peek();
	
	if t.name != "RPAREN" {
		merge_impure(m, match_kv_map(_ts));
	}
	
	return m;
}

function match_kv_pair(_ts) {
	var k = match_atom(_ts.next());
	match_colon(_ts.next());
	var v = match_expr(_ts);
	return new Pair(k, v);
}

function match_colon(_t) {
	if _t.name != "COLON" {
		throw "Error: expected \":\"";
	}
}

function match_list_map(_ts, i) {
	var m = ds_map_create();
	var v = match_expr(_ts);
	ds_map_add(m, i, v);
	
	var t = _ts.peek();
	if t.name != "RSQUARE" {
		merge_impure(m, match_list_map(_ts, i + 1));
	}
	
	ds_map_add(m, "len", ds_map_size(m));
	return m;
}

function match_atom(_t) {
	if _t.name != "ATOM" {
		throw "Error: expected atom";	
	}
	return _t.value;
}

function Peekable(_xs) constructor {
	idx = 0;
	xs = _xs;
	static next = function() {
		var v = ds_list_find_value(xs, idx);
		idx += 1
		return v;
	}
	static peek = function() {
		return ds_list_find_value(xs, idx);
	}
	static has_next = function () {
		if idx == ds_list_size(xs) {
			return false;	
		}
		return true;
	}
}

function Pair(_k, _v) constructor {
	k = _k;
	v = _v;
}