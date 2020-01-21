#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <time.h>

#define N 100

int main() 
{ 

int h,j,k,i;
int arr[N][N],arr2[N][N],arr3[N][N],arr4[N][N];

    clock_t start, end;
    clock_t start1, end1;
  
//Matrix1
    for (int i = 0; i < N; i++){
		for (int j = 0; j < N; j++){
			arr[i][j] = rand();
        }    	
    }
//Matrix2
    for (int i = 0; i < N; i++){
			for (int j = 0; j < N; j++){
    			arr2[i][j] = rand(); 
			}
	}
//Matrix for SUM
	for (i=0; i<N;i++){
		for (j=0; j<N;j++){
			arr3[i][j]=0;
		}
	}
    start = clock();
    for (h=0; i<N;h++){
		for (i=0; j<N;i++){
            arr3[i][j]=0;
				arr3[i][j]=arr[i][j]+arr2[i][j];
			}
	}
	end = clock();     
    printf("SUM time (sec): %f\n", ((double) end - start) / ((double) CLOCKS_PER_SEC));
//Matrix for MULT
    for (h=0; h<N;h++){
		for (i=0; i<N;i++){
			arr4[h][i]=0;
		}
	}
    start1 = clock();
    for (h=0; h<N;h++){
		for (i=0; i<N;i++){
			for (k=0; k<N;k++){
				arr4[h][i]=arr4[h][i]+arr[h][k]*arr2[k][i];
			}
		}
	}
		end1 = clock();
 
    printf("MILTIPLY time (sec): %f\n", ((double) end1 - start1) / ((double) CLOCKS_PER_SEC));
}

