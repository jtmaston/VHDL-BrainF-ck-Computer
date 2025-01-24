GHDL = ghdl
BUILDFLAGS = --workdir=build --work=build --std=08

AddressDecoder_tb_deps 	= MemoryCell/AddressDecoder.vhd
RAM_tb_deps				= MemoryCell/RAM/RAM_Cell.vhd MemoryCell/AddressDecoder.vhd MemoryCell/RAM/RAM.vhd
ROM_tb_deps				= MemoryCell/ROM/ROM_Cell.vhd MemoryCell/AddressDecoder.vhd MemoryCell/ROM/ROM.vhd 

targets := AddressDecoder_tb RAM_tb ROM_tb

all: $(targets)

clean:
	rm -rf build/*
	rm -rf Waves/*

$(targets):
	@$(GHDL) -a $(BUILDFLAGS) $($@_deps) Testbenches/$@.vhd
	@$(GHDL) --elab-run $(BUILDFLAGS) -o build/$@ $@ --wave=Waves/$@.ghw --stop-time=100us

