module matrix
contains
    function multiply(a, b, size) result(res)   !Умножение
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
    function summ(a,b) result(res)              !Сумма
      implicit none
      real, dimension(:,:), allocatable :: res
      real, dimension(:,:), intent(in) :: a, b
      integer :: i, j, n
      n = size(a,1)
      allocate(res(n,n))
      do j = 1, n
         do i = 1, n
            res(i,j) = a(i,j) + b(i,j)
         enddo
      enddo
   end function summ

   function diff(a,b) result(res)               !Разность
      implicit none
      real, dimension(:,:), allocatable :: res
      real, dimension(:,:), intent(in) :: a, b
      integer :: i, j, n
      n = size(a,1)
      allocate(res(n,n))
      do j = 1, n
         do i = 1, n
            res(i,j) = a(i,j) - b(i,j)
         enddo
      enddo
   end function diff
   function transponse(a) result(res)
      implicit none
      real, dimension(:,:), allocatable :: res
      real, dimension(:,:), intent(in) :: a
      integer :: i, j, n
      n = size(a,1)
      allocate(res(n,n))
      do i = 1, n
         do j = 1, n
            res(i,j)=a(j,i)
         enddo
      enddo
   end function transponse
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

    print *, "Multiply (sec):"
    do i = 1, MEASURES
        allocate(c(N,N))
        call cpu_time(start_time)
        c = multiply(a, b, N)
        call cpu_time(finish_time)
        print *, finish_time - start_time
        deallocate(c)
    enddo

    print *, "MATMUL function (sec):"
    do i = 1, MEASURES
        allocate(c(N,N))
        call cpu_time(start_time)
        c = matmul(a, b)
        call cpu_time(finish_time)
        print *, finish_time - start_time
        deallocate(c)
    enddo

    print *, "Summ (sec):"
    do i = 1, MEASURES
        allocate(c(N,N))
        call cpu_time(start_time)
        c = summ(a, b)
        call cpu_time(finish_time)
        print *, finish_time - start_time
        deallocate(c)
    enddo

    print *, "Difference (sec):"
    do i = 1, MEASURES
        allocate(c(N,N))
        call cpu_time(start_time)
        c = diff(a, b)
        call cpu_time(finish_time)
        print *, finish_time - start_time
        deallocate(c)
    enddo
    print *, "Transponse (sec):"
    do i = 1, MEASURES
        allocate(c(N,N))
        call cpu_time(start_time)
        c = transponse(a)
        call cpu_time(finish_time)
        print *, finish_time - start_time
        deallocate(c)
        deallocate(a,b)
    enddo
end program main







