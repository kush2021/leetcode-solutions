# C++ Optimal Solution - Median of Two Sorted Arrays

## Intuition
<!-- Describe your first thoughts on how to solve this problem. -->
The naive approach to solving this problem is to merge both arrays and find the median. However, this requires additional memory (to store the merged array) and time complexity (to resort the array). We can solve this problem without using additional space in faster time.

Consider looking at this problem from another perspective. Instead of finding the median, assume we want to find a partition in both arrays such that the highest elements in both lower partitions are less than the lowest elements in both highest partitions of opposite arrays. In other words, $l_1 \le r_2$ and $l_2 \le r_1$. When this condition is satisfied, we have found the median.

## Approach
<!-- Describe your approach to solving the problem. -->
We can use a binary search on the smaller of the two arrays to find a successful partition. Run a binary search on the smaller array to find our first attempt at a partition. The element immediately below this partition will be the left elements and the partition element itself will be the right element. Check if we have satisfied the return condition. If not, adjust the start and end parameters of the binary search and repeat.

## Complexity
### Time Complexity
<!-- Add your time complexity here, e.g. $$O(n)$$ -->
The time complexity is $O(\log(\min\{n, m\})$ because we are running a binary search on the smallest size array.

### Space Complexity
<!-- Add your space complexity here, e.g. $$O(n)$$ -->
The space complexity is $O(1)$ because we are only allocating a constant number of variables.

## Code
```cpp
class Solution {
public:
    double findMedianSortedArrays(vector<int>& nums1, vector<int>& nums2) {
        if (nums2.size() < nums1.size()) return findMedianSortedArrays(nums2, nums1);
        int start = 0, end = nums1.size(), mid = (nums1.size() + nums2.size() + 1) / 2;
        while (start <= end) {
            const int i = (start + end) / 2;
            const int j = mid - i;
            const int l1 = (i > 0) ? nums1[i - 1] : std::numeric_limits<int>::min();
            const int r1 = (i < nums1.size()) ? nums1[i] : std::numeric_limits<int>::max();
            const int l2 = (j > 0) ? nums2[j - 1] : std::numeric_limits<int>::min();
            const int r2 = (j < nums2.size()) ? nums2[j] : std::numeric_limits<int>::max();
            if (l1 <= r2 && l2 <= r1) {
                if ((nums1.size() + nums2.size()) % 2) return std::max(l1, l2);
                return (std::max(l1, l2) + std::min(r1, r2)) / 2.0; 
            } else if (l1 > r2) end = i - 1;
            else start = i + 1;
        }
        return 0.0;
    }
};
```
