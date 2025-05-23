## OPCODE ENCODING STRUCTURED INFORMATION

Opcodes in RISC-V are structured within instruction encoding formats, defining fields such as opcode itself, function codes (`funct3`, `funct7`), immediate values, and register specifiers (`rd`, `rs1`, `rs2`). Structured information ensures consistent interpretation and execution across different implementations and extensions of the RISC-V ISA, supporting modularity and compatibility.

Format of a line in the table:

`<instruction name> [<arguments> ...] <opcode> <codec> <extension>`

`<arguments> is one of rd, rs1, rs2, frd, frs1, frs2, frs3, imm20, imm12, sbimm12, simm12, shamt5, shamt6, rm, aq, rl, pred, succ`

`<opcode> is given by specifying one or more range/value pairs: hi..lo=value or bit=value or argument=value (e.g. 6..2=0x45 10=1)`

`<codec> is one of r, i, s, sb, u, uj, ...`

`<extension> is one of { rv32, rv64, rv128 } · { i, m, a, f, d, s, c }`

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `lui`        | `rd imm20`            |                    `6..2=0x0D 1..0=3`                                              | `u`          | `rv32i rv64i rv128i` |
| `auipc`      | `rd oimm20`           |                    `6..2=0x05 1..0=3`                                              | `u+o`        | `rv32i rv64i rv128i` |
| `jal`        | `rd jimm20`           |                    `6..2=0x1b 1..0=3`                                              | `uj`         | `rv32i rv64i rv128i` |
| `jalr`       | `rd rs1 oimm12`       |           `14..12=0 6..2=0x19 1..0=3`                                              | `i+o`        | `rv32i rv64i rv128i` |
| `beq`        | `rs1 rs2 sbimm12`     |           `14..12=0 6..2=0x18 1..0=3`                                              | `sb`         | `rv32i rv64i rv128i` |
| `bne`        | `rs1 rs2 sbimm12`     |           `14..12=1 6..2=0x18 1..0=3`                                              | `sb`         | `rv32i rv64i rv128i` |
| `blt`        | `rs1 rs2 sbimm12`     |           `14..12=4 6..2=0x18 1..0=3`                                              | `sb`         | `rv32i rv64i rv128i` |
| `bge`        | `rs1 rs2 sbimm12`     |           `14..12=5 6..2=0x18 1..0=3`                                              | `sb`         | `rv32i rv64i rv128i` |
| `bltu`       | `rs1 rs2 sbimm12`     |           `14..12=6 6..2=0x18 1..0=3`                                              | `sb`         | `rv32i rv64i rv128i` |
| `bgeu`       | `rs1 rs2 sbimm12`     |           `14..12=7 6..2=0x18 1..0=3`                                              | `sb`         | `rv32i rv64i rv128i` |
| `lb`         | `rd rs1 oimm12`       |           `14..12=0 6..2=0x00 1..0=3`                                              | `i+l`        | `rv32i rv64i rv128i` |
| `lh`         | `rd rs1 oimm12`       |           `14..12=1 6..2=0x00 1..0=3`                                              | `i+l`        | `rv32i rv64i rv128i` |
| `lw`         | `rd rs1 oimm12`       |           `14..12=2 6..2=0x00 1..0=3`                                              | `i+l`        | `rv32i rv64i rv128i` |
| `lbu`        | `rd rs1 oimm12`       |           `14..12=4 6..2=0x00 1..0=3`                                              | `i+l`        | `rv32i rv64i rv128i` |
| `lhu`        | `rd rs1 oimm12`       |           `14..12=5 6..2=0x00 1..0=3`                                              | `i+l`        | `rv32i rv64i rv128i` |
| `sb`         | `rs1 rs2 simm12`      |           `14..12=0 6..2=0x08 1..0=3`                                              | `s`          | `rv32i rv64i rv128i` |
| `sh`         | `rs1 rs2 simm12`      |           `14..12=1 6..2=0x08 1..0=3`                                              | `s`          | `rv32i rv64i rv128i` |
| `sw`         | `rs1 rs2 simm12`      |           `14..12=2 6..2=0x08 1..0=3`                                              | `s`          | `rv32i rv64i rv128i` |
| `addi`       | `rd rs1 imm12`        |           `14..12=0 6..2=0x04 1..0=3`                                              | `i`          | `rv32i rv64i rv128i` |
| `slti`       | `rd rs1 imm12`        |           `14..12=2 6..2=0x04 1..0=3`                                              | `i`          | `rv32i rv64i rv128i` |
| `sltiu`      | `rd rs1 imm12`        |           `14..12=3 6..2=0x04 1..0=3`                                              | `i`          | `rv32i rv64i rv128i` |
| `xori`       | `rd rs1 imm12`        |           `14..12=4 6..2=0x04 1..0=3`                                              | `i`          | `rv32i rv64i rv128i` |
| `ori`        | `rd rs1 imm12`        |           `14..12=6 6..2=0x04 1..0=3`                                              | `i`          | `rv32i rv64i rv128i` |
| `andi`       | `rd rs1 imm12`        |           `14..12=7 6..2=0x04 1..0=3`                                              | `i`          | `rv32i rv64i rv128i` |
| `slli`       | `rd rs1 shamt5`       | `31..27=0  14..12=1 6..2=0x04 1..0=3`                                              | `i·sh5`      | `rv32i`              |
| `srli`       | `rd rs1 shamt5`       | `31..27=0  14..12=5 6..2=0x04 1..0=3`                                              | `i·sh5`      | `rv32i`              |
| `srai`       | `rd rs1 shamt5`       | `31..27=8  14..12=5 6..2=0x04 1..0=3`                                              | `i·sh5`      | `rv32i`              |
| `add`        | `rd rs1 rs2`          | `31..25=0  14..12=0 6..2=0x0C 1..0=3`                                              | `r`          | `rv32i rv64i rv128i` |
| `sub`        | `rd rs1 rs2`          | `31..25=32 14..12=0 6..2=0x0C 1..0=3`                                              | `r`          | `rv32i rv64i rv128i` |
| `sll`        | `rd rs1 rs2`          | `31..25=0  14..12=1 6..2=0x0C 1..0=3`                                              | `r`          | `rv32i rv64i rv128i` |
| `slt`        | `rd rs1 rs2`          | `31..25=0  14..12=2 6..2=0x0C 1..0=3`                                              | `r`          | `rv32i rv64i rv128i` |
| `sltu`       | `rd rs1 rs2`          | `31..25=0  14..12=3 6..2=0x0C 1..0=3`                                              | `r`          | `rv32i rv64i rv128i` |
| `xor`        | `rd rs1 rs2`          | `31..25=0  14..12=4 6..2=0x0C 1..0=3`                                              | `r`          | `rv32i rv64i rv128i` |
| `srl`        | `rd rs1 rs2`          | `31..25=0  14..12=5 6..2=0x0C 1..0=3`                                              | `r`          | `rv32i rv64i rv128i` |
| `sra`        | `rd rs1 rs2`          | `31..25=32 14..12=5 6..2=0x0C 1..0=3`                                              | `r`          | `rv32i rv64i rv128i` |
| `or`         | `rd rs1 rs2`          | `31..25=0  14..12=6 6..2=0x0C 1..0=3`                                              | `r`          | `rv32i rv64i rv128i` |
| `and`        | `rd rs1 rs2`          | `31..25=0  14..12=7 6..2=0x0C 1..0=3`                                              | `r`          | `rv32i rv64i rv128i` |
| `fence`      |                       | `31..28=ignore pred succ     19..15=ignore 14..12=0 11..7=ignore 6..2=0x03 1..0=3` | `r·f`        | `rv32i rv64i rv128i` |
| `fence.i`    |                       | `31..28=ignore 27..20=ignore 19..15=ignore 14..12=1 11..7=ignore 6..2=0x03 1..0=3` | `none`       | `rv32i rv64i rv128i` |

