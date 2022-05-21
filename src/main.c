#include <stdio.h>
#include "mymath.h"

int main() {
	double x;
	if( scanf("%lf",&x) < 1) {
		printf("Invalid input!");
		return 0;
	}
	double res = exp(x);
	printf("result: %lf\n",res);
	return 0;
}
