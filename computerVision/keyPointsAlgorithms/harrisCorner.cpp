#include <opencv4/opencv2/opencv.hpp>
#include <iostream>

using namespace cv;
using namespace std;

void harrisCornerDetector() {
    // declaring image and gray as variables that are objects of the Math class
    // Mat -> represents an image matrix in opencv
    Mat image, gray;
    Mat output, output_norm, output_norm_scaled;

    // Loading the ACTUAL image
    image = imread("./images/veg2.jpg", IMREAD_COLOR);

    // Edge cases
    if(image.empty()) {
        cout << "Error loading image" << endl;
    }
    cv::imshow("Original image", image);

    // Converting the color image into grayscale
    // COLOR_BGR2GRAY is inisde the cv class namespace
    cvtColor(image, gray, cv::COLOR_BGR2GRAY);

    // Detecting corners
    output = Mat::zeros(image.size(), CV_32FC1);
    cornerHarris(gray, output,
        3,   // Neighbothood size
        3,   // Apertur parameter for the Sober operator
        0.04 // Harris free parameter
    );

    // Normalizing - convert corner values to int so they can be drawn
    normalize(output, output_norm, 0, 255, NORM_MINMAX, CV_32FC1, Mat());
    convertScaleAbs(output_norm, output_norm_scaled);

    // Drawing a circle around corners
    for (int j =0; j < output_norm.rows; j++) {
        for (int i =0; i < output_norm.cols; i++) {
            if((int)output_norm.at<float>(j, i) > 100){
                circle(image, Point(i, j), 2, Scalar(0, 0, 255), 2, 8, 0);
            }
        }
    }

    // Display
    cv:resize(image, image, cv::Size(), 1.5, 1.5);
    cv::imshow("Output Harris", image);
    cv::waitKey();
}

void shiTomassiCornerDetector() {
    Mat image, gray;
    Mat output, output_norm, output_norm_scaled;

    // Loading the ACTUAL image
    image = imread("./images/veg2.jpg", IMREAD_COLOR);

    // Edge cases
    if(image.empty()) {
        cout << "Error loading image" << endl;
    }
    cv::imshow("Original image", image);

    // Converting the color image into grayscale
    // COLOR_BGR2GRAY is inisde the cv class namespace
    cvtColor(image, gray, cv::COLOR_BGR2GRAY);

    // Detecting corners
    vector<Point2f> corners;
    goodFeaturesToTrack(
        gray,
        corners,
        100,     // Max number of corners to detect
        0.01,
        10,
        Mat(),
        3,
        false,
        0.04
    );

    // Drawing a circle around corners
    for (int i = 0; i <corners.size(); i++) {
        circle(image, corners[i], 4, Scalar(0, 255, 0), 2, 8, 0);
    }

    // Display
    cv:resize(image, image, cv::Size(), 1.5, 1.5);
    cv::imshow("Output Shi-Tomasi", image);
    cv::waitKey();
}


int main() {
    // harrisCornerDetector();
    shiTomassiCornerDetector();

    return 0;
}