:RV32I - "RV32I Base Integer Instruction Set"

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `lwu`        | `rd rs1 oimm12`       |           `14..12=6 6..2=0x00 1..0=3`                                              | `i+l`        |       `rv64i rv128i` |
| `ld`         | `rd rs1 oimm12`       |           `14..12=3 6..2=0x00 1..0=3`                                              | `i+l`        |       `rv64i rv128i` |
| `sd`         | `rs1 rs2 simm12`      |           `14..12=3 6..2=0x08 1..0=3`                                              | `s`          |       `rv64i rv128i` |
| `slli`       | `rd rs1 shamt6`       | `31..27=0  14..12=1 6..2=0x04 1..0=3`                                              | `i·sh6`      |       `rv64i`        |
| `srli`       | `rd rs1 shamt6`       | `31..27=0  14..12=5 6..2=0x04 1..0=3`                                              | `i·sh6`      |       `rv64i`        |
| `srai`       | `rd rs1 shamt6`       | `31..27=8  14..12=5 6..2=0x04 1..0=3`                                              | `i·sh6`      |       `rv64i`        |
| `addiw`      | `rd rs1 imm12`        |           `14..12=0 6..2=0x06 1..0=3`                                              | `i`          |       `rv64i rv128i` |
| `slliw`      | `rd rs1 shamt5`       | `31..25=0  14..12=1 6..2=0x06 1..0=3`                                              | `i·sh5`      |       `rv64i rv128i` |
| `srliw`      | `rd rs1 shamt5`       | `31..25=0  14..12=5 6..2=0x06 1..0=3`                                              | `i·sh5`      |       `rv64i rv128i` |
| `sraiw`      | `rd rs1 shamt5`       | `31..25=32 14..12=5 6..2=0x06 1..0=3`                                              | `i·sh5`      |       `rv64i rv128i` |
| `addw`       | `rd rs1 rs2`          | `31..25=0  14..12=0 6..2=0x0E 1..0=3`                                              | `r`          |       `rv64i rv128i` |
| `subw`       | `rd rs1 rs2`          | `31..25=32 14..12=0 6..2=0x0E 1..0=3`                                              | `r`          |       `rv64i rv128i` |
| `sllw`       | `rd rs1 rs2`          | `31..25=0  14..12=1 6..2=0x0E 1..0=3`                                              | `r`          |       `rv64i rv128i` |
| `srlw`       | `rd rs1 rs2`          | `31..25=0  14..12=5 6..2=0x0E 1..0=3`                                              | `r`          |       `rv64i rv128i` |
| `sraw`       | `rd rs1 rs2`          | `31..25=32 14..12=5 6..2=0x0E 1..0=3`                                              | `r`          |       `rv64i rv128i` |

:RV64I - "RV64I Base Integer Instruction Set (+ RV32I)"

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `ldu`        | `rd rs1 oimm12`       |           `14..12=7 6..2=0x00 1..0=3`                                              | `i+l`        |             `rv128i` |
| `lq`         | `rd rs1 oimm12`       |           `14..12=2 6..2=0x03 1..0=3`                                              | `i+l`        |             `rv128i` |
| `sq`         | `rs1 rs2 simm12`      |           `14..12=4 6..2=0x08 1..0=3`                                              | `s`          |             `rv128i` |
| `slli`       | `rd rs1 shamt7`       | `31..27=0  14..12=1 6..2=0x04 1..0=3`                                              | `i·sh7`      |             `rv128i` |
| `srli`       | `rd rs1 shamt7`       | `31..27=0  14..12=5 6..2=0x04 1..0=3`                                              | `i·sh7`      |             `rv128i` |
| `srai`       | `rd rs1 shamt7`       | `31..27=8  14..12=5 6..2=0x04 1..0=3`                                              | `i·sh7`      |             `rv128i` |
| `addid`      | `rd rs1 imm12`        |           `14..12=0 6..2=0x16 1..0=3`                                              | `i`          |             `rv128i` |
| `sllid`      | `rd rs1 shamt6`       | `31..26=0  14..12=1 6..2=0x16 1..0=3`                                              | `i·sh6`      |             `rv128i` |
| `srlid`      | `rd rs1 shamt6`       | `31..26=0  14..12=5 6..2=0x16 1..0=3`                                              | `i·sh6`      |             `rv128i` |
| `sraid`      | `rd rs1 shamt6`       | `31..26=16 14..12=5 6..2=0x16 1..0=3`                                              | `i·sh6`      |             `rv128i` |
| `addd`       | `rd rs1 rs2`          | `31..25=0  14..12=0 6..2=0x1E 1..0=3`                                              | `r`          |             `rv128i` |
| `subd`       | `rd rs1 rs2`          | `31..25=32 14..12=0 6..2=0x1E 1..0=3`                                              | `r`          |             `rv128i` |
| `slld`       | `rd rs1 rs2`          | `31..25=0  14..12=1 6..2=0x1E 1..0=3`                                              | `r`          |             `rv128i` |
| `srld`       | `rd rs1 rs2`          | `31..25=0  14..12=5 6..2=0x1E 1..0=3`                                              | `r`          |             `rv128i` |
| `srad`       | `rd rs1 rs2`          | `31..25=32 14..12=5 6..2=0x1E 1..0=3`                                              | `r`          |             `rv128i` |

:RV128I - "RV128I Base Integer Instruction Set (+ RV64I)"

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `mul`        | `rd rs1 rs2`          | `31..25=1 14..12=0 6..2=0x0C 1..0=3`                                               | `r`          | `rv32m rv64m rv128m` |
| `mulh`       | `rd rs1 rs2`          | `31..25=1 14..12=1 6..2=0x0C 1..0=3`                                               | `r`          | `rv32m rv64m rv128m` |
| `mulhsu`     | `rd rs1 rs2`          | `31..25=1 14..12=2 6..2=0x0C 1..0=3`                                               | `r`          | `rv32m rv64m rv128m` |
| `mulhu`      | `rd rs1 rs2`          | `31..25=1 14..12=3 6..2=0x0C 1..0=3`                                               | `r`          | `rv32m rv64m rv128m` |
| `div`        | `rd rs1 rs2`          | `31..25=1 14..12=4 6..2=0x0C 1..0=3`                                               | `r`          | `rv32m rv64m rv128m` |
| `divu`       | `rd rs1 rs2`          | `31..25=1 14..12=5 6..2=0x0C 1..0=3`                                               | `r`          | `rv32m rv64m rv128m` |
| `rem`        | `rd rs1 rs2`          | `31..25=1 14..12=6 6..2=0x0C 1..0=3`                                               | `r`          | `rv32m rv64m rv128m` |
| `remu`       | `rd rs1 rs2`          | `31..25=1 14..12=7 6..2=0x0C 1..0=3`                                               | `r`          | `rv32m rv64m rv128m` |

