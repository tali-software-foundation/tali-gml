/// @description Read-Eval-Print-Loop

// Initialize namespace

// Initialize on-screen prompt
cursor = "|";
delay = 20;
alarm[0] = delay;

expr = "";

// Initialize history
history = ds_list_create();
