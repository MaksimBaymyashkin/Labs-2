module matrix
contains
    function summ(a, b, size) result(res)
        implicit none
        real, dimension(:,:), intent(in) :: a, b
        integer, intent(in) :: size
        real, dimension(:,:), allocatable :: res

        integer :: i, j, k

        allocate(res(size, size))
        do i = 1, size
            do j = 1, size
                res(i,j) = 0
                do k = 1, size
                    res(i,j) = a(i,k) + b(k,j)
                enddo
            enddo
        enddo
    end function summ

    function multiply(a, b, size) result(res)
        implicit none
        real, dimension(:,:), intent(in) :: a, b
        integer, intent(in) :: size
        real, dimension(:,:), allocatable :: res

        integer :: i, j, k

        allocate(res(size, size))
        do i = 1, size
            do j = 1, size
                res(i,j) = 0
                do k = 1, size
                    res(i,j) = res(i,j) + a(i,k) * b(k,j)
                enddo
            enddo
        enddo
    end function multiply
end module matrix

program main
    use matrix
    implicit none
    real, dimension(:,:), allocatable :: a, b, c
    real :: start_time, finish_time, result
    integer :: N = 1000, MEASURES = 1, i

    allocate(a(N,N))
    call RANDOM_NUMBER(a)
    a = a * 200 - 100

    allocate(b(N,N))
    call RANDOM_NUMBER(b)
    b = b * 200 - 100

    print *, "SUM time (sec):"
    do i = 1, MEASURES
        allocate(c(N,N))
        call cpu_time(start_time)
        c = summ(a, b, N)
        call cpu_time(finish_time)
        print *, finish_time - start_time
        
        deallocate(c)
    enddo

    print *, "MILTIPLY time (sec):"
    do i = 1, MEASURES
        allocate(c(N,N))
        call cpu_time(start_time)
        c = multiply(a, b, N)
        call cpu_time(finish_time)
        print *, finish_time - start_time
        deallocate(c)
    enddo

    deallocate(a,b)
end program main