:RV32M - "RV32M Standard Extension for Integer Multiply and Divide"

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `mulw`       | `rd rs1 rs2`          | `31..25=1 14..12=0 6..2=0x0E 1..0=3`                                               | `r`          |       `rv64m rv128m` |
| `divw`       | `rd rs1 rs2`          | `31..25=1 14..12=4 6..2=0x0E 1..0=3`                                               | `r`          |       `rv64m rv128m` |
| `divuw`      | `rd rs1 rs2`          | `31..25=1 14..12=5 6..2=0x0E 1..0=3`                                               | `r`          |       `rv64m rv128m` |
| `remw`       | `rd rs1 rs2`          | `31..25=1 14..12=6 6..2=0x0E 1..0=3`                                               | `r`          |       `rv64m rv128m` |
| `remuw`      | `rd rs1 rs2`          | `31..25=1 14..12=7 6..2=0x0E 1..0=3`                                               | `r`          |       `rv64m rv128m` |

:RV64M - "RV64M Standard Extension for Integer Multiply and Divide (+ RV32M)"

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `muld`       | `rd rs1 rs2`          | `31..25=1 14..12=0 6..2=0x1E 1..0=3`                                               | `r`          |             `rv128m` |
| `divd`       | `rd rs1 rs2`          | `31..25=1 14..12=4 6..2=0x1E 1..0=3`                                               | `r`          |             `rv128m` |
| `divud`      | `rd rs1 rs2`          | `31..25=1 14..12=5 6..2=0x1E 1..0=3`                                               | `r`          |             `rv128m` |
| `remd`       | `rd rs1 rs2`          | `31..25=1 14..12=6 6..2=0x1E 1..0=3`                                               | `r`          |             `rv128m` |
| `remud`      | `rd rs1 rs2`          | `31..25=1 14..12=7 6..2=0x1E 1..0=3`                                               | `r`          |             `rv128m` |

:RV128M - "RV128M Standard Extension for Integer Multiply and Divide (+ RV64M)"

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `lr.w`       | `rd rs1 24..20=0`     | `aq rl 31..29=0 28..27=2 14..12=2 6..2=0x0B 1..0=3`                                | `r·l`        | `rv32a rv64a rv128a` |
| `sc.w`       | `rd rs1 rs2`          | `aq rl 31..29=0 28..27=3 14..12=2 6..2=0x0B 1..0=3`                                | `r·a`        | `rv32a rv64a rv128a` |
| `amoswap.w`  | `rd rs1 rs2`          | `aq rl 31..29=0 28..27=1 14..12=2 6..2=0x0B 1..0=3`                                | `r·a`        | `rv32a rv64a rv128a` |
| `amoadd.w`   | `rd rs1 rs2`          | `aq rl 31..29=0 28..27=0 14..12=2 6..2=0x0B 1..0=3`                                | `r·a`        | `rv32a rv64a rv128a` |
| `amoxor.w`   | `rd rs1 rs2`          | `aq rl 31..29=1 28..27=0 14..12=2 6..2=0x0B 1..0=3`                                | `r·a`        | `rv32a rv64a rv128a` |
| `amoor.w`    | `rd rs1 rs2`          | `aq rl 31..29=2 28..27=0 14..12=2 6..2=0x0B 1..0=3`                                | `r·a`        | `rv32a rv64a rv128a` |
| `amoand.w`   | `rd rs1 rs2`          | `aq rl 31..29=3 28..27=0 14..12=2 6..2=0x0B 1..0=3`                                | `r·a`        | `rv32a rv64a rv128a` |
| `amomin.w`   | `rd rs1 rs2`          | `aq rl 31..29=4 28..27=0 14..12=2 6..2=0x0B 1..0=3`                                | `r·a`        | `rv32a rv64a rv128a` |
| `amomax.w`   | `rd rs1 rs2`          | `aq rl 31..29=5 28..27=0 14..12=2 6..2=0x0B 1..0=3`                                | `r·a`        | `rv32a rv64a rv128a` |
| `amominu.w`  | `rd rs1 rs2`          | `aq rl 31..29=6 28..27=0 14..12=2 6..2=0x0B 1..0=3`                                | `r·a`        | `rv32a rv64a rv128a` |
| `amomaxu.w`  | `rd rs1 rs2`          | `aq rl 31..29=7 28..27=0 14..12=2 6..2=0x0B 1..0=3`                                | `r·a`        | `rv32a rv64a rv128a` |

:RV32A - "RV32A Standard Extension for Atomic Instructions"

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `lr.d`       | `rd rs1 24..20=0`     | `aq rl 31..29=0 28..27=2 14..12=3 6..2=0x0B 1..0=3`                                | `r·l`        |       `rv64a rv128a` |
| `sc.d`       | `rd rs1 rs2`          | `aq rl 31..29=0 28..27=3 14..12=3 6..2=0x0B 1..0=3`                                | `r·a`        |       `rv64a rv128a` |
| `amoswap.d`  | `rd rs1 rs2`          | `aq rl 31..29=0 28..27=1 14..12=3 6..2=0x0B 1..0=3`                                | `r·a`        |       `rv64a rv128a` |
| `amoadd.d`   | `rd rs1 rs2`          | `aq rl 31..29=0 28..27=0 14..12=3 6..2=0x0B 1..0=3`                                | `r·a`        |       `rv64a rv128a` |
| `amoxor.d`   | `rd rs1 rs2`          | `aq rl 31..29=1 28..27=0 14..12=3 6..2=0x0B 1..0=3`                                | `r·a`        |       `rv64a rv128a` |
| `amoor.d`    | `rd rs1 rs2`          | `aq rl 31..29=2 28..27=0 14..12=3 6..2=0x0B 1..0=3`                                | `r·a`        |       `rv64a rv128a` |
| `amoand.d`   | `rd rs1 rs2`          | `aq rl 31..29=3 28..27=0 14..12=3 6..2=0x0B 1..0=3`                                | `r·a`        |       `rv64a rv128a` |
| `amomin.d`   | `rd rs1 rs2`          | `aq rl 31..29=4 28..27=0 14..12=3 6..2=0x0B 1..0=3`                                | `r·a`        |       `rv64a rv128a` |
| `amomax.d`   | `rd rs1 rs2`          | `aq rl 31..29=5 28..27=0 14..12=3 6..2=0x0B 1..0=3`                                | `r·a`        |       `rv64a rv128a` |
| `amominu.d`  | `rd rs1 rs2`          | `aq rl 31..29=6 28..27=0 14..12=3 6..2=0x0B 1..0=3`                                | `r·a`        |       `rv64a rv128a` |
| `amomaxu.d`  | `rd rs1 rs2`          | `aq rl 31..29=7 28..27=0 14..12=3 6..2=0x0B 1..0=3`                                | `r·a`        |       `rv64a rv128a` |

