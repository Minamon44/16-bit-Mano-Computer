# 16-bit CPU Design - Vivado + Proteus Integration

This project includes Verilog modules for a 16-bit CPU simulation in Xilinx Vivado, along with corresponding Proteus schematic files and binary ROM data.

---

## 📁 Included Files

| File                          | Description                                |
|-------------------------------|--------------------------------------------|
| cpu16.v                       | Top-level CPU module                       |
| reg16.v                       | 16-bit register with bus I/O               |
| alu16.v                       | ALU module                                 |
| mem16.v                       | Memory with ROM preload                    |
| control_fsm.v                 | FSM for micro-instruction timing           |
| tb_cpu16.v                    | Testbench for simulation                   |
| instr_rom.mem                 | Memory preload file in hex format          |
| README.txt                    | This documentation file                    |
| MBM2732@DIP24 HIGHIER_1.BIN   | High byte ROM for Proteus simulation       |
| MBM2732@DIP24LOWER_1.BIN      | Low byte ROM for Proteus simulation        |
| 16-bit PC.PDF                   | Schematic diagram of the Proteus project   |
| 16-bit PC.pdsprj                | Proteus project file                       |

---

## 🛠 Vivado Simulation Setup

1. **Create Vivado Project**
   - File → New Project → RTL Project
   - Do not specify sources yet

2. **Add Sources**
   - Add all `.v` files as **Design Sources**
   - Add `tb_cpu16.v` as a **Simulation Source**
   - Add `instr_rom.mem` as a **Simulation File**

3. **Run Simulation**
   - Open **Flow Navigator → Simulation → Run Behavioral Simulation**
   - In the Tcl console:
     ```
     add wave -recursive uut
     run 1000ns
     ```

---

## 🧪 Proteus Setup

- Open `16-bit PC.pdsprj` in Proteus 8 or later
- Attach the `.BIN` files to the two ROMs in the schematic:
  - `MBM2732@DIP24 HIGHIER_1.BIN` → connect to high byte ROM
  - `MBM2732@DIP24LOWER_1.BIN` → connect to low byte ROM
- Simulate to see instruction execution through the schematic

---

## 🔁 Syncing Vivado and Proteus

If you change instructions:
- Convert `.mem` → two `.BIN` files (high/low byte)
- Or convert `.BIN` → `.mem` using a script

This ensures both environments run the same instructions.

---

## ✅ Summary

You now have:
- Working 16-bit CPU simulation in Vivado
- Functional hardware design in Proteus
- Unified instruction memory format for both

## 👨‍🏫 Acknowledgment

This work was developed and tested under the supervision of  
**Prof. Hamdy El-Monair**  
**ENG. Kamel Mohamed**

KSU, Faculty of Engineering
