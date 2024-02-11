double findMedianSortedArrays(int* nums1, int nums1Size, int* nums2, int nums2Size) {
float median;
int total_size = nums1Size + nums2Size;
int nums[total_size];

for(int i=0;i<total_size;i++){
        if(i<nums1Size){
                nums[i] = *(nums1+i);
        }
        else
        {
                nums[i] = *(nums2+i-nums2Size);
        }
}
bubblesort(nums,total_size);

if(total_size % 2 == 0)void swap(int* arr, int i, int j) 
{ 
    int temp = arr[i]; 
    arr[i] = arr[j]; 
    arr[j] = temp; 
} 
void bubbleSort(int arr[], int n) 
{ 
    int i, j; 
    for (i = 0; i < n - 1; i++) 
  
        // Last i elements are already 
        // in place 
        for (j = 0; j < n - i - 1; j++) 
            if (arr[j] > arr[j + 1]) 
                swap(arr, j, j + 1); 
}
double findMedianSortedArrays(int* nums1, int nums1Size, int* nums2, int nums2Size) {
float median;
int total_size = nums1Size + nums2Size;
int nums[total_size];

for(int i=0;i<total_size;i++){
        if(i<nums1Size){
                nums[i] = *(nums1+i);
        }
        else
        {
                nums[i] = *(nums2+i-nums2Size);
        }
}
bubbleSort(nums,total_size);

if(total_size % 2 == 0)
        {
        median = (nums[total_size/2] + nums[total_size/2+1])/2;
        }
    else
        {
median = nums[(total_size+1)/2];
        }

        return median;
}
void swap(int* arr, int i, int j) 
{ 
    int temp = arr[i]; 
    arr[i] = arr[j]; 
    arr[j] = temp; 
} 
void bubbleSort(int arr[], int n) 
{ 
    int i, j; 
    for (i = 0; i < n - 1; i++) 
  
        // Last i elements are already 
        // in place 
        for (j = 0; j < n - i - 1; j++) 
            if (arr[j] > arr[j + 1]) 
                swap(arr, j, j + 1); 
}
double findMedianSortedArrays(int* nums1, int nums1Size, int* nums2, int nums2Size) {
float median;
int total_size = nums1Size + nums2Size;
int nums[total_size];

for(int i=0;i<total_size;i++){
        if(i<nums1Size){
                nums[i] = *(nums1+i);
        }
        else
        {
                nums[i] = *(nums2+i-nums2Size);
        }
}
bubbleSort(nums,total_size);

if(total_size % 2 == 0)
        {
        median = (nums[total_size/2] + nums[total_size/2+1])/2;
        }
    else
        {
median = nums[(total_size+1)/2];
        }

        return median;
}

        {
        median = (nums[total_size/2] + nums[total_size/2+1])/2;
        }
    else
        {
median = nums[(total_size+1)/2];
        }

        return median;
}
void swap(int* arr, int i, int j) 
{ 
    int temp = arr[i]; 
    arr[i] = arr[j]; 
    arr[j] = temp; 
} 
void bubbleSort(int arr[], int n) 
{ 
    int i, j; 
    for (i = 0; i < n - 1; i++) 
  
        // Last i elements are already 
        // in place 
        for (j = 0; j < n - i - 1; j++) 
            if (arr[j] > arr[j + 1]) 
                swap(arr, j, j + 1); 
}