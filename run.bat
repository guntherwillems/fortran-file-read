@echo off
SET progr=main
IF NOT EXIST bin md bin
gfortran -o bin\%progr% app\%progr%.f90
bin\%progr%
