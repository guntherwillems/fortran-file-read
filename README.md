# Fortran, read a text file without losing trailing spaces

When reading a file line by line and using a character array with fixed length (len attribute) to store it, trailing spaces will be added to fill the character string.  
Setting string "Test" into type character(10) would result in "Test&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"

If the file has text lines with spaces at the end, they will be lost. HTML, json, ... files could have spaces at the end of a line that you don't want to lose.

This code will not lose the trailing spaces:

~~~fortran
   integer, parameter :: buffer_size = 512
   character(*), parameter :: filename = "test.txt"
   integer :: io, stat, line_size
   character(buffer_size) :: msg ! Error message
   ! Will add trailing spaces when a shorter character string is set
   character(buffer_size) :: buffer
   ! Deferred character string to store text without added trailing spaces.
   character(:), allocatable :: line

   open(newunit=io, file=filename, status="old", action="read", iostat=stat, iomsg=msg)
   if (stat /= 0) then ! Error number. If the file doesn't exist.
      print *, trim(msg)
      return
   end if

   do
      read(unit=io, fmt='(a)', iostat=stat, advance='no', size=line_size) buffer
      ! line_size is the number of characters transferred.
      line = buffer(:line_size)
      print *, ">" // line // "<"
      if (IS_IOSTAT_END(stat)) exit ! End of file
   end do

   close(io)
~~~

The repository has a working example: app/main.f90

The project structure is ready for [fpm](https://fpm.fortran-lang.org/) (Fortran Package Manager).  
or  
run.bat: Batch file to compile and run the code in Windows with [gfortran](https://gcc.gnu.org/) 
