#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <time.h>

#define N 10

int main() 
{ 

int h,m,n,l,j,g,k,i;
int arr[N][N][N][N],arr2[N][N][N][N],arr3[N][N][N][N],arr4[N][N][N][N][N][N];

    clock_t start, end;
    clock_t start1, end1;
  
//Matrix1
    for (int i = 0; i < N; i++){
		for (int j = 0; j < N; j++){
			for (int k = 0; k < N; k++){
				for (int l = 0; l < N; l++){
					arr[i][j][k][l] = rand();
                }
            } 
         }    	
    }
//Matrix2
    for (int i = 0; i < N; i++){
		for (int j = 0; j < N; j++){
			for (int k = 0; k < N; k++){
				for (int l = 0; l < N; l++)	{
					arr2[i][j][k][l] = rand(); 
				}
			}
		}
	}
//Matrix for SUM
    start = clock();
    for (h=0; h<N;h++){
			for (i=0; i<N;i++){
				for (m=0; m<N;m++){
					for (n=0; n<N;n++){
                        arr3[h][i][m][n]=0;
						for (k=0; k<N;k++){
							arr3[h][i][m][n]=arr[h][i][m][k]+arr2[h][i][m][k];
						}
					}
				}
			}
	}
	end = clock();     
    printf("SUM time (sec): %.4f\n", ((double) end - start) / ((double) CLOCKS_PER_SEC));
//Matrix for MULT
    start1 = clock();
    for (h=0; h<N;h++){
		for (i=0; i<N;i++){
			for (m=0; m<N;m++){
				for (n=0; n<N;n++){
					for (j=0; j<N;j++){
						for (g=0; g<N;g++){
                            arr4[h][i][m][n][j][g]=0;
							for (k=0; k<N;k++){
									arr4[h][i][m][n][j][g]=arr4[h][i][m][n][j][g]+arr[h][i][m][k]*arr2[k][n][j][g];
								}
							}
						}
					}
				}
			}
		}
		end1 = clock(); 
    printf("MILTIPLY time (sec): %.4f\n", ((double) end1 - start1) / ((double) CLOCKS_PER_SEC));
}

