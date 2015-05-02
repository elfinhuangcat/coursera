#!/usr/bin/env python
import q1
import random
import time

"""
The DPA graph buiding algorithm defined in this module runs too slow and 
please refer to `q4_with_provided_code.py` for the faster and complete 
implementation.

This module is to answer the Question 4 of the Application 1 in 
the course Algorithmic Thinking. 

The major task is to implement the DPA algorithm. 
Pseudo-code for DPA algorithm:
<https://d396qusza40orc.cloudfront.net/algorithmicthink/AT-Homework1/DPA.jpg>
Here we will use:
n = 27770
m = 13

After generating the graph by running DPA, we need to compute a normalized 
log/log plot of the points in the graph's in-degree distribution.
"""

def make_complete_graph(num_nodes):
    """
    Function name: make_complete_graph
    Input: The number of nodes `num_nodes`;
    Output: A dictionary corresponding to a complete directed graph with
            the specified number of nodes. A complete graph contains all 
            possible edges subject to the restriction that self-loops are
            not allowed. The nodes of the graph should be numbered 0 to
            num_nodes - 1 when num_nodes is positive. Otherwise, the 
            function returns a dictionary corresponding to the empty graph.
    """
    # Create an empty graph with 0 nodes and 0 edges.
    complete_graph = dict()
    # Loop over all nodes
    for src_node in range(num_nodes):
        # Start with empty set of egdes for each node.
        complete_graph[src_node] = set()
        for dest_node in range(num_nodes):
            # If this is not a cyclic edge, add it to the graph.
            if dest_node != src_node:
                complete_graph[src_node] |= set([dest_node])
    return complete_graph

def gen_DPA_graph(n,m):
    """
    Function name: gen_DPA_graph
    Inputs: `n` - The number of nodes in the generated graph
            `m` - The maximum number of out degree of each node
    Output: A random directed graph represented by a dictionary. 
            <https://d396qusza40orc.cloudfront.net/algorithmicthink/
             AT-Homework1/DPA.jpg>
            Please check the above link to view the DPA algorithm 
            for detail.
    """
    if n < 1:
        raise ValueError("n must be an integer larger than 0.")
    if not (m >= 1 and m <= n):
        raise ValueError("Do no satisfy: 1 <= m <= n")
    dpa_graph = make_complete_graph(m)
    for i in range(m, n):
        in_degree_dict = q1.compute_in_degrees(dpa_graph)
        totindeg = sum(in_degree_dict.values())
        v_pi = set()
        
        # Choose randomly m nodes from V and add them to v_pi:
        # 1. Build the probability dictionary:
        prob_dict = dict()
        prev_p = 0
        #    Running this loop is equivalent to arrange the nodes
        #    in V along a [0,1) line. Each node occupies an 
        #    interval of the line according to their probability 
        #    being chosen.
        for node_index in range(0,len(dpa_graph)):
            p = ((in_degree_dict[node_index] + 1)
                 / (totindeg + len(dpa_graph)))
            prob_dict[(p + prev_p)] = node_index
            prev_p = p + prev_p
        #    Finish building the prob_dict
        
        # 2. Sampling m nodes and add them to v_pi
        for dummy_counter in range(0,m):
            random.seed(time.clock())
            p = random.random()
            tgt_index = binary_search_ceil(p, prob_dict.keys())
            v_pi.add(prob_dict[tgt_index])
        dpa_graph[i] = list(v_pi)
        # End of looping from m to n - 1
    return dpa_graph

def binary_search_ceil(x, arr):
    """
    Function name: binary_search_ceil
    Input: `x` - The value to be searched
           `arr` - The list storing all the values, sorted.
    Output: When the algorithm locates value lower and upper so that 
            lower < `x` <= upper, it will return upper. 
            When the algorithm locates value lower and upper so that 
            lower = `x` < upper, it will return lower.
    """
    lower = 0
    upper = len(arr) - 1
    while True:
        if upper - lower == 1:
            if arr[lower] == x:
                return arr[lower]
            else:
                return arr[upper]
        mid = int((lower + upper) / 2)
        if arr[mid] == x:
            return arr[mid]
        elif arr[mid] > x:
            upper = mid
        else:
            lower = mid
    

## TESTS:
if __name__ == '__main__':
    # Graph 1:
    time_stamp = time.clock()
    g1 = gen_DPA_graph(1000, 12)
    print "G1 Time elapse: " + str(time.clock() - time_stamp)
    
    """
    # Graph 2:
    time_stamp = time.clock()
    g1 = gen_DPA_graph(5000, 12)
    print "G2 Time elapse: " + str(time.clock() - time_stamp)
    
    # Graph 3:
    time_stamp = time.clock()
    g1 = gen_DPA_graph(10000, 12)
    print "G3 Time elapse: " + str(time.clock() - time_stamp)
    
    # Graph 4:
    time_stamp = time.clock()
    g1 = gen_DPA_graph(20000, 12)
    print "G4 Time elapse: " + str(time.clock() - time_stamp)
    """
    