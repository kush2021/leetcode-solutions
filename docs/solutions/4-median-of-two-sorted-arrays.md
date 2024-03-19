---
tags:
  - Array
  - Binary Search
  - Divide and Conquer
  - Hard
---

# Median of Two Sorted Arrays

## Intuition

At first glance, the naive solution comes to mind. Very simply, we can merge the
two arrays, resort them, and return the median value. However, this requires
$O(n + m)$ memory and $O((n + m)\log(n + m))$ time. Is there any way we can use
the fact that the arrays are already sorted to solve this problem?

To best think about it, consider a different question. I will assume that the
total number of elements is odd, however it is easy to consider the even case.
Suppose the question is to find a partition of both arrays (i.e., two
collections of elements, each possibly containing values from both arrays) such
that all elements in the left collection are less than (or equal to) all
elements in the right collection. This, by definition, is our median, because
now we can look at the overlapping value (there must be one overlapped value,
the median, since the total number of elements is odd).

The reason this perspective makes the algorithm simpler is because we only need
to keep track of a single value. In fact, we only need to consider a single
array. Let us consider the shorter of the two arrays. We will loop until we find
a solution. During each loop, we will pick a value to be the endpoint of the
left partition in the shorter array (i.e., highest value in the left partition
that belongs to our array). At this point, we have enough information to
calculate the values for the highest left element for both arrays and the
smallest right element for both arrays. We can use this to check for our success
condition.

The partitions can be rephrased simply into, "How many elements of the shorter
array will belong to the left partition?". This is the same as searching for the
highest in the left partition belonging to our array.

## Approach

Consider the shorter array. Let us first guess that there will be $\frac{n}{2}$
elements from our array in the left collection. We can find the index of the
left collection for the second array. We must take the total size of the left
partition ($(n + m)$ / 2) and subtract the amount of elements already chosen
(remember to account for zero-based indexing). We can now use these indices to
get the element values for the lowest and highest partition values in both
arrays. Once doing so, we know we have the median if the highest left from the
first array is less than the lowest right from the second array, and vice versa.
Otherwise, we adjust our initial guess, either subtracting one if our array has
too many elements in the left partition, or adding one for the opposite case.

## Complexity

### Time Complexity

The time complexity is $O(\min\{n, m\})$ because we are traversing the shorter
array. Since we can only add or subtract one from our initial guess, we cannot
achieve logarithmic time complexity.

### Space Complexity

The space complexity is $O(1)$ because we are only allocating a handful of
variables to simplify our code.

## Code

```cpp
class Solution {
public:
    double findMedianSortedArrays(vector<int>& nums1, vector<int>& nums2) {
        const unsigned short n = nums1.size(), m = nums2.size();
        if (m < n) return findMedianSortedArrays(nums2, nums1);
        if (n == 0) {
            if (m % 2) return nums2[m / 2];
            return (nums2[m / 2] + nums2[m / 2 - 1]) / 2.0;
        }
        const unsigned short total = n + m;
        short mid1 = n / 2;
        while (true) {
            const short mid2 = total / 2 - (mid1 + 1) - 1;
            const int l1 = (mid1 >= 0) ? nums1.at(mid1) : std::numeric_limits<int>::min();
            const int r1 = ((mid1 + 1) < n) ? nums1.at(mid1 + 1) : std::numeric_limits<int>::max();
            const int l2 = (mid2 >= 0) ? nums2.at(mid2) : std::numeric_limits<int>::min();
            const int r2 = ((mid2 + 1) < m) ? nums2.at(mid2 + 1) : std::numeric_limits<int>::max();
            if ((l1 <= r2) && (l2 <= r1)) {
                if (total % 2) return std::min(r1, r2);
                return (std::max(l1, l2) + std::min(r1, r2)) / 2.0;
            } else if (l1 > r2) mid1--;
            else mid1++;
        }
        throw;
    }
};
```
