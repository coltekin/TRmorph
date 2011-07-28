%
% Definitions of particles, clitics and similar stuff that do not fit
% anywhere else
%

%%%%%%%%%%% question suffix (or clitic)
%
% question suffix mI is written seperately, a proper treatment would
% require considering it attached to the preceeding word (mostly of
% the time verb). here we just treat as a clitic. The details of the
% implementation is in trmoprh.fst

% $mi$ = (<q>:{mi} | <q>:{mı} | <q>:{mü} | <q>:{mu}) <MB>
$mi$ = (mi| mı | mü | mu) <q><MB>

%%%%%%%%%%% free morpheme (copua?) i
%

$I$ = i <v><MB>


%%%%%%%% existential expression var/yok and degil `not' behaves similarly
%
% The suffixes these take are listed in trmoprh.fst
%

$vyd$ = ((var <exist>) | (yok <nexist>) | (değil <not>)) <RB>

%%%%%%%% punctuation marks
%
%

$punct$ = ([#Punct#] | \.\.\.) <pnct>

% TODO: pairs of -(y)a ... -(y)a  (e.g. baka baka)
%                -DI ... -(y)AlI  (e.g. duydum duyalı)
%                -A/Ir ... -mAz   (e.g. görür görmez)

