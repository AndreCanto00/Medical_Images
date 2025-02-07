# Medical_Images

## Project focus: Introduce the problem of lesion segmentation and implement a specific workflow over an
MRI volume.

### Details:
1. Briefly review the topic of tissue and lesion segmentation over MRI images.
2. Implement a workflow, motivating its main sub-steps, to pre-process an MRI image and segment a
lesion based on methods we have seen during lessons.
3. Segment the lesion and calculate the respective cross-sectional area over sagittal slice number 135
4. Identify sagittal slices that contain the lesion and extend the quantification of its cross-sectional
area to the whole volume. Try to repeat this process across axial slices. What are the main
challenges of segmenting this lesion with respect to other cerebral tissues and orthogonal views?
5. Add noise to the original dataset and check the performances of your implemented workflow with
respect to different levels of noise.
6. [Optional] manually segment the lesion starting from sagittal slice number 135, hence quantify
segmentation performances in terms of sensitivity, specificity and Dice coefficient.

### Note:
The implemented method does not need to be fully automated

### Dataset:
• You are provided with a T1 contrast enhanced MRI volume