:RV64A - "RV64A Standard Extension for Atomic Instructions (+ RV32A)"

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `lr.q`       | `rd rs1 24..20=0`     | `aq rl 31..29=0 28..27=2 14..12=4 6..2=0x0B 1..0=3`                                | `r·l`        |             `rv128a` |
| `sc.q`       | `rd rs1 rs2`          | `aq rl 31..29=0 28..27=3 14..12=4 6..2=0x0B 1..0=3`                                | `r·a`        |             `rv128a` |
| `amoswap.q`  | `rd rs1 rs2`          | `aq rl 31..29=0 28..27=1 14..12=4 6..2=0x0B 1..0=3`                                | `r·a`        |             `rv128a` |
| `amoadd.q`   | `rd rs1 rs2`          | `aq rl 31..29=0 28..27=0 14..12=4 6..2=0x0B 1..0=3`                                | `r·a`        |             `rv128a` |
| `amoxor.q`   | `rd rs1 rs2`          | `aq rl 31..29=1 28..27=0 14..12=4 6..2=0x0B 1..0=3`                                | `r·a`        |             `rv128a` |
| `amoor.q`    | `rd rs1 rs2`          | `aq rl 31..29=2 28..27=0 14..12=4 6..2=0x0B 1..0=3`                                | `r·a`        |             `rv128a` |
| `amoand.q`   | `rd rs1 rs2`          | `aq rl 31..29=3 28..27=0 14..12=4 6..2=0x0B 1..0=3`                                | `r·a`        |             `rv128a` |
| `amomin.q`   | `rd rs1 rs2`          | `aq rl 31..29=4 28..27=0 14..12=4 6..2=0x0B 1..0=3`                                | `r·a`        |             `rv128a` |
| `amomax.q`   | `rd rs1 rs2`          | `aq rl 31..29=5 28..27=0 14..12=4 6..2=0x0B 1..0=3`                                | `r·a`        |             `rv128a` |
| `amominu.q`  | `rd rs1 rs2`          | `aq rl 31..29=6 28..27=0 14..12=4 6..2=0x0B 1..0=3`                                | `r·a`        |             `rv128a` |
| `amomaxu.q`  | `rd rs1 rs2`          | `aq rl 31..29=7 28..27=0 14..12=4 6..2=0x0B 1..0=3`                                | `r·a`        |             `rv128a` |

:RV128A - "RV128A Standard Extension for Atomic Instructions (+ RV64A)"

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `ecall`      | `11..7=0 19..15=0`    | `31..20=0x000      14..12=0 6..2=0x1C 1..0=3`                                      | `none`       | `rv32s rv64s rv128s` |
| `ebreak`     | `11..7=0 19..15=0`    | `31..20=0x001      14..12=0 6..2=0x1C 1..0=3`                                      | `none`       | `rv32s rv64s rv128s` |
| `uret`       | `11..7=0 19..15=0`    | `31..20=0x002      14..12=0 6..2=0x1C 1..0=3`                                      | `none`       | `rv32s rv64s rv128s` |
| `sret`       | `11..7=0 19..15=0`    | `31..20=0x102      14..12=0 6..2=0x1C 1..0=3`                                      | `none`       | `rv32s rv64s rv128s` |
| `hret`       | `11..7=0 19..15=0`    | `31..20=0x202      14..12=0 6..2=0x1C 1..0=3`                                      | `none`       | `rv32s rv64s rv128s` |
| `mret`       | `11..7=0 19..15=0`    | `31..20=0x302      14..12=0 6..2=0x1C 1..0=3`                                      | `none`       | `rv32s rv64s rv128s` |
| `dret`       | `11..7=0 19..15=0`    | `31..20=0x7b2      14..12=0 6..2=0x1C 1..0=3`                                      | `none`       | `rv32s rv64s rv128s` |
| `sfence.vm`  | `11..7=0 rs1`         | `31..20=0x104      14..12=0 6..2=0x1C 1..0=3`                                      | `r+sf`       | `rv32s rv64s rv128s` |
| `sfence.vma` | `11..7=0 rs1 rs2`     | `31..25=0x009      14..12=0 6..2=0x1C 1..0=3`                                      | `r+sfa`      | `rv32s rv64s rv128s` |
| `wfi`        | `11..7=0 19..15=0`    | `31..20=0x105      14..12=0 6..2=0x1C 1..0=3`                                      | `none`       | `rv32s rv64s rv128s` |
| `#rdcycle`   | `rd      19..15=0`    | `31..20=0xC00      14..12=2 6..2=0x1C 1..0=3`                                      | `i·csr`      | `rv32s rv64s rv128s` |
| `#rdtime`    | `rd      19..15=0`    | `31..20=0xC01      14..12=2 6..2=0x1C 1..0=3`                                      | `i·csr`      | `rv32s rv64s rv128s` |
| `#rdinstret` | `rd      19..15=0`    | `31..20=0xC02      14..12=2 6..2=0x1C 1..0=3`                                      | `i·csr`      | `rv32s rv64s rv128s` |
| `#rdcycleh`  | `rd      19..15=0`    | `31..20=0xC80      14..12=2 6..2=0x1C 1..0=3`                                      | `i·csr`      | `rv32s`              |
| `#rdtimeh`   | `rd      19..15=0`    | `31..20=0xC81      14..12=2 6..2=0x1C 1..0=3`                                      | `i·csr`      | `rv32s`              |
| `#rdinstreth`| `rd      19..15=0`    | `31..20=0xC82      14..12=2 6..2=0x1C 1..0=3`                                      | `i·csr`      | `rv32s`              |
| `csrrw`      | `rd      rs1`         | `csr12             14..12=1 6..2=0x1C 1..0=3`                                      | `i·csr`      | `rv32s rv64s rv128s` |
| `csrrs`      | `rd      rs1`         | `csr12             14..12=2 6..2=0x1C 1..0=3`                                      | `i·csr`      | `rv32s rv64s rv128s` |
| `csrrc`      | `rd      rs1`         | `csr12             14..12=3 6..2=0x1C 1..0=3`                                      | `i·csr`      | `rv32s rv64s rv128s` |
| `csrrwi`     | `rd      zimm`        | `csr12             14..12=5 6..2=0x1C 1..0=3`                                      | `i·csr+i`    | `rv32s rv64s rv128s` |
| `csrrsi`     | `rd      zimm`        | `csr12             14..12=6 6..2=0x1C 1..0=3`                                      | `i·csr+i`    | `rv32s rv64s rv128s` |
| `csrrci`     | `rd      zimm`        | `csr12             14..12=7 6..2=0x1C 1..0=3`                                      | `i·csr+i`    | `rv32s rv64s rv128s` |

