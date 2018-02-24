#!/usr/bin/env python3

class CoNLLULArc:
    __slots__ = ("from_state", "to_state", "form", "lemma", "upos", "xpos",
            "feat", "misc", "anchors")
    def __init__(self, from_state=0, to_state=1, form="_", lemma="_",
                 upos="_", xpos="_", feat="_", misc="_", anchors="_"):
        self.from_state = from_state
        self.to_state = to_state
        self.form = form
        self.lemma = lemma
        self.upos = upos
        self.xpos = xpos
        self.feat = feat
        self.misc = misc
        self.anchors = anchors
    def __str__(self):
        fmt = "{}" + 8 * "\t{}" + "\n"
        return fmt.format( self.from_state, self.to_state, self.form,
                           self.lemma, self.upos, self.xpos,
                               self.feat, self.misc, self.anchors)

class CoNLLUL:
    __slots__ = ("begin", "end", "form", "arcs", "misc")

    def __init__(self, form, begin=0, end=1):
        self.form = form
        self.begin = begin
        self.end = end
        self.arcs = []
        self.misc = '_'

    def __len__(self):
        return len(self.arcs)

    def __str__(self):
        ul_str = ""
        if self.end - self.begin > 1:
            ul_str = "{}-{}\t{}\t{}\n".format(self.begin, self.end,
                self.form, self.misc)
        for arc in self.arcs:
            ul_str += str(arc)
        return(ul_str)

    def add_arc(self, from_state=0, to_state=1, form="_", lemma="_", upos="_",
                      xpos="_", feat="_", misc="_", anchors="_"):

        self.arcs.append(CoNLLULArc(from_state=from_state + self.begin,
                                    to_state=to_state + self.begin,
                                    form=form, lemma=lemma, upos=upos,
                                    xpos=xpos, feat=feat,
                                    misc=misc, anchors=anchors))
        if (self.begin + to_state) > self.end:
            self.end = self.begin + to_state

if __name__ == "__main__":
    cul = CoNLLUL("a", begin=4)
    cul.add_arc(from_state=0, to_state=1, form="a", lemma="b", upos="NOUN")
    cul.add_arc(from_state=0, to_state=2, form="a", lemma="b", upos="NOUN")
    print(cul, end="")
