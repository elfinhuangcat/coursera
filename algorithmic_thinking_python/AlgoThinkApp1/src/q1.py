#!/usr/bin/env python
import urllib # To read the url file
import string
import matplotlib.pyplot as plt

"""
This module solves the Question 1 of the Application 1 in the course 
Algorithmic Thinking. 
In this module, we will load a provided citation graph by parsing the
text representation of the graph. The url for the text is : 
<http://storage.googleapis.com/codeskulptor-alg/alg_phys-cite.txt>
Our task is to compute the in-degree distribution for the graph and 
compute a log/log plot of the points in the normalized distribution.
"""

## GLOBAL VARIABLES (CONSTANTS)
LINK_CITATION_GRAPH = ("http://storage.googleapis.com/" + 
                       "codeskulptor-alg/alg_phys-cite.txt")

## FUNCTION DEFINITIONS
def read_and_parse_citation_graph():
    """
    Function name: read_and_parse_citation_graph
    Input: NA
    Output: The directed citation graph stored in a dictionary, where
            each key represents a head node in the graph and the values
            corresponding to the key represent the tail nodes connected
            to the head node by directed edges.
    """
    # Open the file storing the citation graph
    f = urllib.urlopen(LINK_CITATION_GRAPH)
    # Construct an empty graph:
    graph = dict()
    for line in f:
        nodes = string.split(line," ")
        # The first element is the head node.
        # The last element is ""
        # The elements between them are tail nodes.
        graph[nodes[0]] = nodes[1:-1]
    
    return graph

def compute_in_degrees(digraph):
    """
    Function name: compute_in_degrees
    Input: A directed graph `digraph`, which is represented as a dictionary.
    Output: A dictionary with the same set of keys (nodes) as `digraph`
            whose corresponding values are the number of edges whose tail 
            matches a particular node. That is, to calculate the in-degrees 
            of the nodes and return them in a dictionary.
    """
    # Initialize the output dictionary
    in_degree_dict = dict()
    for tgt_node in digraph.keys():
        # Initialize to zero in-degree
        in_degree_dict[tgt_node] = 0
    
    # Traverse `digraph`
    for src_node in digraph.keys():
        # Each destination node's in-degree should increase by 1
        for tgt_node in digraph[src_node]:
            in_degree_dict[tgt_node] += 1
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

def in_degree_distribution_normal(digraph):
    """
    Function name: in_degree_distribution_normal
    Input: A directed graph `digraph`, which is represented as a dictionary.
    Output: A dictionary whose keys correspond to in-degrees of nodes in the
            graph. The value associated with each particular in-degree is 
            the percentage of occurence with that in-degree. In-degrees with 
            no corresponding nodes in the graph are not included in the 
            dictionary.
    """
    in_degree_distri_dict = in_degree_distribution(digraph)
    sum_of_occur = sum(in_degree_distri_dict.values())
    
    for key in in_degree_distri_dict.keys():
        value = in_degree_distri_dict[key]
        in_degree_distri_dict[key] = float(value) / float(sum_of_occur)
    return in_degree_distri_dict

def loglog_plot_dict_with_peak(dictionary, xlab, ylab, t, 
                               basex, basey, file_name):
    """
    Function name: loglog_plot_dict_with_peak
    Inputs: `dictionary` - A dictionary with numeric keys and numeric values. 
                           Each key can only correspond to one value.
            `xlab` - The x-axis label
            `ylab` - The y-axis label
            `t` - The title of the plot
            `basex` - The logarithm base of x-axis
            `basey` - The logarithm base of y-axis
            `file_name` - The name of the saved png file. A string.
    Output: A loglog line plot of the input data `dict`. The labels of the
            axes are defined by `xlab` and `ylab`. The title of the 
            plot is defined by `t`. The plot will be save in the directory 
            `src` which holds the source modules. The name of the plot will 
            be `file_name.png`. The base of the logarithm is defined by 
            `basex` and `basey`.
    """
    plt.loglog(dictionary.keys(), dictionary.values(),
               'bo',
               basex = basex, basey = basey)
    plt.grid(True)
    plt.xlabel(xlab)
    plt.ylabel(ylab)
    plt.title(t)
    # Find the peak:
    peak = (-250,-250)
    for key in dictionary.keys(): 
        if dictionary[key] > peak[1]:
            peak = (key, dictionary[key])
    plt.text(x = peak[0] + peak[0] / 10,
             y = peak[1] + peak[1] / 10,
             s = 'Peak(x=' + str(peak[0]) + ',y=' + str(peak[1]) + ')')
    plt.savefig(file_name + ".png")
    plt.close()
    
def loglog_plot_dict(dictionary, xlab, ylab, t,
                     basex, basey, file_name):
    """
    Function name: loglog_plot_dict
    Inputs: `dictionary` - A dictionary with numeric keys and numeric values. 
                           Each key can only correspond to one value.
            `xlab` - The x-axis label
            `ylab` - The y-axis label
            `t` - The title of the plot
            `basex` - The logarithm base of x-axis
            `basey` - The logarithm base of y-axis
            `file_name` - The name of the saved png file. A string.
    Output: A loglog line plot of the input data `dict`. The labels of the
            axes are defined by `xlab` and `ylab`. The title of the 
            plot is defined by `t`. The plot will be save in the directory 
            `src` which holds the source modules. The name of the plot will 
            be `file_name.png`. The base of the logarithm is defined by 
            `basex` and `basey`.
    """
    plt.loglog(dictionary.keys(), dictionary.values(),
               'bo',
               basex = basex, basey = basey)
    plt.grid(True)
    plt.xlabel(xlab)
    plt.ylabel(ylab)
    plt.title(t)
    plt.savefig(file_name + ".png")
    plt.close()

if __name__ == '__main__':
    ## TESTS
    graph = read_and_parse_citation_graph()
    normal_distri = in_degree_distribution_normal(graph)
    # Generate the plot and output to "q1plot.png".
    (loglog_plot_dict
     (normal_distri,
     "log10 of in-degrees",
     "log10 of percentage of corresponding in-degree",
     ("loglog Point Plot - Distribution of In-degrees in " +
      "the Citation Graph"),
      10,10,
     "q1plot"))