:RV32S - "RV32S Standard Extension for Supervisor-level Instructions"

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `flw`        | `frd rs1`             | `oimm12      14..12=2          6..2=0x01 1..0=3`                                   | `i+lf`       | `rv32f rv64f rv128f` |
| `fsw`        | `rs1 frs2`            | `simm12      14..12=2          6..2=0x09 1..0=3`                                   | `s+f`        | `rv32f rv64f rv128f` |
| `fmadd.s`    | `frd frs1 frs2 frs3`  |             `rm       26..25=0 6..2=0x10 1..0=3`                                   | `r4·m`       | `rv32f rv64f rv128f` |
| `fmsub.s`    | `frd frs1 frs2 frs3`  |             `rm       26..25=0 6..2=0x11 1..0=3`                                   | `r4·m`       | `rv32f rv64f rv128f` |
| `fnmsub.s`   | `frd frs1 frs2 frs3`  |             `rm       26..25=0 6..2=0x12 1..0=3`                                   | `r4·m`       | `rv32f rv64f rv128f` |
| `fnmadd.s`   | `frd frs1 frs2 frs3`  |             `rm       26..25=0 6..2=0x13 1..0=3`                                   | `r4·m`       | `rv32f rv64f rv128f` |
| `fadd.s`     | `frd frs1 frs2`       | `31..27=0x00 rm       26..25=0 6..2=0x14 1..0=3`                                   | `r·m+3f`     | `rv32f rv64f rv128f` |
| `fsub.s`     | `frd frs1 frs2`       | `31..27=0x01 rm       26..25=0 6..2=0x14 1..0=3`                                   | `r·m+3f`     | `rv32f rv64f rv128f` |
| `fmul.s`     | `frd frs1 frs2`       | `31..27=0x02 rm       26..25=0 6..2=0x14 1..0=3`                                   | `r·m+3f`     | `rv32f rv64f rv128f` |
| `fdiv.s`     | `frd frs1 frs2`       | `31..27=0x03 rm       26..25=0 6..2=0x14 1..0=3`                                   | `r·m+3f`     | `rv32f rv64f rv128f` |
| `fsgnj.s`    | `frd frs1 frs2`       | `31..27=0x04 14..12=0 26..25=0 6..2=0x14 1..0=3`                                   | `r+3f`       | `rv32f rv64f rv128f` |
| `fsgnjn.s`   | `frd frs1 frs2`       | `31..27=0x04 14..12=1 26..25=0 6..2=0x14 1..0=3`                                   | `r+3f`       | `rv32f rv64f rv128f` |
| `fsgnjx.s`   | `frd frs1 frs2`       | `31..27=0x04 14..12=2 26..25=0 6..2=0x14 1..0=3`                                   | `r+3f`       | `rv32f rv64f rv128f` |
| `fmin.s`     | `frd frs1 frs2`       | `31..27=0x05 14..12=0 26..25=0 6..2=0x14 1..0=3`                                   | `r+3f`       | `rv32f rv64f rv128f` |
| `fmax.s`     | `frd frs1 frs2`       | `31..27=0x05 14..12=1 26..25=0 6..2=0x14 1..0=3`                                   | `r+3f`       | `rv32f rv64f rv128f` |
| `fsqrt.s`    | `frd frs1 24..20=0`   | `31..27=0x0B rm       26..25=0 6..2=0x14 1..0=3`                                   | `r·m+ff`     | `rv32f rv64f rv128f` |
| `fle.s`      | `rd frs1  frs2`       | `31..27=0x14 14..12=0 26..25=0 6..2=0x14 1..0=3`                                   | `r+rff`      | `rv32f rv64f rv128f` |
| `flt.s`      | `rd frs1  frs2`       | `31..27=0x14 14..12=1 26..25=0 6..2=0x14 1..0=3`                                   | `r+rff`      | `rv32f rv64f rv128f` |
| `feq.s`      | `rd frs1  frs2`       | `31..27=0x14 14..12=2 26..25=0 6..2=0x14 1..0=3`                                   | `r+rff`      | `rv32f rv64f rv128f` |
| `fcvt.w.s`   | `rd frs1  24..20=0`   | `31..27=0x18 rm       26..25=0 6..2=0x14 1..0=3`                                   | `r·m+rf`     | `rv32f rv64f rv128f` |
| `fcvt.wu.s`  | `rd frs1  24..20=1`   | `31..27=0x18 rm       26..25=0 6..2=0x14 1..0=3`                                   | `r·m+rf`     | `rv32f rv64f rv128f` |
| `fcvt.s.w`   | `frd rs1  24..20=0`   | `31..27=0x1A rm       26..25=0 6..2=0x14 1..0=3`                                   | `r·m+fr`     | `rv32f rv64f rv128f` |
| `fcvt.s.wu`  | `frd rs1  24..20=1`   | `31..27=0x1A rm       26..25=0 6..2=0x14 1..0=3`                                   | `r·m+fr`     | `rv32f rv64f rv128f` |
| `fmv.x.s`    | `rd frs1  24..20=0`   | `31..27=0x1C 14..12=0 26..25=0 6..2=0x14 1..0=3`                                   | `r+rf`       | `rv32f rv64f rv128f` |
| `fclass.s`   | `rd frs1  24..20=0`   | `31..27=0x1C 14..12=1 26..25=0 6..2=0x14 1..0=3`                                   | `r+rf`       | `rv32f rv64f rv128f` |
| `fmv.s.x`    | `frd rs1  24..20=0`   | `31..27=0x1E 14..12=0 26..25=0 6..2=0x14 1..0=3`                                   | `r+fr`       | `rv32f rv64f rv128f` |

:RV32F - "RV32F Standard Extension for Single-Precision Floating-Point"

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `fcvt.l.s`   | `rd frs1  24..20=2`   | `31..27=0x18 rm       26..25=0 6..2=0x14 1..0=3`                                   | `r·m+rf`     |       `rv64f rv128f` |
| `fcvt.lu.s`  | `rd frs1  24..20=3`   | `31..27=0x18 rm       26..25=0 6..2=0x14 1..0=3`                                   | `r·m+rf`     |       `rv64f rv128f` |
| `fcvt.s.l`   | `frd rs1  24..20=2`   | `31..27=0x1A rm       26..25=0 6..2=0x14 1..0=3`                                   | `r·m+fr`     |       `rv64f rv128f` |
| `fcvt.s.lu`  | `frd rs1  24..20=3`   | `31..27=0x1A rm       26..25=0 6..2=0x14 1..0=3`                                   | `r·m+fr`     |       `rv64f rv128f` |

