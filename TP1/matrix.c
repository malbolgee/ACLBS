#include <stdio.h>

static void matrix_mult()
{
	int a[4][3] = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}, {6, 5, 4}};
	int b[3][2] = {{3, 2}, {6, 5}, {8, 7}};
	int c[4][2] = {{0}};

	for(int i = 0; i < 4; ++i)
		for(int j = 0; j < 2; ++j)
			for(int k = 0; k < 3; ++k)
				c[i][j] += a[i][k] * b[k][j];

	for (int i = 0; i < 4; ++i)
	{
		for (int j = 0; j < 2; ++j)
			printf("%d ", c[i][j]);
		
		putchar_unlocked('\n');
	}
}

static void matrix_mult_2()
{
	int rows_a = 4;
	int cols_a = 3;

	int rows_b = 3;
	int cols_b = 2;
	
	int rows_c = rows_a;
	int cols_c = cols_b;

	int a[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 6, 5, 4};
	int b[] = {3, 2, 6, 5, 8, 7};
	int c[8] = {0};
		
	for (int i = 0; i < rows_a; ++i)
		for (int j = 0; j < cols_b; ++j)
			for (int k = 0; k < rows_b; ++k)
				c[i * cols_c + j] += a[i * cols_a + k] * b[k * cols_b + j];

	for (int i = 0; i < rows_c; ++i)
	{
		for (int j = 0; j < cols_c; ++j)
			printf("%d ", c[j + i * cols_c]);
		
		putchar_unlocked('\n');
	}
}

int main(int argc, char **argv)
{
	matrix_mult();
	putchar_unlocked('\n');
	matrix_mult_2();
	return 0;
}
