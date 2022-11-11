///////////////////////////////////////////////////////////////////////////////////
//                                            __ _      _     _                  //
//                                           / _(_)    | |   | |                 //
//                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |                 //
//               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |                 //
//              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |                 //
//               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|                 //
//                  | |                                                          //
//                  |_|                                                          //
//                                                                               //
//                                                                               //
//              Peripheral-NTM for MPSoC                                         //
//              Neural Turing Machine for MPSoC                                  //
//                                                                               //
///////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////
//                                                                               //
// Copyright (c) 2020-2024 by the author(s)                                      //
//                                                                               //
// Permission is hereby granted, free of charge, to any person obtaining a copy  //
// of this software and associated documentation files (the "Software"), to deal //
// in the Software without restriction, including without limitation the rights  //
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     //
// copies of the Software, and to permit persons to whom the Software is         //
// furnished to do so, subject to the following conditions:                      //
//                                                                               //
// The above copyright notice and this permission notice shall be included in    //
// all copies or substantial portions of the Software.                           //
//                                                                               //
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    //
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,      //
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE   //
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        //
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, //
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN     //
// THE SOFTWARE.                                                                 //
//                                                                               //
// ============================================================================= //
// Author(s):                                                                    //
//   Paco Reina Campo <pacoreinacampo@queenfield.tech>                           //
//                                                                               //
///////////////////////////////////////////////////////////////////////////////////

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#define SIZE_IN 3

double ntm_vector_adder(double *data_a_in, double *data_b_in) {

  double *data_out;

  int i;

  data_out = (double *) malloc(sizeof(int)*SIZE_IN);

  // calculating addition
  for (i = 0; i < SIZE_IN; i++) {
    data_out[i] = data_a_in[i] + data_b_in[i];
  }

  return *data_out;
}

int main() {

  double *data_a_in;
  double *data_b_in;

  double *data_out;

  data_a_in = (double *) malloc(sizeof(int)*SIZE_IN);
  data_b_in = (double *) malloc(sizeof(int)*SIZE_IN);

  data_out = (double *) malloc(sizeof(int)*SIZE_IN);

  data_a_in[0] = 2.0;
  data_a_in[1] = 0.0;
  data_a_in[2] = 4.0;

  data_b_in[0] = 1.0;
  data_b_in[1] = 1.0;
  data_b_in[2] = 2.0;

  data_out[0] = 3.0;
  data_out[1] = 1.0;
  data_out[2] = 6.0;

  assert(ntm_vector_adder(data_a_in, data_b_in)==*data_out);

  free(data_a_in);
  free(data_b_in);

  free(data_out);

  return 0;
}
