#include "mymath.h"

double int_pow(double x, int n) {
	if (n == 0) {
		return 1;
	}	
	double res = int_pow(x * x, n / 2);
	return n % 2 ? x * res : res;
}

long long factorial_impl(int n, long long result) {
	if ( n == 0) return 1;
	return factorial_impl(n - 1, n * result);
}

long long factorial(int n) {
	return factorial_impl(n, 1);
}

double exp_impl(double x, double epsilon) {
	double sum = 0;
	int i = 0;
	double elem = int_pow(x, i) / factorial(i);
	while (elem >= epsilon) {
		sum += elem;
		i += 1;
		elem *= x;
		elem /= i;
	}
	return sum;
}

double exp(double x) {
	return exp_impl(x, 1e-6);
}
