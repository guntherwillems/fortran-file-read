! Author: Gunther Willems
! Started 11/2024
! License: MIT

! Read a text file without losing the trailing spaces in the text.
program file_read
   implicit none

   integer, parameter :: buffer_size = 512
   character(*), parameter :: filename = "test.txt"
   integer :: io, stat, line_size
   character(buffer_size) :: msg ! Error message
   character(buffer_size) :: buffer ! Will add trailing spaces when a shorter character string is set
   character(:), allocatable :: line ! The character string that is read, without added trailing spaces

   open(newunit=io, file=filename, status="old", action="read", iostat=stat, iomsg=msg)
   if (stat /= 0) then ! Error number
      print *, trim(msg)
      return
   end if

   do
      read(unit=io, fmt='(a)', iostat=stat, advance='no', size=line_size) buffer
      line = buffer(:line_size)
      print *, ">" // line // "<"
      if (IS_IOSTAT_END(stat)) exit ! End of file
   end do

   close(io)
end program file_read
