%%%% Lilypond jazz leadsheet stylesheet
%%%% Inspired by http://leighverlag.blogspot.com/2015/12/mimicking-real-book-look.html



% Lilypond version information
\version "2.18.2"



%Customize some bar lines to print at end of line and at beginning of next line
\defineBarLine "|||" #'("||" "||" "||")
\defineBarLine "||-|:" #'("||" ".|:" ".|:")
\defineBarLine ":|-||" #'(":|." "||" "||")
\defineBarLine ":|-|:" #'(":|." ".|:" ".|:")



% These variables shouldn't change between lead sheets
composer_name = "[Your Name Here]"
copyright_year = #(strftime "%Y" (localtime (current-time)))
website = "www.your-website.com"



% Set global staff size
#(set-global-staff-size 18)



% Specify how we want to typset our chords. We only use chords out of my preferred system.
chExceptionMusic = {
<c e g a>1-\markup {\raise #0.7 \magnify #0.95 {6}}						%%%% c:6
<c e g b>1-\markup {\raise #0.7 \tiny{ \hspace #0.2 \triangle ##f}}		%%%% c:maj7
<c ees g a>1-\markup {m \raise #0.7 \magnify #0.95 {6}}					%%%% c:m6
<c ees g b>1-\markup {m \raise #0.7 \tiny{ \triangle ##f}}				%%%% c:m7+
<c e g bes>1-\markup {\raise #0.7 \magnify #0.95 {7}}					%%%% c:7
<c ees g bes>1-\markup { m \raise #0.7  \magnify #0.95 {7}}				%%%% c:m7
<c ees ges>1-\markup {\hspace #0.05 \raise #0.7 \large{o}}				%%%% c:dim
<c ees ges bes>1-\markup { \hspace #0.05 \raise #0.7 \large{ø}}			%%%% c:m7.5-
<c f g>1-\markup {sus}													%%%% c:sus4

% In this chord system, we don't need major 9 chords, so we
% override the major 9 chord slot to represent major 7 augmented chord,
% which we represent this with a triangle with a slash through it
<c e g b d'>1- \markup {\hspace #0.4 \combine \raise #0.5 \tiny \bold \triangle ##f \translate #(cons -0.2 0.3) \rotate #60 —} %%%% c:maj9
}

% Tell lilypond to use our custom chord symbols
chExceptions = #(append (sequential-music-to-chord-exceptions chExceptionMusic #t) ignatzekExceptions)



% Change thickness of selected elements
\layout {
\override Score.Hairpin.thickness = #2
\override Score.Stem.thickness = #2
\override Score.TupletBracket.thickness = #2
\override Score.VoltaBracket.thickness = #2
%\override Score.SystemStartBar.thickness = #4
\override StaffGroup.SystemStartBracket.padding = #0.25
\override ChoirStaff.SystemStartBracket.padding = #0.25
%\override Staff.Tie.thickness = #3
\override Staff.Tie.line-thickness = #2
\override Staff.Slur.thickness = #3
\override Staff.PhrasingSlur.thickness = #3
%\override Staff.BarLine.hair-thickness = #4
\override Staff.BarLine.thick-thickness = #8
\override Staff.MultiMeasureRest.hair-thickness = #3
\override Staff.MultiMeasureRestNumber.font-size = #2
\override LyricHyphen.thickness = #3
\override LyricExtender.thickness = #3
\override PianoPedalBracket.thickness = #2
}



% Customize paper settings
\paper {
#(set-paper-size "letter")
indent = 0\mm

% Implement lead sheet vertical spacing conventions
between-system-space = 2.5\cm
between-system-padding = #0
markup-system-spacing = #'((basic-distance . 15)(minimum-distance . 15)(padding . 1)) % between header and first system
last-bottom-spacing = #'((basic-distance . 7)(minimum-distance . 7)(padding . 1)) % between last system and copyright

% Potententially change fonts for everything
%#(define fonts (make-pango-font-tree "Merriweather" "Helvetica Neue" "Consolas" (/ staff-height pt 20)))

% Custom headers and footers for pages 2 and on
print-page-number = ##t
print-first-page-number = ##t
evenHeaderMarkup = \markup \null 
oddHeaderMarkup = \markup \null 

% Make nice footers
% See http://lilypond.org/doc/v2.12/Documentation/user/lilypond/Align
oddFooterMarkup = \markup{\fill-line{
\line{\teeny{\tune_title - 
\on-the-fly \print-page-number-check-first
\fromproperty #'page:page-number-string
}}
\line{\teeny{ \concat{\char ##x00A9 \copyright_year}}}
\line{\teeny{\underline \typewriter \website}}
}}
evenFooterMarkup = \oddFooterMarkup

}



% Implement lead sheet convention of clef and key signature only on first line,
% and bar lines at the beginning of each system beyond the first
\layout {
\override Score.Clef #'break-visibility = #'#(#f #f #f) % make only the first clef visible
\override Score.KeySignature #'break-visibility = #'#(#f #f #f) % make only the first time signature visible
\override Score.SystemStartBar #'collapse-height = #1 % allow single-staff system bars
\context {\Score \remove "Bar_number_engraver"}

% This complicated hack turns off the bar line at the beginning of the first system
% Courtesy of Thomas Morley
\override Score.SystemStartBar #'after-line-breaking =
#(lambda (grob)(let* ((orig (ly:grob-original grob))(siblings (if (ly:grob? orig)
(ly:spanner-broken-into orig) '())))
(ly:grob-set-property! grob 'collapse-height
(if (and (pair? siblings) (equal? grob (car siblings)))10 1))))
}



% Assemble the header
\header {
title = \tune_title
subtitle = \tune_subtitle
composer = \composer_name
tagline = ##f
poet = \markup{\bold \tune_tempo}
}



% Macros for improvisation slashes
% see http://lilypond.1069038.n5.nabble.com/slashes-and-percent-td183258.html
improvSlashesOn = {\improvisationOn \override NoteHead.style = #'slash \hide Stem }
improvSlashesOff = {\improvisationOff \revert NoteHead.style \undo \hide Stem }
crOn = \override NoteHead.style = #'cross
crOff = \revert NoteHead.style


% Nicely position the rehearsal marks in lead sheet style
% http://lilypond.1069038.n5.nabble.com/Tempo-marking-pushes-rehearsal-mark-far-above-the-staff-td143637.html
\layout { \context { \Score 
\override RehearsalMark #'extra-spacing-width = #'(-5.5 . 5.5) 
\override RehearsalMark #'X-offset = #-2 
\override RehearsalMark #'Y-offset = #6
%\override RehearsalMark #'outside-staff-padding = #20.8 
}} 



% Ability to nicely parenthesize notes
% From http://lsr.di.unimi.it/LSR/Snippet?id=902
startParenthesis = {
  \once \override ParenthesesItem.stencils = #(lambda (grob)
        (let ((par-list (parentheses-item::calc-parenthesis-stencils grob)))
          (list (car par-list) point-stencil )))
}

endParenthesis = {
  \once \override ParenthesesItem.stencils = #(lambda (grob)
        (let ((par-list (parentheses-item::calc-parenthesis-stencils grob)))
          (list point-stencil (cadr par-list))))
}



% Ability to nicely parenthesize chord symbols
% From http://lilypond.1069038.n5.nabble.com/parenthesize-chord-td133330.html
#(define (left-parenthesis-ignatzek-chord-names in-pitches bass inversion context) 
(markup #:line ("( " (ignatzek-chord-names in-pitches bass inversion context)))) 

#(define (right-parenthesis-ignatzek-chord-names in-pitches bass inversion context) 
(markup #:line ((ignatzek-chord-names in-pitches bass inversion context) " )"))) 

LPC = { \set chordNameFunction = #left-parenthesis-ignatzek-chord-names } 
RPC = { \set chordNameFunction = #right-parenthesis-ignatzek-chord-names } 
NPC = { \unset chordNameFunction } 




% Extend laissez vibrer ties
extendLV =
#(define-music-function (parser location further) (number?)
#{
  \once \override LaissezVibrerTie.X-extent = #'(0 . 0)
  \once \override LaissezVibrerTie.details.note-head-gap = #(/ further -2)
  \once \override LaissezVibrerTie.extra-offset = #(cons (/ further 2) 0)
#})




% Merge rests in polyphonic contexts
#(define (rest-score r)
  (let ((score 0)
	(yoff (ly:grob-property-data r 'Y-offset))
	(sp (ly:grob-property-data r 'staff-position)))
    (if (number? yoff)
	(set! score (+ score 2))
	(if (eq? yoff 'calculation-in-progress)
	    (set! score (- score 3))))
    (and (number? sp)
	 (<= 0 2 sp)
	 (set! score (+ score 2))
	 (set! score (- score (abs (- 1 sp)))))
    score))

#(define (merge-rests-on-positioning grob)
  (let* ((can-merge #f)
	 (elts (ly:grob-object grob 'elements))
	 (num-elts (and (ly:grob-array? elts)
			(ly:grob-array-length elts)))
	 (two-voice? (= num-elts 2)))
    (if two-voice?
	(let* ((v1-grob (ly:grob-array-ref elts 0))
	       (v2-grob (ly:grob-array-ref elts 1))
	       (v1-rest (ly:grob-object v1-grob 'rest))
	       (v2-rest (ly:grob-object v2-grob 'rest)))
	  (and
	   (ly:grob? v1-rest)
	   (ly:grob? v2-rest)
	   (let* ((v1-duration-log (ly:grob-property v1-rest 'duration-log))
		  (v2-duration-log (ly:grob-property v2-rest 'duration-log))
		  (v1-dot (ly:grob-object v1-rest 'dot))
		  (v2-dot (ly:grob-object v2-rest 'dot))
		  (v1-dot-count (and (ly:grob? v1-dot)
				     (ly:grob-property v1-dot 'dot-count -1)))
		  (v2-dot-count (and (ly:grob? v2-dot)
				     (ly:grob-property v2-dot 'dot-count -1))))
	     (set! can-merge
		   (and
		    (number? v1-duration-log)
		    (number? v2-duration-log)
		    (= v1-duration-log v2-duration-log)
		    (eq? v1-dot-count v2-dot-count)))
	     (if can-merge
		 ;; keep the rest that looks best:
		 (let* ((keep-v1? (>= (rest-score v1-rest)
				      (rest-score v2-rest)))
			(rest-to-keep (if keep-v1? v1-rest v2-rest))
			(dot-to-kill (if keep-v1? v2-dot v1-dot)))
		   ;; uncomment if you're curious of which rest was chosen:
		   ;;(ly:grob-set-property! v1-rest 'color green)
		   ;;(ly:grob-set-property! v2-rest 'color blue)
		   (ly:grob-suicide! (if keep-v1? v2-rest v1-rest))
		   (if (ly:grob? dot-to-kill)
		       (ly:grob-suicide! dot-to-kill))
		   (ly:grob-set-property! rest-to-keep 'direction 0)
		   (ly:rest::y-offset-callback rest-to-keep)))))))
    (if can-merge
	#t
	(ly:rest-collision::calc-positioning-done grob))))

#(define merge-multi-measure-rests-on-Y-offset
  ;; Call this to get the 'Y-offset of a MultiMeasureRest.
  ;; It keeps track of other MultiMeasureRests in the same NonMusicalPaperColumn
  ;; and StaffSymbol. If two are found, delete one and return 0 for Y-offset of
  ;; the other one.
  (let ((table (make-weak-key-hash-table)))
    (lambda (grob)
      (let* ((ssymb (ly:grob-object grob 'staff-symbol))
	     (nmcol (ly:grob-parent grob X))
	     (ssymb-hash (or (hash-ref table ssymb)
			     (hash-set! table ssymb (make-hash-table))))
	     (othergrob (hash-ref ssymb-hash nmcol)))
	    (if (ly:grob? othergrob)
		(begin
		  ;; Found the other grob in this staff/column,
		  ;; delete it and move ours.
		  (ly:grob-suicide! othergrob)
		  (hash-remove! ssymb-hash nmcol)
		  0)
		(begin
		  ;; Just save this grob and return the default value.
		  (hash-set! ssymb-hash nmcol grob)
		  (ly:staff-symbol-referencer::callback grob)))))))


mergeRestsOn = {
  \override Staff.RestCollision #'positioning-done = #merge-rests-on-positioning
  \override Staff.MultiMeasureRest #'Y-offset = #merge-multi-measure-rests-on-Y-offset
}

mergeRestsOff = {
  \revert Staff.RestCollision #'positioning-done
  \revert Staff.MultiMeasureRest #'Y-offset
}

