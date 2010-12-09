#include <iostream>
#include <iomanip>
#include <cmath>

typedef short Q15;

inline Q15 double_to_q15(double x)
{
	return x * 32768.0;
}

inline double q15_to_double(Q15 x)
{
	return x / 32768.0;
}

void print_q15(Q15 x)
{
	for (int i = 15; i >= 0; i--) {
		std::cout << ((x >> i) & 0x01);
	}
}

Q15 lpf(Q15 *history, const Q15 *coeffs, Q15 data)
{
	Q15 result = 0;
	
	for (int i = 5; i >= 0; i--) {
		history[i + 1] = history[i];
	}
	history[0] = data;
	
	Q15 m0 = (coeffs[0] * (history[0] + history[6])) >> 16;
	Q15 m1 = (coeffs[1] * (history[1] + history[5])) >> 16;
	Q15 m2 = (coeffs[2] * (history[2] + history[4])) >> 16;
	Q15 m3 = (coeffs[3] * (history[3])) >> 16;
	
	return m0 + m1 + m2 + m3;
}

int main(void)
{
	static const Q15 coeffs[] = {
			double_to_q15(-0.022663985459552),
			double_to_q15(0.0),
			double_to_q15(0.273977082565524),
			double_to_q15(0.497373805788057)
	};
	
	// Generate input data.
	static const int DATA_LEN = 128;
	double data_double[DATA_LEN];
	Q15 data[DATA_LEN];
	for (int i = 0; i < DATA_LEN; i++) {
		double theta = 360 * i / 180.0 * 3.1415 / DATA_LEN;
		data_double[i] = std::sin(theta) * 0.5;
		data_double[i] += 0.2 * ((2.0 * rand() / RAND_MAX) - 1.0);
		data[i] = double_to_q15(data_double[i]);
	}
	
	// Print coeffs.
	std::cout << "Coeffs:\n";
	for (int i = 0; i < 4; i++) {
		std::cout << "c" << i << " = ";
		print_q15(coeffs[i]);
		std::cout << "\n";
	}
	
	// Print input data.
	std::cout << "Input:\n";
	for (int i = 0; i < DATA_LEN; i++) {
#if 0
		std::printf("%16.8f", data_double[i]);
		std::cout << "\t";
#else
		print_q15(data[i]);
#endif
		std::cout << "\n";
	}
	
	// Print output data.
	std::cout << "Output:\n";
	Q15 history[] = {0, 0, 0, 0, 0, 0, 0};
	for (int i = 0; i < DATA_LEN; i++) {
		Q15 result = lpf(history, coeffs, data[i]);
#if 0
		std::printf("%16.8f", q15_to_double(result) );
		std::cout << "\t";
#else
		print_q15(result);
#endif
		std::cout << '\n';
	}
	
	return 0;
}

