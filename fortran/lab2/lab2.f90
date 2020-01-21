module utils
    contains
        function diag(vector, size) result(res)
            implicit none
            integer, intent(in) :: size
            double precision, intent(in) :: vector(size)            
            double precision :: res(size,size)
            integer :: i
            res = 0.0
            do i = 1, size
                res(i,i) = vector(i)
            end do
        end function diag

        function inv_nonzero(matrix, n, m) result(res)
            implicit none
            integer, intent(in) :: n, m
            double precision, intent(in) :: matrix(n,m)            
            double precision :: res(n,m)
            integer :: i, j
            do i = 1, n
                do j = 1, m
                    if (i==j) then
                        res(i,j) = 1 / matrix(i,j)
                    else
                        res(i,j) = 0
                    end if
                end do
            end do
        end function inv_nonzero

        function mean(matrix, n, m) result(res)
            implicit none
            integer, intent(in) :: n, m
            double precision, intent(in) :: matrix(n,m)
            double precision :: res(m)
            integer :: i
            do i = 1, m
                res(i) = sum(matrix(:,i))
                res(i) = res(i) / n
            end do
        end function mean

        function three_vec_mul(vec1, vec2, vec3, n, m) result(res)
            implicit none
            integer, intent(in) :: n, m
            double precision, intent(in) :: vec1(n), vec2(m), vec3(m)
            double precision :: res(n), tmp(n,m)
            integer :: i, j
            do i = 1, n
                do j = 1, m
                    tmp(i,j) = vec1(i) * vec2(j)
                end do
            end do
            res = 0
            do i = 1, n
                do j = 1, m
                    res(i) = res(i) + tmp(i,j)*vec3(j)
                end do
            end do
        end function three_vec_mul

        function diff(matrix, n, m) result(res)
            implicit none
            integer, intent(in) :: n, m
            double precision, intent(in) :: matrix(n,m)
            double precision :: res(n-1,m)
            integer :: i, j
            do i = 1, n - 1
                res(i,:) = matrix(i + 1,:) - matrix(i,:)
            end do
        end function diff
end module utils

program main
    use utils

    INTEGER, parameter :: N = 5, M = 2
    INTEGER, parameter :: LDA = N, LDU = N, LDVT = M
    INTEGER, parameter :: LWMAX = 1000

    double precision :: X1(N), X2(N), VTT1(M), VTT2(M), I1(M), I2(M), A1(N), A2(N), Y11s(N), Y12s(N)
    double precision :: X(N,M), KK(M,M), A(N,M), S_DIAG(M,M), dA(N-1,M), VTT(M,M), IMAT(M,M), Y1(N,M), dY1(N,M), Y1_(N,M)

    integer :: i, j

    DOUBLE PRECISION :: alpha, beta
    DOUBLE PRECISION U( LDU, N ), VT( LDVT, M ), S( M ), WORK( LWMAX )
    integer :: INFO, LWORK, k , l
    INTEGER, parameter :: LDQ = M, P = N - 1
    INTEGER, parameter :: LDV = P
    integer :: iwork(M)
    DOUBLE PRECISION Q(LDQ, M), V(LDV, P)

    call RANDOM_NUMBER(X1)
    print *, "X1:"
    print *, (X1(i), i = 1, N)
    call RANDOM_NUMBER(X2)
    print *, "X2:"
    print *, (X2(i), i = 1, N)
    call RANDOM_NUMBER(KK)
    print *, "KK:"
    do i = 1, 2
        print *,(KK(i,j), j = 1, 2)
    end do

    X(:,1) = X1
    X(:,2) = X2
    print *, "X = [X1 X2] :"
    do i = 1, N
        print *,(X(i,j), j = 1, 2)
    end do

    A = matmul(X, KK)
    print *, "A = X * KK :"
    do i = 1, N
        print *,(A(i,j), j = 1, 2)
    end do

    A = A - spread(mean(A, N, M), 1, N)

    LWORK = -1
    call DGESVD('All', 'All', N, M, A, LDA, S, U, LDU, VT, LDVT, WORK, LWORK, INFO)
    LWORK = min(LWMAX, int(WORK(1)))

    call DGESVD('All', 'All', N, M, A, LDA, S, U, LDU, VT, LDVT, WORK, LWORK, INFO)

    IF (INFO > 0) THEN
        WRITE(*,*)'The algorithm computing SVD failed to converge.'
        STOP
    END IF

    print *, 'Singular values'
    print *, (S(i), i = 1, M)

    print *, 'Left singular vectors (stored columnwise)'
    do i = 1, N
        print *,(U(i,j), j = 1, N)
    end do

    print *, 'Right singular vectors (stored rowwise)'
    do i = 1, M
        print *,(VT(i,j), j = 1, M)
    end do

    S_DIAG = diag(S, M)

    Y1 = matmul(matmul(A, VT), inv_nonzero(S_DIAG, M, M))
    print *, 'Y1:'
    do i = 1, N
        print *,(Y1(i,j), j = 1, M)
    end do

    IMAT = inv_nonzero(sqrt(S_DIAG), M, M)

    VTT = transpose(VT)
    VTT1 = VTT(1,:)
    VTT2 = VTT(2,:)
    I1 = IMAT(:,2)
    I2 = IMAT(:,1)
    A1 = A(:,1)
    A2 = A(:,2)

    Y11s = three_vec_mul(A1, VTT1, I1, N, M)
    Y12s = three_vec_mul(A2, VTT2, I2, N, M)

    print *, 'Y11s:'
    print *, Y11s
    print *, 'Y12s:'
    print *, Y12s

    dY1 = matmul(matmul(A, VT), inv_nonzero(S_DIAG, M, M))

    S = 0
    U = 0
    VT = 0
    call DGESVD('All', 'All', N, M, dY1, LDA, S, U, LDU, VT, LDVT, WORK, LWORK, INFO)
    IF (INFO > 0) THEN
        WRITE(*,*)'The algorithm computing SVD failed to converge.'
        STOP
    END IF

    Y1_ = matmul(Y1, VT)
    print *, 'Y1_:'
    do i = 1, N
        print *,(Y1_(i,j), j = 1, M)
    end do


    S = 0
    U = 0
    VT = 0
    dA = diff(A, N, M)
    LWORK = -1
    call dggsvd3('U', 'V', 'Q', N, M, N - 1, k, l, a, lda, dA, LDA - 1, alpha, beta, U, ldu, v, LDV, &
            Q, M, work, lwork, iwork, info)
    LWORK = min(LWMAX, int(WORK(1)))

    call dggsvd3('U', 'V', 'Q', N, M, N - 1, k, l, a, lda, dA, LDA - 1, alpha, beta, U, ldu, v, LDV, &
            Q, M, work, lwork, iwork, info)
    IF (INFO > 0) THEN
        WRITE(*,*)'The algorithm computing SVD failed to converge.'
        STOP
    END IF

    print *, 'gsvd:'
    do i = 1, N
        print *, U(i,1), ' ', U(i,2)
    end do

end program main
