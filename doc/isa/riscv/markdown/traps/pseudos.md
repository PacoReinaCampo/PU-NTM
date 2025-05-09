## PSEUDO INSTRUCTIONS

Pseudo instructions in RISC-V are syntactic conveniences that do not directly correspond to machine instructions but are instead translated by the assembler into one or more actual instructions. They provide shortcuts for common operations or complex sequences that are otherwise tedious to express directly in the base ISA. Pseudo instructions aid software development by improving code readability and maintainability, abstracting low-level details while leveraging the underlying simplicity and power of the RISC-V ISA architecture.

Format of a line in the table:

`<pseudo opcode> <opcode> <format> <constraint...`

| pseudo        | opcode                   | format           | constraint                       |
|---------------|:-------------------------|:-----------------|:---------------------------------|
| `nop`         | `addi`                   | `none`           | `rd_eq_x0 rs1_eq_x0 imm_eq_zero` |
| `#lla,la`     | `{lui,slli,addi,addiw}`  | `rd,symbol`      |                                  |
| `#la`         | `auipc,{ld,lw}`          | `rd,symbol`      |                                  |
| `#lla,la`     | `auipc,addi`             | `rd,symbol`      |                                  |
| `#la.tls.gd`  | `auipc,addi`             | `rd,symbol`      |                                  |
| `#la.tls.ie`  | `auipc,{ld,lw}`          | `rd,symbol`      |                                  |
| `#li`         | `{lui,slli,addi,addiw}`  | `rd,rs1`         |                                  |
| `mv`          | `addi`                   | `rd,rs1`         | `imm_eq_zero`                    |
| `not`         | `xori`                   | `rd,rs1`         | `imm_eq_n1`                      |
| `neg`         | `sub`                    | `rd,rs2`         | `rs1_eq_x0`                      |
| `negw`        | `subw`                   | `rd,rs2`         | `rs1_eq_x0`                      |
| `sext.w`      | `addiw`                  | `rd,rs1`         | `imm_eq_zero`                    |
| `seqz`        | `sltiu`                  | `rd,rs1`         | `imm_eq_p1`                      |
| `snez`        | `sltu`                   | `rd,rs2`         | `rs1_eq_x0`                      |
| `sltz`        | `slt`                    | `rd,rs1`         | `rs2_eq_x0`                      |
| `sgtz`        | `slt`                    | `rd,rs2`         | `rs1_eq_x0`                      |
| `fmv.s`       | `fsgnj.s`                | `rd,rs1`         | `rs2_eq_rs1`                     |
| `fabs.s`      | `fsgnjx.s`               | `rd,rs1`         | `rs2_eq_rs1`                     |
| `fneg.s`      | `fsgnjn.s`               | `rd,rs1`         | `rs2_eq_rs1`                     |
| `fmv.d`       | `fsgnj.d`                | `rd,rs1`         | `rs2_eq_rs1`                     |
| `fabs.d`      | `fsgnjx.d`               | `rd,rs1`         | `rs2_eq_rs1`                     |
| `fneg.d`      | `fsgnjn.d`               | `rd,rs1`         | `rs2_eq_rs1`                     |
| `fmv.q`       | `fsgnj.q`                | `rd,rs1`         | `rs2_eq_rs1`                     |
| `fabs.q`      | `fsgnjx.q`               | `rd,rs1`         | `rs2_eq_rs1`                     |
| `fneg.q`      | `fsgnjn.q`               | `rd,rs1`         | `rs2_eq_rs1`                     |
| `beqz`        | `beq`                    | `rs1,offset`     | `rs2_eq_x0`                      |
| `bnez`        | `bne`                    | `rs1,offset`     | `rs2_eq_x0`                      |
| `blez`        | `bge`                    | `rs2,offset`     | `rs1_eq_x0`                      |
| `bgez`        | `bge`                    | `rs1,offset`     | `rs2_eq_x0`                      |
| `bltz`        | `blt`                    | `rs1,offset`     | `rs2_eq_x0`                      |
| `bgtz`        | `blt`                    | `rs2,offset`     | `rs1_eq_x0`                      |
| `ble`         | `bge`                    | `rs2,rs1,offset` |                                  |
| `bleu`        | `bgeu`                   | `rs2,rs1,offset` |                                  |
| `bgt`         | `blt`                    | `rs2,rs1,offset` |                                  |
| `bgtu`        | `bltu`                   | `rs2,rs1,offset` |                                  |
| `j`           | `jal`                    | `offset`         | `rd_eq_x0`                       |
| `jal`         | `jal`                    | `offset`         | `rd_eq_ra`                       |
| `ret`         | `jalr`                   | `none`           | `rd_eq_x0 rs1_eq_ra`             |
| `jr`          | `jalr`                   | `rs1`            | `rd_eq_x0 imm_eq_zero`           |
| `jalr`        | `jalr`                   | `rs1`            | `rd_eq_ra imm_eq_zero`           |
| `#call`       | `{auipc,jalr}`           | `offset`         |                                  |
| `#tail`       | `{auipc,jalr}`           | `offset`         |                                  |
| `rdcycle`     | `csrrs`                  | `rd`             | `rs1_eq_x0 csr_eq_0xc00`         |
| `rdtime`      | `csrrs`                  | `rd`             | `rs1_eq_x0 csr_eq_0xc01`         |
| `rdinstret`   | `csrrs`                  | `rd`             | `rs1_eq_x0 csr_eq_0xc02`         |
| `rdcycleh`    | `csrrs`                  | `rd`             | `rs1_eq_x0 csr_eq_0xc80`         |
| `rdtimeh`     | `csrrs`                  | `rd`             | `rs1_eq_x0 csr_eq_0xc81`         |
| `rdinstreth`  | `csrrs`                  | `rd`             | `rs1_eq_x0 csr_eq_0xc82`         |
| `frcsr`       | `csrrs`                  | `rd`             | `rs1_eq_x0 csr_eq_0x003`         |
| `frrm`        | `csrrs`                  | `rd`             | `rs1_eq_x0 csr_eq_0x002`         |
| `frflags`     | `csrrs`                  | `rd`             | `rs1_eq_x0 csr_eq_0x001`         |
| `fscsr`       | `csrrw`                  | `rd,rs1`         | `csr_eq_0x003`                   |
| `fsrm`        | `csrrw`                  | `rd,rs1`         | `csr_eq_0x002`                   |
| `fsflags`     | `csrrw`                  | `rd,rs1`         | `csr_eq_0x001`                   |
| `fsrmi`       | `csrrwi`                 | `rd,zimm`        | `csr_eq_0x002`                   |
| `fsflagsi`    | `csrrwi`                 | `rd,zimm`        | `csr_eq_0x001`                   |

:Pseudo Instructions
