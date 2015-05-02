#!/usr/bin/env python
import DPATrail_q4_provided_code
import time
import q1

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
    dpa_graph = make_complete_graph(m)
    dpa_trail = DPATrail_q4_provided_code.DPATrial(m)
    for i in range(m,n):
        neighbors = dpa_trail.run_trial(m)
        dpa_graph[i] = neighbors
    return dpa_graph

def test_print_dict_graph(digraph):
    """
    Function name: test_print_dict_graph
    Input: A directed graph represented as a dictionary.
    Output: Print message - the whole graph.
    """
    for head_node in digraph.keys():
        print str(head_node) + " - " + str(digraph[head_node])


## MAIN
if __name__ == '__main__':
    # Graph
    time_stamp = time.clock()
    g = gen_DPA_graph(27770,12)
    print "gen time elapse: " + str(time.clock() - time_stamp)
    in_degree_dict = q1.in_degree_distribution_normal(g)
    
    q1.loglog_plot_dict(in_degree_dict,
                        "log10 of in-degrees",
                        "log10 of percentage of corresponding in-degree",
                        ("loglog Point Plot - Distribution of In-degrees in "+
                         "the DPA Graph"),
                        10,10,
                        "q4plot")

    