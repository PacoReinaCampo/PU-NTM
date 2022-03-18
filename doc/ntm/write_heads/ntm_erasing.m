%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#
%%                                            __ _      _     _                  %%
%%                                           / _(_)    | |   | |                 %%
%%                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |                 %%
%%               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |                 %%
%%              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |                 %%
%%               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|                 %%
%%                  | |                                                          %%
%%                  |_|                                                          %%
%%                                                                               %%
%%                                                                               %%
%%              Peripheral-NTM for MPSoC                                         %%
%%              Neural Turing Machine for MPSoC                                  %%
%%                                                                               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#
%%                                                                               %%
%% Copyright (c) 2022-2023 by the author(s)                                      %%
%%                                                                               %%
%% Permission is hereby granted, free of charge, to any person obtaining a copy  %%
%% of this software and associated documentation files (the "Software"), to deal %%
%% in the Software without restriction, including without limitation the rights  %%
%% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     %%
%% copies of the Software, and to permit persons to whom the Software is         %%
%% furnished to do so, subject to the following conditions:                      %%
%%                                                                               %%
%% The above copyright notice and this permission notice shall be included in    %%
%% all copies or substantial portions of the Software.                           %%
%%                                                                               %%
%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    %%
%% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,      %%
%% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE   %%
%% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        %%
%% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, %%
%% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN     %%
%% THE SOFTWARE.                                                                 %%
%%                                                                               %%
%% ============================================================================= %%
%% Author(s):                                                                    %%
%%   Francisco Javier Reina Campo <frareicam@gmail.com>                          %%
%%                                                                               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#

function M_OUT = ntm_writing(M_IN, W_IN, E_IN)
  [SIZE_N_IN, SIZE_W_IN] = size(M_IN);

  M_OUT = zeros(SIZE_N_IN, SIZE_W_IN);

  # M(t;j;k) = M(t;j;k)·(1 - w(t;j)·e(t;k))

  for j = 1:SIZE_N_IN
    for k = 1:SIZE_W_IN
      M_OUT(j, k) = M_IN(j, k)*(1-W_IN(j)*E_IN(k));
    endfor
  endfor

endfunction
