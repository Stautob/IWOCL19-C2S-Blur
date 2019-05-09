
__global__ void blur(unsigned char* input_image, unsigned char* output_image, int const width, int const height) {

	unsigned int const pixel_offset = blockIdx.x * blockDim.x + threadIdx.x;

	int const x = pixel_offset % width;
	int const y = pixel_offset / width;
	int const filter_size = 5;
	if (pixel_offset < (width * height)) {
		float output_red = 0;
		float output_green = 0;
		float output_blue = 0;
		int hits = 0;
		for (int ox = -filter_size; ox <= filter_size; ++ox) {
			for (int oy = -filter_size; oy <= filter_size; ++oy) {
				if ((x + ox) >= 0 && (x + ox) < width && (y + oy) >= 0 && (y + oy) < height) {
					int const color_offset = (pixel_offset + ox + oy * width) * 3;
					output_red += input_image[color_offset];
					output_green += input_image[color_offset + 1];
					output_blue += input_image[color_offset + 2];
					++hits;
				}
			}
		}
		output_image[pixel_offset * 3] = output_red / hits;
		output_image[pixel_offset * 3 + 1] = output_green / hits;
		output_image[pixel_offset * 3 + 2] = output_blue / hits;
	}
}

void filter(unsigned char* input_image, unsigned char* output_image, unsigned int const width, unsigned int const height) {
	unsigned char *dev_input;
	unsigned char *dev_output;

	unsigned int const size = width * height * 3;

	cudaMallocManaged(reinterpret_cast<void **>(&dev_input), size * sizeof(unsigned char));
	cudaMallocManaged(reinterpret_cast<void **>(&dev_output), size * sizeof(unsigned char));

	memcpy(dev_input, input_image, size * sizeof(unsigned char));

	cudaDeviceSynchronize();

	dim3 blockDims { 128 };
	dim3 gridDims { (width * height + 127) / 128 };

	blur<<< gridDims, blockDims >>>(dev_input, dev_output, width, height);

	cudaDeviceSynchronize();

	memcpy(output_image, dev_output, size * sizeof(unsigned char));

	cudaFree(dev_input);
	cudaFree(dev_output);
}
