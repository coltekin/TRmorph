TRmorph (http://www.let.rug.nl/coltekin/trmorph/)

This is the README file for TRmorph hfst/lexc branch (updated 2013-02)

TRmorph is a open source/free morphological analyzer for Turkish. The
current version is a complete rewrite of the (earlier) SFST[2] version
of TRmorph using xfst/lexc. Although it should do at least as good as
the SFST version, this version is not tested as much and documentation
is also in progress. The SFST version is still availabel through the
web page above, but it is not developed further.

TRmorph is being developed with foma[1]. It should also be trivial to
compile it using HFST tools as well (since HFST uses foma as back
end). Compiling with Xerox tools should also be possible (if you have
to) with minor modifications regarding limited reduplication
implemented using foma's _eq().

# Getting started

You can get the latest version of TRmorph from GitHub here:
https://github.com/coltekin/TRmorph. The best is to clone the
repository using git, and pull often since this version is
changed relatively frequently, but GitHub also allows you to download
the as a `.zip` file.

The compilation requires foma and a C preprocessor (gcc preprocessor
is used by default), and make, and a few more UNIX tools. Assuming you
have foma[1] installed, type `make` to compile the analyzer. If all
goes well, you should have a binary automaton in foma format called
`trmorph.fst`. After that you can use interactive `foma`, or `flookup`
for batch processing (both are part of foma). Here are some examples:

    $ foma
    ...
    foma[0]: regex @"trmorph.fst";
    2.3 MB. 53564 states, 149484 arcs, Cyclic.
    foma[1]: up okudum
    oku<v><t_past><1s>
    foma[1]: down oku<v><t_past><2s>
    okudun
    foma[1]: exit
    $ echo "okudum" |flookup trmorph.fst 
    okudu   oku<v><t_past><1s>

There are also separate automata you can compile for _segmentation_,
_stemming_ (or _lemmatization_) and _hyphenation_ that you can compile
and use. 

# References

[1] https://code.google.com/p/foma/
[2] http://www.ims.uni-stuttgart.de/projekte/gramotron/SOFTWARE/SFST.html
