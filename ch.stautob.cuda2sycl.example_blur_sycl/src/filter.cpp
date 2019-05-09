/* To be created in the demonstration */
#include <algorithm>

void filter(unsigned char* input_image, unsigned char* output_image, unsigned int const width, unsigned int const height) {
	/* Dummy impl allowing compilation */
	std::copy(input_image, input_image + width *height *3 *sizeof (unsigned char), output_image);
}
