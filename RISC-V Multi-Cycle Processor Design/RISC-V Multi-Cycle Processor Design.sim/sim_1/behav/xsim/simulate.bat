@echo off
REM ****************************************************************************
REM Vivado (TM) v2018.3 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Tue Nov 14 19:48:42 +0300 2023
REM SW Build 2405991 on Thu Dec  6 23:38:27 MST 2018
REM
REM Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
call xsim tb_islemci_behav -key {Behavioral:sim_1:Functional:tb_islemci} -tclbatch tb_islemci.tcl -view C:/Users/orucc/Desktop/Coding_Projects/Multi-Cycle RISCV-5 Processor Design/RISC-V-Processor-Design/RISC-V Multi-Cycle Processor Design/tb_islemci_behav1.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
