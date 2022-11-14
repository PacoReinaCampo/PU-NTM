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

pub fn ntm_matrix_vector_convolution(data_a_in: Vec<Vec<f64>>, data_b_in: Vec<Vec<f64>>) -> Vec<Vec<f64>> {
    // Multiply two matching matrices.
    let mut data_out: Vec<Vec<f64>> = vec![];

    for i in 0..data_a_in.len() {
        let mut vector: Vec<f64> = vec![];

        if data_a_in[i].len() != data_b_in.len() {
            panic!("Matrix dimensions do not match");
        }

        for j in 0..data_b_in[0].len() {
            let mut temporal: f64 = 0.0;

            for m in 0..i+1 {
                for n in 0..j+1 {
                    if data_b_in[0].len() != data_b_in[m].len() {
                        panic!("Matrix dimensions do not match");
                    }
                    temporal += data_a_in[m][n] * data_b_in[i-m][j-n];
                }
            }
            vector.push(temporal);
        }
        data_out.push(vector);
    }
    data_out
}

fn main() {
    let data_a_in: Vec<Vec<f64>> = vec![
        vec![1.0, 2.0, 3.0],
        vec![4.0, 2.0, 6.0],
        vec![3.0, 4.0, 1.0],
        vec![2.0, 4.0, 8.0]
    ];
    let data_b_in: Vec<Vec<f64>> = vec![
        vec![1.0],
        vec![7.0],
        vec![3.0]
    ];

    let data_out: Vec<Vec<f64>> = vec![
        vec![24.0],
        vec![36.0],
        vec![34.0],
        vec![54.0]
    ];

    assert_eq!(ntm_matrix_vector_convolution(data_a_in, data_b_in), data_out);
}
