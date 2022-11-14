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

#include<iostream>
#include<math.h>
#include<vector>
#include<cassert>

using namespace std;

vector<vector<double>> ntm_matrix_differentiation(vector<vector<double>> data_in, double length_i_in, double length_j_in, int control) {

  double temporal;

  vector<vector<double>> data_out;

  for (int i = 0; i < data_in.size(); i++) {
    vector<double> vector;

    for (int j = 0; j < data_in[0].size(); j++) {
      if (control == 0) {
        if (i == 0) {
          temporal = 0.0;
        }
        else {
          temporal = (data_in[i][j] - data_in[i-1][j])/length_i_in;
        }
      }
      else {
        if (j == 0) {
          temporal = 0.0;
        }
        else {
          temporal = (data_in[i][j] - data_in[i][j-1])/length_j_in;
        }
      }
      vector.push_back(temporal);
    }
    data_out.push_back(vector);
  }

  return data_out;
}

int main() {
  vector<vector<double>> data_in {
    { 6.3226113886226751, 3.1313826152262876, 8.3512687816132226 },
    { 4.3132651822261687, 5.3132616875182226, 6.6931471805599454 },
    { 9.9982079678583020, 7.9581688450893644, 2.9997639589554603 },
  };

  vector<vector<double>> data_out {
    { 0.0, -3.1912287733963870,  5.2198861663869350 },
    { 0.0,  0.9999965052920539,  1.3798854930417228 },
    { 0.0, -2.0400391227689383, -4.9584048861339040 }
  };

  assert(ntm_matrix_differentiation(data_in, 1.0, 1.0, 1)==data_out);

  return 0;
}