:RV64F - "RV64F Standard Extension for Single-Precision Floating-Point (+ RV32F)"

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `fld`        | `frd rs1`             | `oimm12      14..12=3          6..2=0x01 1..0=3`                                   | `i+lf`       | `rv32d rv64d rv128d` |
| `fsd`        | `rs1 frs2`            | `simm12      14..12=3          6..2=0x09 1..0=3`                                   | `s+f`        | `rv32d rv64d rv128d` |
| `fmadd.d`    | `frd frs1 frs2 frs3`  |             `rm       26..25=1 6..2=0x10 1..0=3`                                   | `r4·m`       | `rv32d rv64d rv128d` |
| `fmsub.d`    | `frd frs1 frs2 frs3`  |             `rm       26..25=1 6..2=0x11 1..0=3`                                   | `r4·m`       | `rv32d rv64d rv128d` |
| `fnmsub.d`   | `frd frs1 frs2 frs3`  |             `rm       26..25=1 6..2=0x12 1..0=3`                                   | `r4·m`       | `rv32d rv64d rv128d` |
| `fnmadd.d`   | `frd frs1 frs2 frs3`  |             `rm       26..25=1 6..2=0x13 1..0=3`                                   | `r4·m`       | `rv32d rv64d rv128d` |
| `fadd.d`     | `frd frs1 frs2`       | `31..27=0x00 rm       26..25=1 6..2=0x14 1..0=3`                                   | `r·m+3f`     | `rv32d rv64d rv128d` |
| `fsub.d`     | `frd frs1 frs2`       | `31..27=0x01 rm       26..25=1 6..2=0x14 1..0=3`                                   | `r·m+3f`     | `rv32d rv64d rv128d` |
| `fmul.d`     | `frd frs1 frs2`       | `31..27=0x02 rm       26..25=1 6..2=0x14 1..0=3`                                   | `r·m+3f`     | `rv32d rv64d rv128d` |
| `fdiv.d`     | `frd frs1 frs2`       | `31..27=0x03 rm       26..25=1 6..2=0x14 1..0=3`                                   | `r·m+3f`     | `rv32d rv64d rv128d` |
| `fsgnj.d`    | `frd frs1 frs2`       | `31..27=0x04 14..12=0 26..25=1 6..2=0x14 1..0=3`                                   | `r+3f`       | `rv32d rv64d rv128d` |
| `fsgnjn.d`   | `frd frs1 frs2`       | `31..27=0x04 14..12=1 26..25=1 6..2=0x14 1..0=3`                                   | `r+3f`       | `rv32d rv64d rv128d` |
| `fsgnjx.d`   | `frd frs1 frs2`       | `31..27=0x04 14..12=2 26..25=1 6..2=0x14 1..0=3`                                   | `r+3f`       | `rv32d rv64d rv128d` |
| `fmin.d`     | `frd frs1 frs2`       | `31..27=0x05 14..12=0 26..25=1 6..2=0x14 1..0=3`                                   | `r+3f`       | `rv32d rv64d rv128d` |
| `fmax.d`     | `frd frs1 frs2`       | `31..27=0x05 14..12=1 26..25=1 6..2=0x14 1..0=3`                                   | `r+3f`       | `rv32d rv64d rv128d` |
| `fcvt.s.d`   | `frd frs1 24..20=1`   | `31..27=0x08 rm       26..25=0 6..2=0x14 1..0=3`                                   | `r·m+ff`     | `rv32d rv64d rv128d` |
| `fcvt.d.s`   | `frd frs1 24..20=0`   | `31..27=0x08 rm       26..25=1 6..2=0x14 1..0=3`                                   | `r·m+ff`     | `rv32d rv64d rv128d` |
| `fsqrt.d`    | `frd frs1 24..20=0`   | `31..27=0x0B rm       26..25=1 6..2=0x14 1..0=3`                                   | `r·m+ff`     | `rv32d rv64d rv128d` |
| `fle.d`      | `rd frs1  frs2`       | `31..27=0x14 14..12=0 26..25=1 6..2=0x14 1..0=3`                                   | `r+rff`      | `rv32d rv64d rv128d` |
| `flt.d`      | `rd frs1  frs2`       | `31..27=0x14 14..12=1 26..25=1 6..2=0x14 1..0=3`                                   | `r+rff`      | `rv32d rv64d rv128d` |
| `feq.d`      | `rd frs1  frs2`       | `31..27=0x14 14..12=2 26..25=1 6..2=0x14 1..0=3`                                   | `r+rff`      | `rv32d rv64d rv128d` |
| `fcvt.w.d`   | `rd frs1  24..20=0`   | `31..27=0x18 rm       26..25=1 6..2=0x14 1..0=3`                                   | `r·m+rf`     | `rv32d rv64d rv128d` |
| `fcvt.wu.d`  | `rd frs1  24..20=1`   | `31..27=0x18 rm       26..25=1 6..2=0x14 1..0=3`                                   | `r·m+rf`     | `rv32d rv64d rv128d` |
| `fcvt.d.w`   | `frd rs1  24..20=0`   | `31..27=0x1A rm       26..25=1 6..2=0x14 1..0=3`                                   | `r·m+fr`     | `rv32d rv64d rv128d` |
| `fcvt.d.wu`  | `frd rs1  24..20=1`   | `31..27=0x1A rm       26..25=1 6..2=0x14 1..0=3`                                   | `r·m+fr`     | `rv32d rv64d rv128d` |
| `fclass.d`   | `rd frs1  24..20=0`   | `31..27=0x1C 14..12=1 26..25=1 6..2=0x14 1..0=3`                                   | `r+rf`       | `rv32d rv64d rv128d` |

:RV32D - "RV32D Standard Extension for Double-Precision Floating-Point"

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `fcvt.l.d`   | `rd frs1  24..20=2`   | `31..27=0x18 rm       26..25=1 6..2=0x14 1..0=3`                                   | `r·m+rf`     |       `rv64d rv128d` |
| `fcvt.lu.d`  | `rd frs1  24..20=3`   | `31..27=0x18 rm       26..25=1 6..2=0x14 1..0=3`                                   | `r·m+rf`     |       `rv64d rv128d` |
| `fmv.x.d`    | `rd frs1  24..20=0`   | `31..27=0x1C 14..12=0 26..25=1 6..2=0x14 1..0=3`                                   | `r+rf`       |       `rv64d rv128d` |
| `fcvt.d.l`   | `frd rs1  24..20=2`   | `31..27=0x1A rm       26..25=1 6..2=0x14 1..0=3`                                   | `r·m+fr`     |       `rv64d rv128d` |
| `fcvt.d.lu`  | `frd rs1  24..20=3`   | `31..27=0x1A rm       26..25=1 6..2=0x14 1..0=3`                                   | `r·m+fr`     |       `rv64d rv128d` |
| `fmv.d.x`    | `frd rs1  24..20=0`   | `31..27=0x1E 14..12=0 26..25=1 6..2=0x14 1..0=3`                                   | `r+fr`       |       `rv64d rv128d` |

:RV64D - "RV64D Standard Extension for Double-Precision Floating-Point (+ RV32D)"

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `#frcsr`     | `rd       19..15=0`   | `31..20=0x003 14..12=2 6..2=0x1C 1..0=3`                                           | `i·csr`      | `rv32f rv64f rv128f` |
| `#frrm`      | `rd       19..15=0`   | `31..20=0x002 14..12=2 6..2=0x1C 1..0=3`                                           | `i·csr`      | `rv32f rv64f rv128f` |
| `#frflags`   | `rd       19..15=0`   | `31..20=0x001 14..12=2 6..2=0x1C 1..0=3`                                           | `i·csr`      | `rv32f rv64f rv128f` |
| `#fscsr`     | `rd       rs1`        | `31..20=0x003 14..12=1 6..2=0x1C 1..0=3`                                           | `i·csr`      | `rv32f rv64f rv128f` |
| `#fsrm`      | `rd       rs1`        | `31..20=0x002 14..12=1 6..2=0x1C 1..0=3`                                           | `i·csr`      | `rv32f rv64f rv128f` |
| `#fsflags`   | `rd       rs1`        | `31..20=0x001 14..12=1 6..2=0x1C 1..0=3`                                           | `i·csr`      | `rv32f rv64f rv128f` |
| `#fsrmi`     | `rd       zimm`       | `31..20=0x002 14..12=5 6..2=0x1C 1..0=3`                                           | `i·csri`     | `rv32f rv64f rv128f` |
| `#fsflagsi`  | `rd       zimm`       | `31..20=0x001 14..12=5 6..2=0x1C 1..0=3`                                           | `i·csri`     | `rv32f rv64f rv128f` |

