This branch holds the source code for  TRmorph version 2.0,
yet another major rewrite of the earlier versions of
[TRmorph](http://coltekin.net/cagri/trmorph/),
the open source finite-state morphological analyzer for Turkish.

The code in this branch is (as of February 2018) yet **experimental**.
Some parts are not yet fully tested,
some features in the earlier versions have not yet been implemented,
and the tagset changes are not documentd. 
The early, more stable version can be found at
<https://github.com/coltekin/TRmorph>.


### What is new in this version?

- The internals are completely re-organized/re-written. This should
  make the code more maintable.
- This version, by default, produces fewer ambiguities. 
- [Universal Dependencies](http://universaldependencies.org/)
  conversion, with CoNLL-UL output (through a Python script).

### What is *not* implemented yet?

- Additional utilities (stemmer, segmenter, g2p conversion, ...)
- Compile time options.
- Disambiguation

## Getting started

The compilation/use of TRmorph requires [foma](https://fomafst.github.io/).
For compilation, you additonaly need make, and a few standard UNIX tools.
Assuming you have all requisites
type `make depend;make` to compile the analyzer.
If all goes well, you should have a binary automaton
in foma format called `trmorph.a`.
After that you can use interactive `foma`,
or `flookup` for batch processing (both are part of foma).
See also the Python interface below.

If you do not need/want to compile from the source,
the (most) [releases](https://github.com/coltekin/TRmorph/releases)
include pre-compiled binary automata files.
You still need `foma`/`flookup` to use these files.

Here are some examples:
```
    $ foma
    ...
    foma[0]: regex @"trmorph.a";
    3.0 MB. 57187 states, 198655 arcs, Cyclic.
    foma[1]: up okudum
    oku⟨V⟩⟨past⟩⟨1s⟩

    $ echo "okudum" |flookup trmorph.a
    okudum  oku⟨V⟩⟨past⟩⟨1s⟩
```

## Python interface

This version comes with a default python (python3 only) interface,
that offers alternative output formats (including a
[Universal Dependencies](http://universaldependencies.org/) version,
and CoNLL-UL lattice format).
The python script uses `flookup` through a pipe,
so, you still need `foma` installed.

### From command line:
```
    $echo "okudum" |tools/trmorph.py 
    okudum  oku⟨V⟩⟨past⟩⟨1s⟩

    echo "okudum" |tools/trmorph.py -f conll-ul
    0-1     okudum
    0       1       okudum  oku     VERB    _ Aspect=Perf|Evidentiality=Fh|Mood=Ind|Number=Sing|Person=1|Tense=Past _     _

	$ echo "altındaki" |tools/trmorph.py
	altındaki       alt⟨N⟩⟨sg⟩⟨p3s⟩⟨loc⟩⟨ki⟩⟨Adj⟩⟨sg⟩⟨p0x⟩⟨nom⟩⟨cpl⟩⟨V⟩⟨3s⟩
	altındaki       alt⟨N⟩⟨sg⟩⟨p2s⟩⟨loc⟩⟨ki⟩⟨Adj⟩⟨sg⟩⟨p0x⟩⟨nom⟩⟨cpl⟩⟨V⟩⟨3s⟩
	altındaki       alt⟨Adj⟩⟨sg⟩⟨p3s⟩⟨loc⟩⟨ki⟩⟨Adj⟩⟨sg⟩⟨p0x⟩⟨nom⟩⟨cpl⟩⟨V⟩⟨3s⟩
	altındaki       alt⟨Adj⟩⟨sg⟩⟨p2s⟩⟨loc⟩⟨ki⟩⟨Adj⟩⟨sg⟩⟨p0x⟩⟨nom⟩⟨cpl⟩⟨V⟩⟨3s⟩
	altındaki       altı⟨Num⟩⟨sg⟩⟨p2s⟩⟨loc⟩⟨ki⟩⟨Adj⟩⟨sg⟩⟨p0x⟩⟨nom⟩⟨cpl⟩⟨V⟩⟨3s⟩
	altındaki       altın⟨N⟩⟨sg⟩⟨p0x⟩⟨loc⟩⟨ki⟩⟨Adj⟩⟨sg⟩⟨p0x⟩⟨nom⟩⟨cpl⟩⟨V⟩⟨3s⟩

	$ echo "altındaki" |tools/trmorph.py -f conll-ul
	0-2     altındaki
	0       1       altında alt     NOUN    _       Case=Loc|Number=Sing|Number[psor]=Sing|Person[psor]=3   _       _
	1       2       ki      ki      ADJ     _       Case=Nom|Number=Sing    _       _
	0       1       altında alt     NOUN    _       Case=Loc|Number=Sing|Number[psor]=Sing|Person[psor]=2   _       _
	0       1       altında alt     ADJ     _       Case=Loc|Number=Sing|Number[psor]=Sing|Person[psor]=3   _       _
	0       1       altında alt     ADJ     _       Case=Loc|Number=Sing|Number[psor]=Sing|Person[psor]=2   _       _
	0       1       altında altı    NUM     _       Case=Loc|Number=Sing|Number[psor]=Sing|Person[psor]=2   _       _
	0       1       altında altın   NOUN    _       Case=Loc|Number=Sing    _       _
```

### The API usage:
```
>>> from trmorph import Trmorph
>>> trm = Trmorph()
>>> trm.analyze("evindeki")
['ev⟨N⟩⟨sg⟩⟨p3s⟩⟨loc⟩⟨ki⟩⟨Adj⟩⟨sg⟩⟨p0x⟩⟨nom⟩⟨cpl⟩⟨V⟩⟨3s⟩', 'ev⟨N⟩⟨sg⟩⟨p2s⟩⟨loc⟩⟨ki⟩⟨Adj⟩⟨sg⟩⟨p0x⟩⟨nom⟩⟨cpl⟩⟨V⟩⟨3s⟩', 'evin⟨N⟩⟨sg⟩⟨p0x⟩⟨loc⟩⟨ki⟩⟨Adj⟩⟨sg⟩⟨p0x⟩⟨nom⟩⟨cpl⟩⟨V⟩⟨3s⟩']
>>> print(trm.to_conll_ul("evindeki"))
0-2     evindeki
0       1       evinde  ev      NOUN    _       Case=Loc|Number=Sing|Number[psor]=Sing|Person[psor]=3   _       _
1       2       ki      ki      ADJ     _       Case=Nom|Number=Sing    _       _
0       1       evinde  ev      NOUN    _       Case=Loc|Number=Sing|Number[psor]=Sing|Person[psor]=2   _       _
0       1       evinde  evin    NOUN    _       Case=Loc|Number=Sing    _       _

```

A more usable and well documented API is on the way.

## Citing TRmorph

As before, if you use this analyzer in your research,
please cite the appropriate paper(s) from the following list:

- Çağrı Çöltekin (2010). [A Freely Available Morphological Analyzer for
  Turkish](http://www.lrec-conf.org/proceedings/lrec2010/summaries/109.html)
  In Proceedings of the 7th International Conference on 
  Language Resources and Evaluation (LREC2010)
- Çağrı Çöltekin (2014) [A Set of Open Source Tools for Turkish Natural 
  Language Processing](http://www.lrec-conf.org/proceedings/lrec2014/summaries/437.html)
  In: Proceedings of the Ninth International Conference on 
  Language Resources and Evaluation (LREC'14)

