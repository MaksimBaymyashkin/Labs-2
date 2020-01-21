      program lab1
        integer size
        dimension arr1(18,18,18,18)
        dimension arr2(18,18,18,18)
        dimension arr3(18,18,18,18)
        dimension arr4(18,18,18,18,18,18)
        real(4) :: t1, t2
		
		
        integer h,m,i,n,j,g,k
        size=18
     
        !Заполнение матриц 
	   call random_number(arr1)
	   call random_number(arr2)
		arr1=FLOOR(10*arr1)
		arr2=FLOOR(10*arr2)
   
		do h=1, size
			do i=1, size
				do m=1, size
					do n=1, size
						arr3(h,i,m,n)=0
					end do
				end do
			end do
		end do
        do h=1, size
			do i=1, size
				do m=1, size
					do n=1, size
						do j=1, size
							do g=1, size
								arr4(h,i,m,n,j,g)=0
							end do
						end do
					end do
				end do
			end do
		end do
	t1 = secnds (0.0)   
	do h=1, size
			do i=1, size
				do m=1, size
					do n=1, size
						do k=1, size						
									arr3(h,i,m,n)=arr1(h,i,m,k)+arr2(h,i,m,k)
						end do
					end do
				end do
			end do
		end do	
	t2 = secnds (t1)        
	 print *, "SUM:", t2, " seconds." 
		  t3 = secnds (0.0) 
		do h=1, size
			do i=1, size
				do m=1, size
					do n=1, size
						do j=1, size
							do g=1, size
                                do k=1, size
									arr4(h,i,m,n,j,g)=arr4(h,i,m,n,j,g)+arr1(h,i,m,k)*arr2(k,n,j,g)	
                                end do							
							end do
						end do
					end do
				end do
			end do
		end do						  
      t4 = secnds (t3)        
    print *, "MULT:", t4, " seconds."  
	   end
