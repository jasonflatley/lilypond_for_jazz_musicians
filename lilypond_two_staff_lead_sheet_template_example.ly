



tune_title = "Lilypond Two Staff Lead Sheet Template Example"
tune_subtitle = "(Subtitle goes here)"
tune_tempo = "Straight Eights"


\include "lilypond_include_file_lead_sheet.ily"


% Set to ##t if your score is less than one page:
\paper {
ragged-last-bottom = ##f
ragged-bottom = ##f
page-count = 2
}


theChords = \chordmode { \transpose c c { 
\set chordNameExceptions = #chExceptions
\override ParenthesesItem.font-size = #2

% Head
bes1 bes:6 bes:maj7 s
bes:m bes:m6 bes:m7+ s

bes:7 bes:m7 bes:dim bes:m7.5-
bes:sus4 s bes:maj9 s

a2 a:6 \LPC a:maj7 \NPC s \NPC a:m \RPC a:m6 \NPC a:m7+ s
a:7 a:m7 a:dim a:m7.5- a:sus4 s a:maj9 s

bes2 bes:6 bes:maj7 s bes:m bes:m6 bes:m7+ s
bes:7 bes:m7 bes:dim bes:m7.5- bes:sus4 s bes:maj9 s

% Blowing changes
bes1 bes:6 bes:maj7 s
bes:m bes:m6 bes:m7+ s

bes:7 bes:m7 bes:dim bes:m7.5-
bes:sus4 s bes:maj9 s

a2 a:6 a:maj7 s a:m a:m6 a:m7+ s
a:7 a:m7 a:dim a:m7.5- a:sus4 s a:maj9 s

bes2 bes:6 bes:maj7 s bes:m bes:m6 bes:m7+ s
bes:7 bes:m7 bes:dim bes:m7.5- bes:sus4 s bes:maj9 s

}}



theTopNotes = \transpose c c { \relative c' { 
\set Staff.midiInstrument = "acoustic grand"
\numericTimeSignature
\set Staff.printKeyCancellation = ##f
\override ParenthesesItem.font-size = #5
\override ParenthesesItem.padding = #1
\once \override Score.MetronomeMark #'extra-offset = #'(0.0 . 2.0)
\override Glissando #'style = #' trill

\key bes \major
\mark \default
bes2 c 
d ees 
f g 
a bes \break

c bes
a g
f ees
d c \bar "|||" \break

bes4 c d ees
f g a bes
c bes a g 
f ees d c \break

bes4 c d ees
f g a bes
c bes a g 
f d c bes \bar "|||" \break \noPageBreak


\mark \default
\tuplet 3/2 {a4 b cis} \tuplet 3/2 {d e fis}

\startParenthesis \tuplet 3/2 {< \parenthesize gis> a b} \tuplet 3/2 {cis d e} 
\tuplet 3/2 {fis e d} \tuplet 3/2 {cis b \endParenthesis \parenthesize a}
\tuplet 3/2 {gis fis e} \tuplet 3/2 {d cis b} \break

\tuplet 3/2 {a4 b cis} \tuplet 3/2 {d e fis}
\tuplet 3/2 {gis a b} \tuplet 3/2 {cis d e}
\tuplet 3/2 {fis e d} \tuplet 3/2 {cis b a}
\improvSlashesOn b4 b b b \improvSlashesOff  \bar "|||" \pageBreak


bes8 c d ees f g a bes
c bes a g f ees d c
bes8 c d ees f g a bes
c bes a g f ees d c \break

bes8 c d ees f g a bes
c bes a g f ees d c
bes8 c d ees f g a bes
c bes a g f ees d c \bar "||-|:" \break



% blowing changes
\improvSlashesOn

\mark \default
b4 b b b
b b b b
b b b b
b b b b \break

b4 b b b
b b b b
b b b b
b b b b \bar "|||" \break

b4 b b b
b b b b
b b b b
b b b b \break

b4 b b b
b b b b
b b b b
b b b b \bar "|||" \break

\mark \default
b4 b b b
b b b b
b b b b
b b b b \break

b4 b b b
b b b b
b b b b
b b b b \bar "|||" \break

b4 b b b
b b b b
b b b b
b b b b \break

b4 b b b
b b b b
b b b b
b b b b \bar ":|." \break


\improvSlashesOff


}}

theBottomNotes = \transpose c c { \relative c { 
\set Staff.midiInstrument = "acoustic grand"
\numericTimeSignature
\set Staff.printKeyCancellation = ##f
\override ParenthesesItem.font-size = #5
\override ParenthesesItem.padding = #1
\clef bass

\key bes \major

bes1 bes bes bes
bes bes bes bes

bes1 bes bes bes
bes bes bes bes


\tuplet 3/2 {a4 b cis} \tuplet 3/2 {d e fis}

\startParenthesis \tuplet 3/2 {< \parenthesize gis> a b} \tuplet 3/2 {cis d e} 
\tuplet 3/2 {fis e d} \tuplet 3/2 {cis b \endParenthesis \parenthesize a}
\tuplet 3/2 {gis fis e} \tuplet 3/2 {d cis b} 
\tuplet 3/2 {a4 b cis} \tuplet 3/2 {d e fis}
\tuplet 3/2 {gis a b} \tuplet 3/2 {cis d e}
\tuplet 3/2 {fis e d} \tuplet 3/2 {cis b a}
\improvSlashesOn b4 b b b \improvSlashesOff 

bes1 bes bes bes
bes bes bes bes


}}



theWords = \lyricmode {
Lyrics lyrics lyrics etc.
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
\new GrandStaff <<

\new Staff \theTopNotes
\new Staff \theBottomNotes
%\addlyrics { \theWords }
>>
>>
\layout{
\context { \Voice \consists "Pitch_squash_engraver"}
\context{\Lyrics 
\override LyricText.font-name = #"New Century Schoolbook"
\override LyricText.self-alignment-X = #LEFT
}
}
%\midi {\tempo 4 = 200}
}







