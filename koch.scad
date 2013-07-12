size = 40;
iterations = 3;
clear_extra = 0.1;


difference() {
    cube(size = size, center = true);
    for (i = [0: iterations-1])
    {
		echo("i: ", i, " ", pow(3, i) );
	    assign(current_size = size / pow(3, i), 
		       small_size = size / 3 / pow(3, i), 
               inner_loop_size = (pow(3, i) - 1) / 2)
	    {
			echo("inner_loop_size:", inner_loop_size, " current_size:", current_size, " small_size:", small_size);
		    for (x_loop = [-inner_loop_size:inner_loop_size])
            {
		    for (y_loop = [-inner_loop_size:inner_loop_size])
            {
		    for (z_loop = [-inner_loop_size:inner_loop_size])
            {

	        for (x = [-small_size-clear_extra, small_size+clear_extra])
	        {
   	            for (y = [-small_size-clear_extra, small_size+clear_extra])
	            {
   	                for (z = [-small_size-clear_extra, small_size+clear_extra])
	                {
	                    translate([x - x_loop * current_size, 
							      y - y_loop * current_size, 
								  z - z_loop * current_size])
	                    cube(size = small_size + 2*clear_extra, center = true);
                    }
                }
            }
			// test: one in the center
			cube(size = small_size, center = true);

			}
			}
			}
	    }
	}

	
}