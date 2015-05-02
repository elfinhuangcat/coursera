#!/usr/bin/env python

"""
In this program, we will create three constants - 
`EX_GRAPH0`, `EX_GRAPH1`, `EX_GRAPH2` to represent 
the example graphs shown in the requirement page of 
project 1.
We will also implement two short functions that compute
information about the distribution of the in-degrees for
nodes in these graphs. These functions will be used in 
Application of Module 1.
"""

## GLOBAL VARIABLES (CONSTANTS)
## 1. Define the example graphs using dict.
##    They are all directed graphs!
EX_GRAPH0 = {0:set([1,2]),1:set(),2:set()}

EX_GRAPH1 = {0:set([1,4,5]),
             1:set([2,6]),
             2:set([3]),
             3:set([0]),
             4:set([1]),
             5:set([2]),
             6:set()}

EX_GRAPH2 = {0:set([1,4,5]),
             1:set([2,6]),
             2:set([3,7]),
             3:set([7]),
             4:set([1]),
             5:set([2]),
             6:set(),
             7:set([3]),
             8:set([1,2]),
             9:set([0,3,4,5,6,7])}

## FUNCTION DEFINITIONS

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


def compute_in_degrees(digraph):
    """
    Function name: compute_in_degrees
    Input: A directed graph `digraph`, which is represented as a dictionary.
    Output: A dictionary with the same set of keys (nodes) as `digraph`
            whose corresponding values are the number of edges whose head 
            matches a particular node. That is, to calculate the in-degrees 
            of the nodes and return them in a dictionary.
    """
    # Initialize the output dictionary
    in_degree_dict = dict()
    for src_node in digraph.keys():
        # Initialize to zero in-degree
        in_degree_dict[src_node] = 0
    
    # Traverse `digraph`
    for src_node in digraph.keys():
        # Each destination node's in-degree should increase by 1
        for dest_node in digraph[src_node]:
            in_degree_dict[dest_node] += 1
    return in_degree_dict


def in_degree_distribution(digraph):
    """
    Function name: in_degree_distribution
    Input: A directed graph `digraph`, which is represented as a dictionary.
    Output: A dictionary whose keys correspond to in-degrees of nodes in the
            graph. The value associated with each particular in-degree is 
            the number of nodes with that in-degree. In-degrees with no 
            corresponding nodes in the graph are not included in the 
            dictionary.
    """
    # Initialize an in-degree distribution dictionary with all possible
    # in-degrees and all values are zero.
    in_degree_distri_dict = dict()
    for in_degree in range(len(digraph)):
        in_degree_distri_dict[in_degree] = 0
    
    # Call the function `compute_in_degrees` to compute the in-degrees
    # of the given graph
    in_degree_dict = compute_in_degrees(digraph)
    
    # Loop over the `in_degree_dict` and compute the distribution
    for src_node in in_degree_dict.keys():
        # Increase the number of occurrence according to the value of
        # in-degree of each node.
        in_degree_distri_dict[in_degree_dict[src_node]] += 1
    
    # Delete the in-degree keys that with 0 occurrence
    for in_degree in in_degree_distri_dict.keys():
        if in_degree_distri_dict[in_degree] == 0:
            del in_degree_distri_dict[in_degree]
    
    return in_degree_distri_dict       