#!/usr/bin/env python
import q1
import math
"""
In this module, we try to answer the question 3 in Application 1 of 
the Algorithmic Thinking course. That is, we need to figure out the 
value of n and m.

`n` is the number of nodes that is going to be generated by the DPA 
algorithm. This one is easy since we just need to generate same number 
of nodes as the citation graph. Thus, n = 27770.

`m` should be an integer close to the average out-degree of the physics 
citation graph. We need to figure out the value of `m` in this module.
"""

def compute_out_degrees(digraph):
    """
    Function name: compute_out_degrees
    Input: A directed graph `digraph`, which is represented as a dictionary.
    Output: A dictionary with the same set of keys (nodes) as `digraph`
            whose corresponding values are the number of edges whose head 
            matches a particular node. That is, to calculate the in-degrees 
            of the nodes and return them in a dictionary.
    """
    # Create dictionary to store the result
    out_degree_dict = dict()
    for src_node in digraph.keys(): 
        # The out-degree of a node is the number of nodes it points to:
        out_degree_dict[src_node] = len(digraph[src_node])
    return out_degree_dict

def compute_avg_out_degree(digraph):
    """
    Function name: compute_avg_out_degree
    Input: A directed graph `digraph`, which is represented as a dictionary.
    Output: A numeric number which represents the average out-degree of the 
            input directed graph.
    """
    out_degree_dict = compute_out_degrees(digraph)
    return float(sum(out_degree_dict.values()))/float(len(out_degree_dict))

## TESTS: 
if __name__ == "__main__":
    # Compute the average out-degree of the citation graph:
    cit_graph = q1.read_and_parse_citation_graph()
    m_float = compute_avg_out_degree(cit_graph)
    print "The avg out-degree: " + str(m_float)
    print "The value of n we will use: " + str(len(cit_graph))
    print "The value of m we will use: " + str(int(math.ceil(m_float)))
    
