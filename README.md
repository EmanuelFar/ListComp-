# List Comp Project

Welcome to the **List Comp Project**! This project is designed to parse and process list comprehensions using a custom parser built with Yacc and Flex. Below you'll find all the necessary information to get started, including setup instructions, usage guidelines, and details about the configuration file.

## Table of Contents

- [Introduction](#introduction)
- [Background](#background)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)

## Introduction

The **List Comp Project** is a parser and compiler for handling list comprehensions. It leverages tools like Yacc and Flex to define the grammar and lexical analysis of list comprehensions, compiling them into executable code using GCC.

## Background
How is it Implemented?

I Use 2 Data structures, First one is the infamous Expression Tree in order to be able to store the expression of the list comprehension (e.g 'x * 2' for x ...) and evaluate the tree with a certain value.

Second is...you guessed right! the list of the l-i-s-t comprehension.

Of course Yacc helps a lot when it comes to building the tree. 

## Features

- **Custom Parser**: Built with Yacc and Flex to parse list comprehensions.
- **Executable Generation**: Compiles the parser and supporting C files into an executable.
- **Flexible Configuration**: Easily configurable build process via a shell script.
- **Extensible Architecture**: Designed to allow easy addition of new features and grammar rules.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

- **GNU Yacc**: Parser generator.
- **Flex**: Fast lexical analyzer generator.
- **GCC**: GNU Compiler Collection.
- **Make**: Build automation tool (optional but recommended).

You can install these tools using your system's package manager. For example, on Debian-based systems:

```bash
sudo apt-get update
sudo apt-get install build-essential flex bison

```
## Installation
Clone the Repository

```bash
git clone https://github.com/yourusername/ListComp-.git
cd ListComp-

```
Set Executable Permissions for Configuration Script
Ensure the config.sh script has execute permissions:

```bash
chmod +x config.sh
```
## Configuration
The project includes a configuration script named config.sh that automates the build process. This script performs the following steps:

Generate Parser Files: Uses Yacc to generate the parser header and source files.

Generate Lexer Files: Uses Flex to generate the lexer source file.

Compile the Project: Compiles all necessary C files into an executable using GCC.

Run the Parser: Executes the generated parser.

How to Use config.sh?
Execute the script with your base filename (without extension) as an argument:

```bash
./config.sh list_comp
```
This will:

Generate y.tab.c and y.tab.h from list_comp.yacc.

Generate lex.yy.c from list_comp.lex.

Compile all C files into an executable named parser.

Run the parser executable.


## Usage
After successfully building the project using config.sh, you can use type List comprehension expressions.

Example
```
[10+1, 30/2, 30%4, 2*3, 6-8];
2+3*4;
(2+3)*4;
10 % 3 % 2;
100/5/2;
# test list comprehension
x for x in [1,2,3,4];
x+1 for x in [];
x*x for x in [0,3,10,10+10];
17 for what in [1,2];
what for what in [10,20];
```