:RV32FD - "RV32F and RV32D common Floating-Point Instructions"

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `flq`        | `frd rs1`             | `oimm12      14..12=4          6..2=0x01 1..0=3`                                   | `i+lf`       | `rv32q rv64q rv128q` |
| `fsq`        | `rs1 frs2`            | `simm12      14..12=4          6..2=0x09 1..0=3`                                   | `s+f`        | `rv32q rv64q rv128q` |
| `fmadd.q`    | `frd frs1 frs2 frs3`  |             `rm       26..25=3 6..2=0x10 1..0=3`                                   | `r4·m`       | `rv32q rv64q rv128q` |
| `fmsub.q`    | `frd frs1 frs2 frs3`  |             `rm       26..25=3 6..2=0x11 1..0=3`                                   | `r4·m`       | `rv32q rv64q rv128q` |
| `fnmsub.q`   | `frd frs1 frs2 frs3`  |             `rm       26..25=3 6..2=0x12 1..0=3`                                   | `r4·m`       | `rv32q rv64q rv128q` |
| `fnmadd.q`   | `frd frs1 frs2 frs3`  |             `rm       26..25=3 6..2=0x13 1..0=3`                                   | `r4·m`       | `rv32q rv64q rv128q` |
| `fadd.q`     | `frd frs1 frs2`       | `31..27=0x00 rm       26..25=3 6..2=0x14 1..0=3`                                   | `r·m+3f`     | `rv32q rv64q rv128q` |
| `fsub.q`     | `frd frs1 frs2`       | `31..27=0x01 rm       26..25=3 6..2=0x14 1..0=3`                                   | `r·m+3f`     | `rv32q rv64q rv128q` |
| `fmul.q`     | `frd frs1 frs2`       | `31..27=0x02 rm       26..25=3 6..2=0x14 1..0=3`                                   | `r·m+3f`     | `rv32q rv64q rv128q` |
| `fdiv.q`     | `frd frs1 frs2`       | `31..27=0x03 rm       26..25=3 6..2=0x14 1..0=3`                                   | `r·m+3f`     | `rv32q rv64q rv128q` |
| `fsgnj.q`    | `frd frs1 frs2`       | `31..27=0x04 14..12=0 26..25=3 6..2=0x14 1..0=3`                                   | `r+3f`       | `rv32q rv64q rv128q` |
| `fsgnjn.q`   | `frd frs1 frs2`       | `31..27=0x04 14..12=1 26..25=3 6..2=0x14 1..0=3`                                   | `r+3f`       | `rv32q rv64q rv128q` |
| `fsgnjx.q`   | `frd frs1 frs2`       | `31..27=0x04 14..12=2 26..25=3 6..2=0x14 1..0=3`                                   | `r+3f`       | `rv32q rv64q rv128q` |
| `fmin.q`     | `frd frs1 frs2`       | `31..27=0x05 14..12=0 26..25=3 6..2=0x14 1..0=3`                                   | `r+3f`       | `rv32q rv64q rv128q` |
| `fmax.q`     | `frd frs1 frs2`       | `31..27=0x05 14..12=1 26..25=3 6..2=0x14 1..0=3`                                   | `r+3f`       | `rv32q rv64q rv128q` |
| `fcvt.s.q`   | `frd frs1   24..20=3` | `31..27=0x08 rm       26..25=0 6..2=0x14 1..0=3`                                   | `r·m+ff`     | `rv32q rv64q rv128q` |
| `fcvt.q.s`   | `frd frs1   24..20=0` | `31..27=0x08 rm       26..25=3 6..2=0x14 1..0=3`                                   | `r·m+ff`     | `rv32q rv64q rv128q` |
| `fcvt.d.q`   | `frd frs1   24..20=3` | `31..27=0x08 rm       26..25=1 6..2=0x14 1..0=3`                                   | `r·m+ff`     | `rv32q rv64q rv128q` |
| `fcvt.q.d`   | `frd frs1   24..20=1` | `31..27=0x08 rm       26..25=3 6..2=0x14 1..0=3`                                   | `r·m+ff`     | `rv32q rv64q rv128q` |
| `fsqrt.q`    | `frd frs1   24..20=0` | `31..27=0x0B rm       26..25=3 6..2=0x14 1..0=3`                                   | `r·m+ff`     | `rv32q rv64q rv128q` |
| `fle.q`      | `rd frs1 frs2`        | `31..27=0x14 14..12=0 26..25=3 6..2=0x14 1..0=3`                                   | `r+rff`      | `rv32q rv64q rv128q` |
| `flt.q`      | `rd frs1 frs2`        | `31..27=0x14 14..12=1 26..25=3 6..2=0x14 1..0=3`                                   | `r+rff`      | `rv32q rv64q rv128q` |
| `feq.q`      | `rd frs1 frs2`        | `31..27=0x14 14..12=2 26..25=3 6..2=0x14 1..0=3`                                   | `r+rff`      | `rv32q rv64q rv128q` |
| `fcvt.w.q`   | `rd frs1    24..20=0` | `31..27=0x18 rm       26..25=3 6..2=0x14 1..0=3`                                   | `r·m+rf`     | `rv32q rv64q rv128q` |
| `fcvt.wu.q`  | `rd frs1    24..20=1` | `31..27=0x18 rm       26..25=3 6..2=0x14 1..0=3`                                   | `r·m+rf`     | `rv32q rv64q rv128q` |
| `fcvt.q.w`   | `frd rs1    24..20=0` | `31..27=0x1A rm       26..25=3 6..2=0x14 1..0=3`                                   | `r·m+fr`     | `rv32q rv64q rv128q` |
| `fcvt.q.wu`  | `frd rs1    24..20=1` | `31..27=0x1A rm       26..25=3 6..2=0x14 1..0=3`                                   | `r·m+fr`     | `rv32q rv64q rv128q` |
| `fclass.q`   | `rd frs1    24..20=0` | `31..27=0x1C 14..12=1 26..25=3 6..2=0x14 1..0=3`                                   | `r+rf`       | `rv32q rv64q rv128q` |

:RV32Q - "RV32Q Standard Extension for Quad-Precision Floating-Point"

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `fcvt.l.q`   | `rd frs124..20=2`     | `31..27=0x18 rm       26..25=3 6..2=0x14 1..0=3`                                   | `r·m+rf`     |       `rv64q rv128q` |
| `fcvt.lu.q`  | `rd frs124..20=3`     | `31..27=0x18 rm       26..25=3 6..2=0x14 1..0=3`                                   | `r·m+rf`     |       `rv64q rv128q` |
| `fcvt.q.l`   | `frd rs124..20=2`     | `31..27=0x1A rm       26..25=3 6..2=0x14 1..0=3`                                   | `r·m+fr`     |       `rv64q rv128q` |
| `fcvt.q.lu`  | `frd rs124..20=3`     | `31..27=0x1A rm       26..25=3 6..2=0x14 1..0=3`                                   | `r·m+fr`     |       `rv64q rv128q` |

:RV64Q - "RV64Q Standard Extension for Quad-Precision Floating-Point (+ RV32Q)"

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `fmv.x.q`    | `rd frs124..20=0`     | `31..27=0x1C 14..12=0 26..25=3 6..2=0x14 1..0=3`                                   | `r+rf`       |       `rv64q rv128q` |
| `fmv.q.x`    | `frd rs124..20=0`     | `31..27=0x1E 14..12=0 26..25=3 6..2=0x14 1..0=3`                                   | `r+fr`       |       `rv64q rv128q` |

