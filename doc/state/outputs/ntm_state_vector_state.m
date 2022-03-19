%{
###################################################################################
##                                            __ _      _     _                  ##
##                                           / _(_)    | |   | |                 ##
##                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |                 ##
##               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |                 ##
##              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |                 ##
##               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|                 ##
##                  | |                                                          ##
##                  |_|                                                          ##
##                                                                               ##
##                                                                               ##
##              Peripheral-NTM for MPSoC                                         ##
##              Neural Turing Machine for MPSoC                                  ##
##                                                                               ##
###################################################################################

###################################################################################
##                                                                               ##
## Copyright (c) 2020-2024 by the author(s)                                      ##
##                                                                               ##
## Permission is hereby granted, free of charge, to any person obtaining a copy  ##
## of this software and associated documentation files (the "Software"), to deal ##
## in the Software without restriction, including without limitation the rights  ##
## to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     ##
## copies of the Software, and to permit persons to whom the Software is         ##
## furnished to do so, subject to the following conditions:                      ##
##                                                                               ##
## The above copyright notice and this permission notice shall be included in    ##
## all copies or substantial portions of the Software.                           ##
##                                                                               ##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    ##
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,      ##
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE   ##
## AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        ##
## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, ##
## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN     ##
## THE SOFTWARE.                                                                 ##
##                                                                               ##
## ============================================================================= ##
## Author(s):                                                                    ##
##   Francisco Javier Reina Campo <frareicam@gmail.com>                          ##
##                                                                               ##
###################################################################################
%}

function DATA_X_OUT = ntm_state_vector_state(DATA_K_IN, DATA_A_IN, DATA_B_IN, DATA_C_IN, DATA_D_IN, DATA_U_IN, k)
  [SIZE_A_I_IN, SIZE_A_J_IN] = size(DATA_A_IN);
  [SIZE_B_I_IN, SIZE_B_J_IN] = size(DATA_B_IN);
  [SIZE_C_I_IN, SIZE_C_J_IN] = size(DATA_C_IN);
  [SIZE_D_I_IN, SIZE_D_J_IN] = size(DATA_D_IN);
  
  INITIAL_X = zeros(SIZE_A_I_IN, 1);

  % x(k) = exp(A,k)�x(0) + summation(exp(A,k-j-1)�B�u(j))[j in 0 to k-1]

  DATA_X_OUT = zeros(SIZE_A_I_IN, 1);

  DATA_X_OUT = (DATA_A_IN^k)*INITIAL_X;

  for j = 1:k
    DATA_X_OUT = DATA_X_OUT + DATA_C_IN*(DATA_A_IN^(k-j-1))*DATA_B_IN*DATA_U_IN(:, k);
  end
end