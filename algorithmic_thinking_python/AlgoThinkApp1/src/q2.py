#!/usr/bin/env python
import q1
import random
import time
"""
This module solves the Question 2 of the Application 1 in the course 
Algorithmic Thinking. 

In this module, we have a program for the user to generate random 
directed graphs. The generation method is: When the program is deciding
whether or not to generate a directed edge from i to j, there is 50% of
chance that the answer is "Yes" and 50% of "No".

When the user needs to calculate the in-degree distribution of a directed
graph, please refer to the methods defined in module "q1.py".

We will also generate several random directed graphs and try to figure
out the shape of the distribution of this kind of random-generated 
directed graphs.
"""

## FUNCTION DEFINITIONS
def gen_rand_digraph(prob_gen_edge, n):
    """
    Function name: gen_rand_digraph
    Input: `prob_gen_edge` - the probability of generating a directed
                             edge from node i to node j.
            `n` - the number of nodes in the graph.
    Output: A directed graph stored as a dictionary, where keys of the 
            dictionary are source nodes and the values corresponding to 
            the each key represent tail nodes. Whether or not there is 
            an edge from i to j is decided by the input probability.
    """
    digraph = dict()
    for head_node in range(n):
        digraph[head_node] = list()
        for tail_node in range(n):
            if head_node != tail_node:
                # We don't want any cycles in the graph
                random.seed(time.clock())
                # Generate a pseudo-random float number between 0 and 1
                p = random.random()
                if p < prob_gen_edge:
                    # Time to generate an edge!
                    digraph[head_node].append(tail_node)
    
    return digraph

## TESTS
if __name__ == '__main__': 
    ## Generate several graphs and see the shapes
    # Graph 1
    digraph1 = gen_rand_digraph(0.2, 100)
    print "Finish graph 1 generation."
    digraph1_distri = q1.in_degree_distribution_normal(digraph1)
    print "Finish normal distribution calculation."
    q1.loglog_plot_dict_with_peak(digraph1_distri, 
                                  "log of in-degrees",
                                  ("log of percentage of corresponding" +
                                   " in-degree"),
                                  ("loglog Plot - Distribution of " + 
                                   "In-degrees in Randgraph P=0.2/N=100"),
                                  10,10,
                                  "q2plot1")
    print "q2plot1.png generated."
    
    
    # Graph 2
    digraph2 = gen_rand_digraph(0.2, 1000)
    print "Finish graph 2 generation."
    digraph2_distri = q1.in_degree_distribution_normal(digraph2)
    print "Finish normal distribution calculation."
    q1.loglog_plot_dict_with_peak(digraph2_distri, 
                                  "log of in-degrees",
                                  ("log of percentage of corresponding" +
                                   " in-degree"),
                                  ("loglog Plot - Distribution of " + 
                                   "In-degrees in Randgraph P=0.2/N=1000"),
                                  10,10,
                                  "q2plot2")
    print "q2plot2.png generated."
    
    
    # Graph 3
    digraph3 = gen_rand_digraph(0.3, 1000)
    print "Finish graph 3 generation."
    digraph3_distri = q1.in_degree_distribution_normal(digraph3)
    print "Finish normal distribution calculation."
    q1.loglog_plot_dict_with_peak(digraph3_distri, 
                                  "log of in-degrees",
                                  ("log of percentage of corresponding" +
                                   " in-degree"),
                                  ("loglog Plot - Distribution of " + 
                                   "In-degrees in Randgraph P=0.3/N=1000"),
                                  10,10,
                                  "q2plot3")
    print "q2plot3.png generated."
    