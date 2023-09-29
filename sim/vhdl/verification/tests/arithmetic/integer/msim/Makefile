TARGET = accelerator_scalar_integer_adder_test

all: build

build:
	vsim -c -do macros/run.do
	
simulate:
	vsim -view wlf/$(TARGET)_test.wlf -do waves/$(TARGET).do

clean:
	rm -rf work wlf transcript *.vstf *.wlf