:RV128Q - "RV128Q Standard Extension for Quadruple-Precision Floating-Point (+ RV64Q)"

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `c.addi4spn` | `crdq       cimm4spn` | `1..0=0 15..13=0`                                                                  | `ciw·4spn`   | `rv32c rv64c`        |
| `c.fld`      | `cfrdq crs1q   cimmd` | `1..0=0 15..13=1`                                                                  | `cl·ld+f`    | `rv32c rv64c`        |
| `c.lw`       | `crdq  crs1q   cimmw` | `1..0=0 15..13=2`                                                                  | `cl·lw`      | `rv32c rv64c`        |
| `c.flw`      | `cfrdq crs1q   cimmw` | `1..0=0 15..13=3`                                                                  | `cl·lw+f`    | `rv32c`              |
| `c.fsd`      | `crs1q cfrs2q  cimmd` | `1..0=0 15..13=5`                                                                  | `cs·sd+f`    | `rv32c rv64c`        |
| `c.sw`       | `crs1q crs2q   cimmw` | `1..0=0 15..13=6`                                                                  | `cs·sw`      | `rv32c rv64c`        |
| `c.fsw`      | `crs1q cfrs2q  cimmw` | `1..0=0 15..13=7`                                                                  | `cs·sw+f`    | `rv32c`              |
| `c.nop`      |                       | `1..0=1 15..13=0 12=0 11..7=0 6..2=0`                                              | `ci·none`    | `rv32c rv64c`        |
| `c.addi`     | `crs1rd      cnzimmi` | `1..0=1 15..13=0`                                                                  | `ci`         | `rv32c rv64c`        |
| `c.jal`      |               `cimmj` | `1..0=1 15..13=1`                                                                  | `cj·jal`     | `rv32c`              |
| `c.li`       | `crs1rd        cimmi` | `1..0=1 15..13=2`                                                                  | `ci·li`      | `rv32c rv64c`        |
| `c.addi16sp` | `crs1rd     cimm16sp` | `1..0=1 15..13=3      11..7=2`                                                     | `ci·16sp`    | `rv32c rv64c`        |
| `c.lui`      | `crd          cimmui` | `1..0=1 15..13=3`                                                                  | `ci·lui`     | `rv32c rv64c`        |
| `c.srli`     | `crs1rdq     cimmsh5` | `1..0=1 15..13=4      11..10=0`                                                    | `cb·sh5`     | `rv32c`              |
| `c.srai`     | `crs1rdq     cimmsh5` | `1..0=1 15..13=4      11..10=1`                                                    | `cb·sh5`     | `rv32c`              |
| `c.andi`     | `crs1rdq     cnzimmi` | `1..0=1 15..13=4      11..10=2`                                                    | `cb·imm`     | `rv32c rv64c`        |
| `c.sub`      | `crs1rdq crs2q`       | `1..0=1 15..13=4 12=0 11..10=3 6..5=0`                                             | `cs`         | `rv32c rv64c`        |
| `c.xor`      | `crs1rdq crs2q`       | `1..0=1 15..13=4 12=0 11..10=3 6..5=1`                                             | `cs`         | `rv32c rv64c`        |
| `c.or`       | `crs1rdq crs2q`       | `1..0=1 15..13=4 12=0 11..10=3 6..5=2`                                             | `cs`         | `rv32c rv64c`        |
| `c.and`      | `crs1rdq crs2q`       | `1..0=1 15..13=4 12=0 11..10=3 6..5=3`                                             | `cs`         | `rv32c rv64c`        |
| `c.subw`     | `crs1rdq crs2q`       | `1..0=1 15..13=4 12=1 11..10=3 6..5=0`                                             | `cs`         | `rv32c rv64c`        |
| `c.addw`     | `crs1rdq crs2q`       | `1..0=1 15..13=4 12=1 11..10=3 6..5=1`                                             | `cs`         | `rv32c rv64c`        |
| `c.j`        |               `cimmj` | `1..0=1 15..13=5`                                                                  | `cj`         | `rv32c rv64c`        |
| `c.beqz`     | `crs1q         cimmb` | `1..0=1 15..13=6`                                                                  | `cb`         | `rv32c rv64c`        |
| `c.bnez`     | `crs1q         cimmb` | `1..0=1 15..13=7`                                                                  | `cb`         | `rv32c rv64c`        |
| `c.slli`     | `crs1rd      cimmsh5` | `1..0=2 15..13=0`                                                                  | `ci·sh5`     | `rv32c`              |
| `c.fldsp`    | `cfrd       cimmldsp` | `1..0=2 15..13=1`                                                                  | `ci·ldsp+f`  | `rv32c rv64c`        |
| `c.lwsp`     | `crd        cimmlwsp` | `1..0=2 15..13=2`                                                                  | `ci·lwsp`    | `rv32c rv64c`        |
| `c.flwsp`    | `cfrd       cimmlwsp` | `1..0=2 15..13=3`                                                                  | `ci·lwsp+f`  | `rv32c`              |
| `c.jr`       | `crd0 crs1`           | `1..0=2 15..13=4 12=0         6..2=0`                                              | `cr·jr`      | `rv32c rv64c`        |
| `c.mv`       | `crd crs2`            | `1..0=2 15..13=4 12=0`                                                             | `cr·mv`      | `rv32c rv64c`        |
| `c.ebreak`   |                       | `1..0=2 15..13=4 12=1 11..7=0 6..2=0`                                              | `ci·none`    | `rv32c rv64c`        |
| `c.jalr`     | `crd0 crs1`           | `1..0=2 15..13=4 12=1         6..2=0`                                              | `cr·jalr`    | `rv32c rv64c`        |
| `c.add`      | `crs1rd crs2`         | `1..0=2 15..13=4 12=1`                                                             | `cr`         | `rv32c rv64c`        |
| `c.fsdsp`    | `cfrs2      cimmsdsp` | `1..0=2 15..13=5`                                                                  | `css·sdsp+f` | `rv32c rv64c`        |
| `c.swsp`     | `crs2       cimmswsp` | `1..0=2 15..13=6`                                                                  | `css·swsp`   | `rv32c rv64c`        |
| `c.fswsp`    | `cfrs2      cimmswsp` | `1..0=2 15..13=7`                                                                  | `css·swsp+f` | `rv32c`              |

:RV32C - "RV32C Standard Extension for Compressed Instructions"

| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `c.ld`       | `crdq  crs1q   cimmd` | `1..0=0 15..13=3`                                                                  | `cl·ld`      |       `rv64c`        |
| `c.sd`       | `crs1q crs2q   cimmd` | `1..0=0 15..13=7`                                                                  | `cs·sd`      |       `rv64c`        |
| `c.addiw`    | `crs1rd        cimmi` | `1..0=1 15..13=1`                                                                  | `ci`         |       `rv64c`        |
| `c.srli`     | `crs1rdq     cimmsh6` | `1..0=1 15..13=4 11..10=0`                                                         | `cb·sh6`     |       `rv64c`        |
| `c.srai`     | `crs1rdq     cimmsh6` | `1..0=1 15..13=4 11..10=1`                                                         | `cb·sh6`     |       `rv64c`        |
| `c.slli`     | `crs1rd      cimmsh6` | `1..0=2 15..13=0`                                                                  | `ci·sh6`     |       `rv64c`        |
| `c.ldsp`     | `crd        cimmldsp` | `1..0=2 15..13=3`                                                                  | `ci·ldsp`    |       `rv64c`        |
| `c.sdsp`     | `crs2       cimmsdsp` | `1..0=2 15..13=7`                                                                  | `css·sdsp`   |       `rv64c`        |

:RV64C - "RV64C Standard Extension for Compressed Instructions (+ RV32C)"
                                           
| instruction  | argument              | opcode                                                                             | codec        | extension            |
|--------------|:----------------------|:-----------------------------------------------------------------------------------|:-------------|:---------------------|
| `c.lq`       | `crdq crs1q    cimmq` | `1..0=0 15..13=1`                                                                  | `cl·lq`      |             `rv128c` |
| `c.sq`       | `crs1q crs2q   cimmq` | `1..0=0 15..13=5`                                                                  | `cs·sq`      |             `rv128c` |
| `c.lqsp`     | `crd        cimmlqsp` | `1..0=2 15..13=1`                                                                  | `ci·lqsp`    |             `rv128c` |
| `c.sqsp`     | `crs2       cimmsqsp` | `1..0=2 15..13=5`                                                                  | `css·sqsp`   |             `rv128c` |

:RV128C - "RV128C Standard Extension for Compressed Instructions (+ RV64C)"
