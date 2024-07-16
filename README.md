# COBOL Bloom

A quick implementation of a Bloom filter in COBOL

## Introduction

[Bloom filters](https://en.wikipedia.org/wiki/Bloom_filter) are probabilistic data structures used to test whether an element is a member of a set. They are highly efficient in terms of space and time, making them suitable for applications where the cost of querying a database or performing a full search is high. In contexts like COBOL applications, which often run on legacy systems with limitations on processing power and memory, Bloom filters can optimize operations like checking for the existence of an item without retrieving the entire dataset.

This repository holds a quick COBOL implementation.

## How the Code Works

This COBOL program implements a simple Bloom filter for integer values. Here’s a breakdown of its functionality:

    * Data Initialization: It initializes a filter array to store the Bloom filter's state and sets up various other data structures for input handling and hash computation.
    * User Input: The program collects up to five integers from the user, calculates two hash values for each integer, and marks the corresponding positions in the Bloom filter as 1.
    * Bloom Filter State: After populating the filter, it displays the current state of the Bloom filter.
    * Random Number Generation and Checks: Generates five random numbers and checks them against the Bloom filter to see if they might be in the set.
    * Entered Number Verification: Checks each user-entered number against the filter to validate if they might be in the set based on the filter’s state.

## How to Compile the Code

To compile this COBOL program, ensure that you have a COBOL compiler like GnuCOBOL installed on your system. Use the following command to compile the program:

```bash
$ cobc -free -std=cobol2002 -x -o bloom BloomFilter.cbl
```

## Potential Improvements

So many... For example:

    * Enhanced Hash Functions: Implement more sophisticated hash functions to reduce the chance of collisions and distribute hash values more evenly.
    * Scalability Options: Allow dynamic resizing of the Bloom filter or parameters like the number of hash functions based on the expected number of inputs.
    * Support for String Inputs: Adapt the hash function to handle strings, increasing the utility of the filter in various applications.

## Final words

This is for nerd fun. :P
