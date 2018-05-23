GFORTRAN    = gfortran -Wall
CC          = gcc -Wall
MPI_FORTRAN = mpif90 -Wall
MPI_CC      = mpicc -Wall
LD = -lm

.SUFFIXES : .o .f90

all: explicitSeq explicitPar

explicitSeq : explicitSeq.o explUtilSeq.o
	$(GFORTRAN) -o $@ explicitSeq.o explUtilSeq.o

explicitSeq.o : explicitSeq.f90 
	$(GFORTRAN) -c $(*F).f90
	
explUtilSeq.o : explUtilSeq.f90
	$(GFORTRAN) -c $(*F).f90	
		
explicitPar : explicitPar.o explUtilPar.o updateBound.o readParam.o
	$(MPI_FORTRAN) -o $@ explicitPar.o explUtilPar.o updateBound.o readParam.o 

.f90.o :
	$(MPI_FORTRAN) -c $(*F).f90

clean : 
	/bin/rm -f *.o explicitSeq explicitPar
