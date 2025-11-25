# Intro

This repository contains documentation and binaries for the interpreter of a custom language im working on.
It is written in Rust, uses a trace-sweep garbage collector, and it is pretty much a work in progress. Expect bugs, crashes or incorrect behavior for many of its features.

# Usage

To execute a script, just write the path to the file as the only parameter or, alternatively, `-s` followed by a string of inline code.

- `slrs.exe <path>`

- `slrs.exe -s <code>`

The 'inspector' executable launches a tui application that enables viewing the virtual machine step by step, but console input and error handling don't work yet.
