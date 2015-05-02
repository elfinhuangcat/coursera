"""
For the Project component of Module 2, you will first write Python code that 
implements breadth-first search. Then, you will use this function to compute 
the set of connected components (CCs) of an undirected graph as well as 
determine the size of its largest connected component. Finally, you will write 
a function that computes the resilience of a graph (measured by the size of 
its largest connected component) as a sequence of nodes are deleted from the 
graph.

Note:
To implement the queue used in BFS, we recommend one of two options. For 
desktop Python users, you may use the collections.deque module which 
supports O(1) enqueue and dequeue operations. Note that using the list 
operations pop(0) and append(...) to model enqueue and dequeue will lead to a 
slower implementation since popping from the front of a list is O(n) in 
desktop Python.
"""

import collections
import random

## FUNCTION DEFINITIONS:
## 1. BREADTH-FIRST SEARCH
def bfs_visited(ugraph, start_node):
    """
    Function name: bfs_visited
    This function takes the undirected graph and the starting node and 
    computes the set consisting of all nodes that are visited by a 
    breadth-first search that starts at start_node.
    Args: 
        `ugraph`: An undirected graph, represented as a dictionary, where the 
                  key of an item is the starting node and the corresponding 
                  value is a set containing all the neighbors of the key.
        `start_node`: An integer representing the starting node, and it must 
                      appear in ugraph.keys().
    Returns:
        The set of all nodes visited by the algorithm.
    """
    Q = collections.deque()
    visited = set([start_node])
    Q.append(start_node)  # Enqueue
    while len(Q) > 0 :
        j = Q.popleft()  # Dequeue
        for node in ugraph[j]:
            # For each neighbor node of j:
            if node not in visited:
                visited.add(node)
                Q.append(node)  # Enqueue node
    return visited  # Return the set of nodes visited by this algorithm.

## 2. CONNECTED COMPONENT
def cc_visited(ugraph):
    """
    Takes the undirected graph ugraph and returns a list of sets, where each 
    set consists of all the nodes (and nothing else) in a connected component, 
    and there is exactly one set in the list for each connected component in 
    ugraph and nothing else.
    Args: 
        `ugraph`: An undirected graph, represented as a dictionary, where the 
                  key of an item is the starting node and the corresponding 
                  value is a set containing all the neighbors of the key.
    Returns:
        A list of sets, where each set consists of all the nodes (and nothing 
        else) in a connected component, and there is exactly one set in the 
        list for each connected component in ugraph and nothing else.
    """
    remain_nodes = set(ugraph.keys())
    cc = list()
    while len(remain_nodes) > 0:
        i = random.sample(remain_nodes,1)
        # DEBUGGGGG
        print("i is " + str(i))
        
        w = bfs_visited(ugraph, i)
        cc.append(w)
        remain_nodes = remain_nodes - w
    
    return cc

## TESTS
if __name__ == "__main__":
    ugraph = {1:set([2,3]),2:set([1]),3:set([1])}
    print(cc_visited(ugraph))