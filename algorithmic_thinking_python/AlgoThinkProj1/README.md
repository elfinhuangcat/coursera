README
======

####Some comments about my code:

My code can be located in the folder `src`. There are 3 python modules inside the folder, and they are:

* "main.py": This is the module fulfilling the project requirements. Tests written using unittest included.
* "submitVersion.py": This is the submission version. Because the Coursera test cannot support unittest package, I deleted all tests. Except for the tests, it contains same content as the "main.py" module.
* "unittestEx.py": An example comes from Python Tutorial showing how to use unittest module. Link: <https://docs.python.org/2/library/unittest.html>


####Project description (Requirements)

Reference: Project 1 - Algorithmic Thinking in Coursera

**Overview**
For your first project, you will write Python code that creates dictionaries corresponding to some simple examples of graphs. You will also implement two short functions that compute information about the distribution of the in-degrees for nodes in these graphs. You will then use these functions in the Application component of Module 1 where you will analyze the degree distribution of a citation graph for a collection of physics papers. This final portion of module will be peer assessed.

**Requirements:**

1. Define 3 constants storing the example graphs as dictionary.
2. Define a function named `make_complete_graph` to output a complete directed graph.
3. Define a function named `compute_in_degrees` to compute the in-degrees of a given graph stored as a dictionary.
4. Define a function named `in_degree_distribution` to compute the distribution of in-degrees of a given graph stored as a dictionary.