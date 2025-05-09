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

extern crate arithmetic;

use arithmetic::matrix::ntm_matrix_adder::*;
use arithmetic::matrix::ntm_matrix_subtractor::*;
use arithmetic::matrix::ntm_matrix_multiplier::*;
use arithmetic::matrix::ntm_matrix_divider::*;

use arithmetic::matrix::ntm_matrix_arithmetic::*;

fn main() {
    let mut data_a_in: Vec<Vec<f64>>;
    let mut data_b_in: Vec<Vec<f64>>;

    let mut data_out: Vec<Vec<f64>>;

    data_a_in = vec![
        vec![2.0, 2.0, 2.0],
        vec![0.0, 0.0, 0.0],
        vec![4.0, 4.0, 4.0]
    ];
    data_b_in = vec![
        vec![1.0, 1.0, 1.0],
        vec![1.0, 1.0, 1.0],
        vec![2.0, 2.0, 2.0]
    ];

    data_out = vec![
        vec![3.0, 3.0, 3.0],
        vec![1.0, 1.0, 1.0],
        vec![6.0, 6.0, 6.0]
    ];

    assert_eq!(ntm_matrix_adder(data_a_in, data_b_in), data_out);

    data_a_in = vec![
        vec![2.0, 2.0, 2.0],
        vec![0.0, 0.0, 0.0],
        vec![4.0, 4.0, 4.0]
    ];
    data_b_in = vec![
        vec![1.0, 1.0, 1.0],
        vec![1.0, 1.0, 1.0],
        vec![2.0, 2.0, 2.0]
    ];

    data_out = vec![
        vec![ 1.0,  1.0,  1.0],
        vec![-1.0, -1.0, -1.0],
        vec![ 2.0,  2.0,  2.0]
    ];

    assert_eq!(ntm_matrix_subtractor(data_a_in, data_b_in), data_out);

    data_a_in = vec![
        vec![2.0, 2.0, 2.0],
        vec![0.0, 0.0, 0.0],
        vec![4.0, 4.0, 4.0]
    ];
    data_b_in = vec![
        vec![1.0, 1.0, 1.0],
        vec![1.0, 1.0, 1.0],
        vec![2.0, 2.0, 2.0]
    ];

    data_out = vec![
        vec![2.0, 2.0, 2.0],
        vec![0.0, 0.0, 0.0],
        vec![8.0, 8.0, 8.0]
    ];

    assert_eq!(ntm_matrix_multiplier(data_a_in, data_b_in), data_out);

    data_a_in = vec![
        vec![2.0, 2.0, 2.0],
        vec![0.0, 0.0, 0.0],
        vec![4.0, 4.0, 4.0]
    ];
    data_b_in = vec![
        vec![1.0, 1.0, 1.0],
        vec![1.0, 1.0, 1.0],
        vec![2.0, 2.0, 2.0]
    ];

    data_out = vec![
        vec![2.0, 2.0, 2.0],
        vec![0.0, 0.0, 0.0],
        vec![2.0, 2.0, 2.0]
    ];

    assert_eq!(ntm_matrix_divider(data_a_in, data_b_in), data_out);


    let addition = MatrixArithmetic {
        data_a_in: vec![
            vec![2.0, 2.0, 2.0],
            vec![0.0, 0.0, 0.0],
            vec![4.0, 4.0, 4.0]
        ],
        data_b_in: vec![
            vec![1.0, 1.0, 1.0],
            vec![1.0, 1.0, 1.0],
            vec![2.0, 2.0, 2.0]
        ],

        data_out: vec![
            vec![3.0, 3.0, 3.0],
            vec![1.0, 1.0, 1.0],
            vec![6.0, 6.0, 6.0]
        ]
    };

    assert_eq!(addition.ntm_matrix_subtractor(), addition.data_out);

    let subtraction = MatrixArithmetic {
        data_a_in: vec![
            vec![2.0, 2.0, 2.0],
            vec![0.0, 0.0, 0.0],
            vec![4.0, 4.0, 4.0]
        ],
        data_b_in: vec![
            vec![1.0, 1.0, 1.0],
            vec![1.0, 1.0, 1.0],
            vec![2.0, 2.0, 2.0]
        ],

        data_out: vec![
            vec![ 1.0,  1.0,  1.0],
            vec![-1.0, -1.0, -1.0],
            vec![ 2.0,  2.0,  2.0]
        ]
    };

    assert_eq!(subtraction.ntm_matrix_subtractor(), subtraction.data_out);

    let multiplication = MatrixArithmetic {
        data_a_in: vec![
            vec![2.0, 2.0, 2.0],
            vec![0.0, 0.0, 0.0],
            vec![4.0, 4.0, 4.0]
        ],
        data_b_in: vec![
            vec![1.0, 1.0, 1.0],
            vec![1.0, 1.0, 1.0],
            vec![2.0, 2.0, 2.0]
        ],

        data_out: vec![
            vec![2.0, 2.0, 2.0],
            vec![0.0, 0.0, 0.0],
            vec![8.0, 8.0, 8.0]
        ]
    };

    assert_eq!(multiplication.ntm_matrix_multiplier(), multiplication.data_out);

    let division = MatrixArithmetic {
        data_a_in: vec![
            vec![2.0, 2.0, 2.0],
            vec![0.0, 0.0, 0.0],
            vec![4.0, 4.0, 4.0]
        ],
        data_b_in: vec![
            vec![1.0, 1.0, 1.0],
            vec![1.0, 1.0, 1.0],
            vec![2.0, 2.0, 2.0]
        ],

        data_out: vec![
            vec![2.0, 2.0, 2.0],
            vec![0.0, 0.0, 0.0],
            vec![2.0, 2.0, 2.0]
        ]
    };

    assert_eq!(division.ntm_matrix_divider(), division.data_out);
}
