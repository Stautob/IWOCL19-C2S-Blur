#include "filter.h"
#include "lodepng.h"

#include <string>
#include <iostream>
#include <vector>

int main(int argc, char** argv) {

	if (argc != 3) {
		std::cout << "Pass input file name and output file name!" << std::endl;
		return EXIT_FAILURE;
	}

	std::string const input_file = argv[1];
	std::string const output_file = argv[2];

	std::vector<unsigned char> in_image;

	unsigned int width;
	unsigned int height;

	if (auto error = lodepng::decode(in_image, width, height, input_file, LCT_RGB)) {
		std::cout << "Decoder error " << error << ": " << lodepng_error_text(error) << std::endl;
	}

	std::vector<unsigned char> out_image(in_image.size());

	filter(in_image.data(), out_image.data(), width, height);

	if (auto error = lodepng::encode(output_file, out_image, width, height, LCT_RGB)) {
		std::cout << "Encoder error " << error << ": " << lodepng_error_text(error) << std::endl;
	}

	return EXIT_SUCCESS;
}
