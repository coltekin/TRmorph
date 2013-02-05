TRmorph (http://www.let.rug.nl/coltekin/trmorph/)

This is the README file for TRmorph hfst/lexc branch (updated 2013-02)

TRmorph is a open source/free morphological analyzer for Turkish. The
current version is a complete rewrite of the (earlier) SFST version of
TRmorph using xfst/lexc. Although it should do at least as good as the
SFST version, this version is not tested as much and documentation is
also in progress. 

TRmorph is being developed with foma[1]. It should be trivial to
compile it using HFST tools as well (since HFST uses foma as back
end).


# Getting started

You can get the latest version of TRmorph from GitHub here:
https://github.com/coltekin/TRmorph. The best is to clone the
repository using git, and pull frequently since this version is
changed relatively frequently, but GitHub also allows you to download
the as a `.zip` file.

Assuming you have foma[1] foma installed, type `make` in the to
compile the analyzer. If all goes well, you should have a binary
automaton in foma format called `trmorph.fst`. After that you can use
interactive `foma`, or `flookup` for batch processing (both are part
of foma). Here are some examples:

    $ foma
    ...
    foma[1]: up okudum
    oku<v><t_past><1s>
    foma[1]: down oku<v><t_past><2s>
    okudun
    foma[1]: exit
    $ echo "okudum" |flookup trmorph.fst 
    okudu   oku<v><t_past><1s>

There are also separate automaton you can compile for _segmentation_,
_stemming_ (or _lemmatization_) and _hyphenation_ that you can compile
and use.

# References

[1] https://code.google.com/p/foma/
