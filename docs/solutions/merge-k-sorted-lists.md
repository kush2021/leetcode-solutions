---
tags:
  - Divide and Conquer
  - Hard
  - Heap
  - Linked List
  - Merge Sort
---

# Merge K Sorted Lists

## Intuition

We can solve this problem by taking advantage of a data structure that can easily store and return the minimum value of all lists: a minimum heap (or priority queue). We will insert all nodes into the heap and until the heap is empty, continue popping the smallest value, adding it to our list, and replacing the popped value with the next one from that list.

## Approach

Create a minimum heap. Insert all nodes into the heap (as long as they are not null). If all the nodes are null, we can return null. Create a head and tail node for our new list.

We can loop until the heap is empty. During each iteration, pop the smallest value from the heap and append it to our list. Afterwards, check if the next node in the list that the smallest node belongs to exists. If so, add it to the heap.

Return our new list.

## Code

### Time Complexity

The time complexity is $O(n\log{k})$ where $n$ is the total number of elements in all lists and $k$ is the total number of lists. Our main loop will iterate $n$ times and each iteration costs $\log{k}$ for our heap operations.

### Space Complexity

The space complexity is $O(k)$ because we have a heap that contains $k$ elements at a time.

## Code

```cpp
class Solution {
public:
  ListNode* mergeKLists(std::vector<ListNode*>& lists) {
    std::priority_queue<ListNode*, std::vector<ListNode*>, compare> minHeap;
    populateHeap(minHeap, lists);
    if (minHeap.size() == 0) return nullptr;
    ListNode* head = new ListNode();
    ListNode* tail = head;
    merge(tail, minHeap);
    return (head -> next);
  }

private:
  struct compare {
    bool operator() (const ListNode* a, const ListNode* b) {
      return (a -> val) > (b -> val);
    }
  };

  void populateHeap(
    std::priority_queue<ListNode*, std::vector<ListNode*>, compare>& heap,
    const std::vector<ListNode*> lists
  ) {
    for (auto list: lists) if (list) heap.push(list);
  }

  void merge(
    ListNode*& tail,
    std::priority_queue<ListNode*, std::vector<ListNode*>, compare>& heap
  ) {
    while (heap.size()) {
      ListNode* smallest = heap.top();
      heap.pop();
      tail -> next = smallest;
      tail = tail -> next;
      smallest = smallest -> next;
      if (smallest) heap.push(smallest);
    }
  }
};
```
