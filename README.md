# README: Gradient-Based Image Edge Enhancement

## Overview
This MATLAB script demonstrates the application of the **Roberts Cross Gradient Operator** for detecting and enhancing edges in grayscale images. Various edge enhancement transformations are applied based on gradient thresholds and user-defined gray levels for edges and backgrounds.

---

## Features
1. **Gradient Image Calculation**: Computes the gradient of the input image using Roberts convolution masks.
2. **Edge Enhancement Cases**:
   - Case 1: Displays the gradient image.
   - Case 2: Retains the smooth background, edges are represented by their gradient values.
   - Case 3: Retains the smooth background, edges are set to a fixed gray level (`255`).
   - Case 4: Sets the background to black (`0`), edges retain gradient values.
   - Case 5: Converts the image into a binary gradient image with edges as white (`255`) and background as black (`0`).

---

## Requirements
- MATLAB 2022b or later.
- A grayscale input image in `.png` format.

---

## Usage

1. Place your grayscale image in the working directory and name it as `airplane_grayscale.png`. Modify the `image_path` variable in the code if necessary.

2. Run the script. The following transformations will be displayed:
   - Original Image
   - Gradient Image
   - Edge enhancement cases (2 to 5)

---

## Parameters

### User-defined Variables:
- `T`: Threshold value for gradient-based edge detection (default: `25`).
- `L_B`: Background gray level (default: `0` for black).
- `L_G`: Edge gray level (default: `255` for white).

### Roberts Convolution Masks:
- `h1 = [1 0; 0 -1]`
- `h2 = [0 1; -1 0]`

---

## Function Details

### 1. `compute_gradient`
**Purpose**: Computes the gradient image using Roberts masks.

- Pads the input image to handle edge pixels.
- Convolves the input image with Roberts masks.
- Uses the L2 norm to calculate gradient magnitude.

### 2. `use_gradient_threshold`
**Purpose**: Applies edge enhancement transformations based on the gradient image and user-defined parameters.

- Compares gradient values with the threshold `T`.
- Modifies edge and background pixels according to `L_G` and `L_B`.

---

## Output
The script produces a figure with six subplots:
1. **Original Image**: Unprocessed input image.
2. **Case 1**: Gradient image.
3. **Case 2**: Edges retain gradient values, smooth regions retain original intensity.
4. **Case 3**: Edges set to `255`, smooth regions retain original intensity.
5. **Case 4**: Background set to `0`, edges retain gradient values.
6. **Case 5**: Binary edge image with edges as `255` and background as `0`.

---

## Example
For an input image `airplane_grayscale.png`:
- Threshold (`T`): 25
- Background Gray Level (`L_B`): 0
- Edge Gray Level (`L_G`): 255

Results include the gradient map and enhanced images per the described cases.

---

## Acknowledgments
The code uses standard image processing techniques and is tailored for educational purposes in gradient-based edge detection and enhancement.

**Author**: Krishnaprasad Sreekumar Nair  
**Email**: [ksreekum@asu.edu](mailto:ksreekum@asu.edu)
