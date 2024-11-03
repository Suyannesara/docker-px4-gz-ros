// Verifies opencv installation
// #include <opencv2/opencv.hpp>
#include <opencv4/opencv2/opencv.hpp>
#include <iostream>

using namespace cv;

int main() {
    Mat image = imread("/home/suyanne/Pictures/suyanne.jpeg"); // Substitua por um caminho válido para uma imagem

    if (image.empty()) {
        std::cout << "Não foi possível carregar a imagem." << std::endl;
        return -1;
    }

    imshow("Imagem", image);
    waitKey(0);

    return 0;
}
