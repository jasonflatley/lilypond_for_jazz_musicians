





\include "../lilypond_include_files/lilypond_include_file_songbook.ily"


% Assemble the header
\header {
title = ""
subtitle = ""
composer = ""
arranger = ""
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



}}






theWords = \lyricmode {


<<
{
% first line
 
}

\new Lyrics { 
\set associatedVoice = "theNotes"
% second line


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




