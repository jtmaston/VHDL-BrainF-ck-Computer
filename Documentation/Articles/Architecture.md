@page archpage Architecture

# Call me Ishmael...
Or something about taking on a Big Whale. When starting something like this, it's always a good idea to create an architecture, 
a starting point which you'll use in developing for the platform. In my case, I'm a big fan of diagrams, so, here goes...
@image html diagram.svg

Let's take things top-to-bottom-left-to-right:

Cells: 
    - The "cells" represent the basis of the memory subsystem. Based on them, we are able to store data and recall program sequences. 
Ideally, they should be 8-bit wide, since that is what we are aiming with our core. This representation is... a bit of an abstraction, 
granted. As you may gather, the RAM is supposed to be fast, volatile, however the problem arises when we have to take into account program 
data. We might want to use this BF processor in... a microcontroller application! Picture this, BF controlling your entire house, now that's home automation. And loading the program each time on boot... that just won't fly. Therefore, nonvolatile cells (stored on an SPI-accessed uSD) and their volatile counterpart (stored in the FPGA itself) are the base of this module. I noted them as being SPI-ish, but I might just end up making it just fully SPI compatible, depends on how generous I'm feeling. 
In this regard, I see two possibilities:
      - SPI to uSD, parallel interface to each cell. Pros, easy to implement for each cell (already done), big throughput (since that's a 
      big concern, ya know?). Cons, two separate interfaces must be implemented on the MMU. On the flip side, it complies to the Harvard 
      target of this project.
      - SPI to uSD, SPI to each cell. Pros, just one controller can handle everything. Cons... Completely violates the Harvard principle, 
      and might be more difficult to synchronize.

Memory Management Unit (MMU): 
    - This houses the SPI controller and its parallel counterpart. I see it as being a coprocessor, able to fetch instructions requested by 
    the ALU and tossing the results back into flash / RAM. This is where the bulk of the interface / driver code will live, as it is quite 
    difficult to communicate with raw NAND flash as it is. But we'll see. 

Arithmetic Logic Unit (ALU): 
    - Performs calculations, branching etc. This is where the various "pointers" associated with BF live (the program pointer, and maybe 
    some scratch calculation registers). Opcodes are implemented here. 

Input-output device: 
    - Connects to the user's computer, allows for program loading. Nothing too grand here. Most likely will be done via the built-in FTDI, or
    the ULX3S's ESP32. 

I2C debug interface: 
    - This is a good plan to aid in debugging, being able to examine parts of the architecture live, as the "core" is running. I've chosen 
    I2C since it is crazy simple to implement, and allows for synchronization.

<div class="section_buttons">
 
| Previous                  |                              Next |
|:--------------------------|----------------------------------:|
| [Overview](@ref index)    | [Memory](@ref mempage)            |
 
</div>