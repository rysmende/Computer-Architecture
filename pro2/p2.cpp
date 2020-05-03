#include "iostream"

void printArray(std::string message, int *ar)
{
	printf("%s:", message.c_str());
	for (int i = 0; i < 36; i++)
	{
		printf(" %d", ar[i]);
	}
	printf("\n");
}

void generateRandom(int* ar1, int m, int d, int a)
{
	for (int i = 1; i < 36; i++)
	{
		__asm__ __volatile__
		(
		    "movl %4, %%eax;"
		    "mull %3;"
		    "addl %2, %%eax;"
		    "divl %1;"
		    "movl %%edx, %0;"
		    : "=a"(ar1[i])
		    : "b"(m), "c"(d), "d"(a), "S"(ar1[i - 1])
		);
	}
}

void sort(int* ar)
{
	for (int i = 1; i < 36; i++)
	{
		int key = ar[i];
		int j = i - 1;
		while(j >= 0 && ar[j] > key)
		{
			ar[j + 1] = ar[j];
			j--;
		}
		ar[j + 1] = key;
	}
}

void new2b(int *arInit, int *arResult,  float c, float b)
{
	for (int i = 0; i < 36; i+=4)
	{
	__asm__ __volatile__
	(
	    "vbroadcastss (%2), %%xmm2;"
	    "vbroadcastss (%3), %%xmm1;"
	    "vmovdqa (%0), %%xmm0;"
	    "vcvtdq2ps %%xmm0, %%xmm0;"
	    "vfmadd132ps %%xmm1, %%xmm2, %%xmm0;"
	    "vcvtps2dq %%xmm0, %%xmm0;"
	    "vmovdqa %%xmm0, (%1);"
	    : 
	    :"a"(&arInit[i]), "b"(&arResult[i]), "c"(&c), "d"(&b)
		
	);
	}
}

void new2c(int* aInit, int* aResult, float* consts)
{
	int subI0[12] = {0};
	int subI1[12] = {0};
	int subI2[12] = {0};
	int subR0[12] = {0};
	int subR1[12] = {0};
	int subR2[12] = {0};

	for (int i = 0; i < 36; i++)
	{
		switch (i % 3)
		{
		case 0:
			subI0[i / 3] = aInit[i];
			break;
		case 1:
			subI1[i / 3] = aInit[i];
			break;
		case 2:
			subI2[i / 3] = aInit[i];
			break;
		}
	}

	for (int i = 0; i < 12; i += 4)
	{
		__asm__ __volatile__
		(
			"vmovdqa (%1), %%xmm0;"
			"vmovdqa (%2), %%xmm1;"
			"vmovdqa (%3), %%xmm2;"
			
			"vcvtdq2ps %%xmm0, %%xmm0;"
			"vcvtdq2ps %%xmm1, %%xmm1;"
			"vcvtdq2ps %%xmm2, %%xmm2;"
			
			"vbroadcastss (%4), %%xmm3;"
			"vbroadcastss (%5), %%xmm4;"
			"vbroadcastss (%6), %%xmm5;"
			
			"vmulps %%xmm0, %%xmm3, %%xmm0;"
			"vmulps %%xmm1, %%xmm4, %%xmm1;"
			"vmulps %%xmm2, %%xmm5, %%xmm2;"
			
			"vaddps %%xmm1, %%xmm2, %%xmm1;"
			"vaddps %%xmm0, %%xmm1, %%xmm0;"
			
			"vcvtps2dq %%xmm0, %%xmm0;"
			
			"vmovdqa %%xmm0, (%0);"
			: 
			: "r"(&subR0[i]), "a"(&subI0[i]), "b"(&subI1[i]), "c"(&subI2[i]), "d"(&consts[0]), "S"(&consts[1]), "D"(&consts[2])
		);
		__asm__ __volatile__
		(
			"vmovdqa (%1), %%xmm0;"
			"vmovdqa (%2), %%xmm1;"
			"vmovdqa (%3), %%xmm2;"
			
			"vcvtdq2ps %%xmm0, %%xmm0;"
			"vcvtdq2ps %%xmm1, %%xmm1;"
			"vcvtdq2ps %%xmm2, %%xmm2;"
			
			"vbroadcastss (%4), %%xmm3;"
			"vbroadcastss (%5), %%xmm4;"
			"vbroadcastss (%6), %%xmm5;"
			
			"vmulps %%xmm0, %%xmm3, %%xmm0;"
			"vmulps %%xmm1, %%xmm4, %%xmm1;"
			"vmulps %%xmm2, %%xmm5, %%xmm2;"
			
			"vaddps %%xmm1, %%xmm2, %%xmm1;"
			"vaddps %%xmm0, %%xmm1, %%xmm0;"
			
			"vcvtps2dq %%xmm0, %%xmm0;"
			
			"vmovdqa %%xmm0, (%0);"
			: 
			: "r"(&subR1[i]), "a"(&subI0[i]), "b"(&subI1[i]), "c"(&subI2[i]), "d"(&consts[3]), "S"(&consts[4]), "D"(&consts[5])
		);
		__asm__ __volatile__
		(
			"vmovdqa (%1), %%xmm0;"
			"vmovdqa (%2), %%xmm1;"
			"vmovdqa (%3), %%xmm2;"
			
			"vcvtdq2ps %%xmm0, %%xmm0;"
			"vcvtdq2ps %%xmm1, %%xmm1;"
			"vcvtdq2ps %%xmm2, %%xmm2;"
			
			"vbroadcastss (%4), %%xmm3;"
			"vbroadcastss (%5), %%xmm4;"
			"vbroadcastss (%6), %%xmm5;"
			
			"vmulps %%xmm0, %%xmm3, %%xmm0;"
			"vmulps %%xmm1, %%xmm4, %%xmm1;"
			"vmulps %%xmm2, %%xmm5, %%xmm2;"
			
			"vaddps %%xmm1, %%xmm2, %%xmm1;"
			"vaddps %%xmm0, %%xmm1, %%xmm0;"
			
			"vcvtps2dq %%xmm0, %%xmm0;"
			
			"vmovdqa %%xmm0, (%0);"
			:
		        : "r"(&subR2[i]), "a"(&subI0[i]), "b"(&subI1[i]), "c"(&subI2[i]), "d"(&consts[6]), "S"(&consts[7]), "D"(&consts[8])
		);
	}
	
	for (int i = 0; i < 36; i++)
	{
		switch (i % 3)
		{
		case 0:
			aResult[i] = subR0[i / 3];
			break;
		case 1:
			aResult[i] = subR1[i / 3];
			break;
		case 2:
			aResult[i] = subR2[i / 3];
			break;
		}
	}	
}

