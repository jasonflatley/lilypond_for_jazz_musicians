





\include "lilypond_include_file_songbook.ily"


% Assemble the header
\header {
title = "Lilypond Songbook Song Template"
subtitle = "(Subtitle goes here)"
composer = "Set to a Traditional English Folk Song"
arranger = "Lyrics from a Poem by Robert Burns (1788)"
tagline = ##f
}


% Set to ##t if your score is less than one page:
\paper {
ragged-last-bottom = ##f
ragged-bottom = ##f


% need to adjust extra lyrics spacing sometimes
last-bottom-spacing =
    #'((basic-distance . 42)
       (minimum-distance . 12)
       (padding . 22)
       (stretchability . 12))


}


theChords = \chordmode { \transpose c c { 
\set chordNameExceptions = #chExceptions
\override ParenthesesItem.font-size = #2
c4:7

f1 g:m7/f d2:m f:7/c bes2. b4:dim
f2 d:m e2:m7.5- a:7 d2:m g4:m7/c c:7
bes2:/f f4 c:7

f1 g:m7/f d2:m f:7/c bes2. b4:dim
f2 d:m g2:m c4:7 a:7/cis d2:m g4:m7/c c:7
f2 c:7
}}



theNotes = \transpose c c { \relative c' { 
\set Staff.midiInstrument = "acoustic grand"
\numericTimeSignature
\set Staff.printKeyCancellation = ##f
\override ParenthesesItem.font-size = #5
\override ParenthesesItem.padding = #1
\once \override Score.MetronomeMark #'extra-offset = #'(0.0 . 2.0)
\override Glissando #'style = #' trill

\tempo "Ballad" 4=80

\partial 4 c4 \bar ".|:"

f4. e8 f4 a
g4. f8 g4 a8 g
f4. f8 a4 c
d2. d4 \break
c4. a8 a4 f
g4. f8 g4 a8 g
f4. d8 d4 c 
f2. d'4 \break
c4. a8 a4 f
g4. f8 g4 d'
c4. a8 a4 c
d2. d4 \break
c4. a8 a4 f
g4. f8 g4 a8 g 
f4. d8 d4 c 
f2. c4 \bar ":|."

}}






theWords = \lyricmode {


<<
{
Should auld ac- quain- tance be for- got
and __ _ ne- ver brought to mind,
should auld ac- quain- tance be for- got
and __ _ days of auld lang syne.

For auld __ _ lang __ _ syne, my dear,
for auld __ _ lang __ _ syne,
we'll take a cup of kind- ness yet,
for __ _ auld __ _ lang __ _ syne.

And
 
}

\new Lyrics { 
\set associatedVoice = "theNotes"
_ 
here's a hand my trus- ty friend,
and __ _ here's a hand o’ thine.
We'll take a cup of kind- ness yet,
for __ _ auld __ _ lang __ _ syne.


}

\new Lyrics {
\set associatedVoice = "theNotes"
_ 
sure- ly you’ll buy your pint cup,
and __ _  sure- ly I’ll buy mine.
We'll take a cup o’ kind- ness yet,
for __ _ auld __ _ lang __ _ syne.


}


\new Lyrics {
\set associatedVoice = "theNotes"
_ 
two have pad- dled in the stream,
from __ _ mor- ning sun till dine.
But seas be- tween us broad have roared
since __ _ auld __ _ lang __ _ syne.

}

>>

}







%{ 
If you want to make a midi file to listen to and check your notes, uncomment the \midi line. Then
comment out the \new ChordNames line, because if you leave it in, Lilypond will generate ugly midi
chords
%}
\score {
<<
\set Score.markFormatter = #format-mark-box-alphabet
\new ChordNames \theChords
\new Staff \with {\consists "Pitch_squash_engraver"} \theNotes
\addlyrics { \theWords }

>>
\layout{
\context {\Score \remove "Bar_number_engraver"}
\context{\Lyrics 
\override LyricText.font-name = #"New Century Schoolbook"
\override LyricText.self-alignment-X = #LEFT
}}
%\midi {\tempo 4 = 200}

}





\markup {
\override #'(font-name . "New Century Schoolbook")
\large
  
\fill-line { 
\hspace #20.6 % moves the column off the left margin;
% can be removed if space on the page is tight
\column {\line { \bold "2."  \column {
"This is verse two."
"It has two lines."}}
\combine \null \vspace #1 % adds vertical spacing between verses
\line { \bold "3."
\column {
"This is verse three."
"It has two lines."
}
}
}
\hspace #0.0 % adds horizontal spacing between columns;
\column {
\line { \bold "4."
\column {
"This is verse four."
"It has two lines."
}
}
\combine \null \vspace #1 % adds vertical spacing between verses
\line { \bold "5."
\column {
"This is verse five."
"It has two lines."
}
}
}
\hspace #0.0 % gives some extra space on the right margin;
% can be removed if page space is tight
}}


