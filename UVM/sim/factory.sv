function base factory_create(string classname, string name = "obj", base up = null);
    base obj;

    if (classname == "packet") obj = packet'(packet::new(name, up));  // ← cast to base
    else if (classname == "sequencer") obj = sequencer'(sequencer::new(name, up));
    else if (classname == "driver") obj = driver'(driver::new(name, up));
    else if (classname == "monitor") obj = monitor'(monitor::new(name, up));
    else $fatal(1, "Unknown class '%s' in factory", classname);

    return obj;
endfunction