void new2d(int* aInit, int* aResult)
{
	int cyclic[44] = {0};
	for (int i = 0; i < 36; i++)
	{
		cyclic[i] = aInit[i];
	}
	for (int i = 0; i < 4; i++)
	{
		cyclic[i + 36] = aInit[i];
	}
	for (int i = 40; i < 44; i++)
	{
		cyclic[i] = aInit[i - 36];
	}
	float three = 3.0;
	for (size_t i = 0; i < 36; i += 4)
	{
		__asm__ __volatile__
                (
					"vmovdqa (%1), %%xmm0;"
 	              	"vmovdqa (%2), %%xmm1;"
                	"vcvtdq2ps %%xmm0, %%xmm0;"
                	"vcvtdq2ps %%xmm1, %%xmm1;"
                	"vaddps %%xmm1, %%xmm0, %%xmm0;"
					"vmovdqa (%3), %%xmm1;"
                	"vcvtdq2ps %%xmm1, %%xmm1;"
                	"vaddps %%xmm0, %%xmm1, %%xmm0;"
                	"vbroadcastss (%4), %%xmm1;"
                	"vdivps %%xmm1, %%xmm0, %%xmm0;"
                	"vcvtps2dq %%xmm0, %%xmm0;"
                	"vmovdqa %%xmm0, (%0);"
                	:
			: "a"(&aResult[i]), "b"(&cyclic[i]), "c"(&cyclic[i + 4]), "D"(&cyclic[i + 8]), "S"(&three)
		);

	}
}

void new2e(int *arInit, int *arResult,  float c, float b)
{
        int raInit[36] = {0};
	for (int i = 1; i < 36; i++)
        {
		raInit[i] = arInit[i - 1];
	}
	raInit[0] = arInit[35];
	float co = (255 * c) / (b * 2);
	for (int i = 0; i < 36; i+=4)
        {
        __asm__ __volatile__
        (
            "vbroadcastss (%3), %%xmm3;"
            "vmovdqa (%0), %%xmm0;"
            "vmovdqa (%1), %%xmm1;"
			"vcvtdq2ps %%xmm1, %%xmm1;"
			"vcvtdq2ps %%xmm0, %%xmm0;"
            "vfmsub213ps %%xmm1, %%xmm3, %%xmm0;"
            "vcvtps2dq %%xmm0, %%xmm0;"
            "vmovdqa %%xmm0, (%2);"
            :
            :"a"(&arInit[i]), "b"(&raInit[i]), "S"(&arResult[i]), "c"(&co)
        );
        }
}
          
int main(int argc, char** argv)
{
	int m, d, a, s, c, b;
	int ar1[36] = {0};
	int ar2[36] = {0};

	float consts[9] = {0.393, 0.769, 0.189, 0.349, 0.686, 0.168, 0.272, 0.534, 0.131};
	printf("Please input data as following: m, d, a, s, c, b.\n");
	scanf("%d %d %d %d %d %d", &m, &d, &a, &s, &c, &b);
	ar1[0] = s;

	generateRandom(ar1, m, d, a);
	printArray("Initial", ar1);
	sort(ar1);
	printArray("Sorted", ar1);
	new2b(ar1, ar2, (float)c, float(b));
	printArray("2b", ar2);	
	new2c(ar1, ar2, consts);
	printArray("2c", ar2);
	new2d(ar1, ar2);
	printArray("2d", ar2);
	new2e(ar1, ar2, (float)c, float(b));
	printArray("2e", ar2);

	return 0;
}

