TRmorph (http://www.let.rug.nl/coltekin/trmorph/)

This is the README file for the new version of TRmorph (updated 2013-07)

TRmorph is a open source/free morphological analyzer for Turkish. The
current version is a complete rewrite of the (earlier) SFST[2] version
of TRmorph using xfst/lexc. This version is in active development,
which may cause soem problem and incompatibilities between updates.
However, the status is a lot better than the older SFST version, and
you are recommended to use the new version.  The SFST version is still
available through the web page above, but it is not developed any
further.

TRmorph is being developed with foma[1]. It should also be trivial to
compile it using HFST tools as well (since HFST uses foma as back
end). Compiling with Xerox tools should also be possible (if you have
to) with minor modifications regarding limited reduplication
implemented using foma's _eq().

What is new in this version:
    
    - This is a complete rewrite using more-familiar Xerox languages 
      lexc/xfst.
    - A completely new lexicon, semi-automatically constructed using
      web corpora and online dictionaries. (more work is needed,
      though)
    - A revised tag set.
    - A few more utilities: stemmer, unknown word guesser,
      segmenter, and a hyphenation tool.
    - A manual, in progress, but it is still usable.
    - New license: this version of TRmorph is distributed under 
      GNU Lesser General Public License [1] (also see the file
      LICENSE).

If you use this analyzer in your research, and want to cite it, please
(still) cite the following paper:

Çağrı Çöltekin (2010). A Freely Available Morphological Analyzer for
Turkish In Proceedings of the 7th International Conference on Language
Resources and Evaluation (LREC2010), Valletta, Malta, May 2010. (pdf). 

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
    oku<v><past><1s>
    foma[1]: down oku<v><past><2s>
    okudun
    foma[1]: exit
    $ echo "okudum" |flookup trmorph.fst 
    okudu   oku<v><past><1s>

There are also separate automata you can compile for _segmentation_,
_stemming_ (or _lemmatization_) and _hyphenation_ that you can compile
and use. 

See doc/trmorph-manual.pdf for more information.

# References

[1] https://code.google.com/p/foma/
[2] http://www.ims.uni-stuttgart.de/projekte/gramotron/SOFTWARE/SFST.html
[3] http://www.gnu.org/licenses/lgpl.html
