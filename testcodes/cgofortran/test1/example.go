package main

/*
// function func1(v_float, v_double) result(i_int)
//int func1(float, double);
int func1(float*, double*);

// subroutine sub1(v_float_in, v_float_inout, v_float_out)
//void sub1(float, float*, float*);
void sub1(float*, float*, float*);
*/
import "C"

import "fmt"

func main() {
	// func1
	var v1 C.float = 1.
	var v2 C.double = 2.

	i := C.func1(&v1, &v2)
	fmt.Println(i)

	// sub1
	var c1, c2, c3 C.float
	c1, c2, c3 = 1., 2., 3.

	fmt.Println(c1, c2, c3)

	C.sub1(&c1, &c2, &c3)

	fmt.Println(c1, c2, c3)
}
