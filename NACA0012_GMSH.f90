!  NACA0012_GMSH.f90 

!****************************************************************************
!
!  PROGRAM: NACA0012_GMSH
!
!  PURPOSE: Read naca0012 coordinates and write to gmsh .geo file format.
!
!  AUTHOR:  DANG Truong
!****************************************************************************

    program NACA0012_GMSH

    implicit none

    ! Variables
    integer :: i
    real(8),dimension(133) :: x, y
    
    ! Body of NACA0012_GMSH
    
    open(1, file = 'naca0012.txt')
    do i = 1, 66
        read(1,*) x(i), y(i)
    enddo  
    
    read(1,*)
    
    do i = 68, 133
        read(1,*) x(i), y(i)
    enddo    
    close(1)
    
    open(2, file = 'naca0012_gmsh.geo')
    do i = 1, 133
        if (i .ne. 67) then
            write(2,100) i, x(i), y(i)
        else 
            write(2,100) i, 1.0d0, 0.0d0
        endif    
    enddo 
    
    do i = 1, 66
        write(2,200) i, i ,i+1
    enddo
    
    write(2,200) 67, 66, 67
    
    do i = 133,68,-1
        if (i .ne. 68) then
            write(2,200) i, i, i-1
        else
            write(2,200) i, 67 , 133
        endif
    enddo
    
    !do i = 67, 132
    !    write(2,200) i, i, i+1
    !enddo
    
    close(2)
    
100 format( 'Point(',I5,') ={',f15.12,',',f15.12,',0.0',',0.0','};') 
200 format('Line(',I5, ')={',I5,',',I5,'};')    

    

    end program NACA0012_GMSH

