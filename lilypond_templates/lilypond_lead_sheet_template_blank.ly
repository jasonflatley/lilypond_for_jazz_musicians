


tune_title = ""
tune_subtitle = ""
tune_tempo = ""


\include "../lilypond_include_files/lilypond_include_file_lead_sheet.ily"


% Set to ##t if your score is less than one page:
\paper {
ragged-last-bottom = ##f
ragged-bottom = ##f
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
\new Voice \with {\consists "Pitch_squash_engraver"} \theNotes
%\addlyrics { \theWords }

>>
\layout{
\context{\Lyrics 
\override LyricText.font-name = #"New Century Schoolbook"
\override LyricText.self-alignment-X = #LEFT
}
}

%\midi {\tempo 4 = 200}
}



