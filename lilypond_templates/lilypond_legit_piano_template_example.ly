



tune_title = "Lilypond Legit Piano Template Example"
tune_subtitle = "(Subtitle goes here)"
tune_tempo = "Moderato"


\include "../lilypond_include_files/lilypond_include_file_legit.ily"


% Set to ##t if your score is less than one page:
\paper {
ragged-last-bottom = ##f
ragged-bottom = ##f
page-count = 1
}


theChords = \chordmode { \transpose c c { 
\set chordNameExceptions = #chExceptions
\override ParenthesesItem.font-size = #2

% Include chord names if necessary

}}



theTopNotes = \transpose c c { \relative c' { 
\set Staff.midiInstrument = "acoustic grand"
\numericTimeSignature
\set Staff.printKeyCancellation = ##f
\override ParenthesesItem.font-size = #5
\override ParenthesesItem.padding = #1
\once \override Score.MetronomeMark #'extra-offset = #'(0.0 . 2.0)
\override Glissando #'style = #' trill

<c e>4 <c e> <c e> <c e>
<c e> <c e> <c e> <c e>
<c e> <c e> <c e> <c e>
<c e> <c e> <c e> <c e>

<c e>4 <c e> <c e> <c e>
<c e> <c e> <c e> <c e>
<c e> <c e> <c e> <c e>
<c e> <c e> <c e> <c e>

<c e>4 <c e> <c e> <c e>
<c e> <c e> <c e> <c e>
<c e> <c e> <c e> <c e>
<c e> <c e> <c e> <c e>

<c e>4 <c e> <c e> <c e>
<c e> <c e> <c e> <c e>
<c e> <c e> <c e> <c e>
<c e> <c e> <c e> <c e> \bar "|."



}}

theBottomNotes = \transpose c c { \relative c { 
\set Staff.midiInstrument = "acoustic grand"
\numericTimeSignature
\set Staff.printKeyCancellation = ##f
\override ParenthesesItem.font-size = #5
\override ParenthesesItem.padding = #1
\override Glissando #'style = #' trill
\clef bass

c1 c c c
c c c c
c c c c
c c c c



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
\new PianoStaff <<

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












