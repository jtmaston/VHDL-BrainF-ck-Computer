@mainpage Project overview / devlog table of contents

# Project overview
A silly side-project learning VHDL, by implementing a (hopefully?) Turing-complete BrainF*ck computer, complete with ALU, Memory and (hopefully?!?) external programmability.

This is highly work-in-progress, and might not amount to anything :) Ymmv!

## Prelude
How? Why?
- How: using an [ULX3s](https://radiona.org/ulx3s/) development kit from the fine folks at [Radiona](https://radiona.org/).
This integrates a Lattice ECP85 FPGA, a true powerhouse, or so I hear. This project is built around the Diamond IDE,
since, despite almost getting it working using YoSYS, FPGA development without a full toolchain that is able to provide
simulations in the backend is... horrific.
- Why: why not? I've always had a dream of learning things around FPGAs, so this is the perfect platform for doing this.
I'm mostly making things up as I go, without trying to peek at hte industry that much. After all, where would the fun be
if I just got the answers directly? Of course, some basic things were borrowed from literature. Briefly, my goals are as
follows:
    - Implement a von Neumann model "microprocessor", able to run BrainF\*ck, with code being input either via an
  attached serial monitor (boo! boring!), 3 buttons (we could make brainf\*ck even worse! Make the programmers write it
  in full binary! :) ), or, more likely, via an i2c-based system. But we'll get there.
- Still, why such a goal?
    - BF is an esoteric programming language. It's not meant to be taken seriously, or used professionally. So, one
    might wonder, why even try... *this*? Well, it all comes down to simplicity. With only 8 instructions (we'll call
    them opcodes) and a one-dimensional memory layout based on cells and pointers, as well as input and output streams
    of bytes, it's as simple of a "state machine" as you'll find. As a matter of fact, someone wrote a
    [BF compiler written in BF](https://github.com/canoon/bfbf). Perhaps in the future, I'll try to extend the platform
    to run a simpler architecture, such as the 8-bit AVR or the 4-bit 4509's that Renasas (still? maybe?) sells.
      - Seeing how easy it is to write a simple BF compiler / interpreter, having such a platform makes it relatively
      easy to develop for. Maybe?
    - Overall project goals are as follow (in a sort-of-ish-order):
        - [X] Implement basic ROM functionality - load a program "from the factory" and be able to reproduce it
        - [ ] Implement basic PROM functionality - be able to store / reprogram the data stored onto the chip
        - [ ] Implement the communication peripheral - whether that be UART, I2C or buttons and leds
        - [ ] Implement a memory management unit, able to run the RAM (details TBD)
        - [ ] Implement an ALU that is capable of running:
            - [ ] The 8 BF instructions
            - [ ] Address 255 memory cells (a far cry from the 30000) "minimum required cells", as seen on 
              [Wikipedia](https://w.wiki/STN), but something that can be humanly addressed within an 8-bit bus
        - [ ] Link everything together via an 8-bit bus, probably splitting address and data lines
## Devlog
- You'll find the devlog on this project's Wiki. Please, do keep in mind that this is my first contact with VHDL (or any
other hardware design language, for that matter), so things will be quite approximated.
