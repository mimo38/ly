\version "2.18.2"
\language "italiano"

\header {
  % Supprimer le pied de page par défaut
  tagline = ##f
}

\paper {
  #(set-paper-size "a5")
}

\layout {
  \context {
    \Score
    \remove "Bar_number_engraver"
  }
  \context {
    \Voice
    \consists "Melody_engraver"
    \override Stem #'neutral-direction = #'()
  }
}

global = {
  \key sol \major
  \time 3/4
  \autoBeamOff
}

soprano = \relative do'' {
  \global
  % En avant la musique !
 \partial1 mi,4 si'4. si8 fad sol la4 la8 r8
 mi4 sol4. la8 fad sol mi4 r4
 mi4 si'4. si8 fad sol la4 la8 r8
 mi4 sol4. la8 fad sol mi4 r4
 mi fad4. sol8 mi8 fad sol4 fad8 r8
 sol4 la4. sol8 fad mi mi4(re8) r8
 mi4 fad4. sol8 mi8 fad sol4 fad8 r8
 sol4 mi4. fad8 mi re mi2\fermata
 
}

alto = \relative do' {
  \global
  % En avant la musique !
 mi4 sol4. sol8 fad mi fad4 fad8 r8
 mi4 mi4. mi8 re re mi4 r4
 mi4 sol4. sol8 fad mi fad4 fad8 r8
 mi4 mi4. mi8 re re mi4 r4
 mi4 re4. re8 re re re4 re8 r8
 mi4 mi4. mi8 do8 do si4. r8
 mi4 re4. re8 re re re4 re8 r8
 mi4 do4. do8 si si si2\fermata

}

tenor = \relative do' {
  \global
  % En avant la musique !
mi,4 mi4. mi8 mi mi re4 re8 r8
do4 do4. do8 si si mi4 r4
mi4 mi4. mi8 mi mi re4 re8 r8
do4 do4. do8 si si mi4 r4
mi la4. si8 sol la si4 la8 r8
si4 do4. do8 la8 la fad4. r8
mi4 la4. si8 sol la si4 la8 r8
si4 la4. la8 fad fad sol2\fermata


}

bass = \relative do {
  \global
  % En avant la musique !
 mi4 mi4. mi8 mi mi re4 re8 r8
do4 do4. do8 si si mi4 r4
mi4 mi4. mi8 mi mi re4 re8 r8
do4 do4. do8 si si mi4 r4 

mi4 re4. re8 re re sol4 re8 r8
mi4 la,4. la8 la la sol4. r8
mi'4 re4. re8 re re sol4 re8 r8
mi4 la,4. la8 sol sol mi'2\fermata
}

verse = \lyricmode {
  % Ajouter ici des paroles.
Je mets ma con -- fi -- an -- ce
Vierge en vo -- tre se -- cours.
Ser -- vez_- moi de dé -- fen -- se,
pre -- nez soin de mes jours.
Et quand ma der -- nière heu -- re
vien -- dra fi -- xer mon sort,
ob -- te -- nez que je meu -- re
de la plus sain -- te mort.
}

rehearsalMidi = #
(define-music-function
 (parser location name midiInstrument lyrics) (string? string? ly:music?)
 #{
   \unfoldRepeats <<
     \new Staff = "soprano" \new Voice = "soprano" { \soprano }
     \new Staff = "alto" \new Voice = "alto" { \alto }
     \new Staff = "tenor" \new Voice = "tenor" { \tenor }
     \new Staff = "bass" \new Voice = "bass" { \bass }
     \context Staff = $name {
       \set Score.midiMinimumVolume = #0.5
       \set Score.midiMaximumVolume = #0.5
       \set Score.tempoWholesPerMinute = #(ly:make-moment 100 4)
       \set Staff.midiMinimumVolume = #0.8
       \set Staff.midiMaximumVolume = #1.0
       \set Staff.midiInstrument = $midiInstrument
     }
     \new Lyrics \with {
       alignBelowContext = $name
     } \lyricsto $name $lyrics
   >>
 #})

\score {
  \new ChoirStaff <<
    \new Staff \with {
      midiInstrument = "choir aahs"
      instrumentName = \markup \center-column { "S." "A." }
      shortInstrumentName = \markup \center-column { "S." "A." }
    } <<
      \new Voice = "soprano" { \voiceOne \soprano }
      \new Voice = "alto" { \voiceTwo \alto }
    >>
    \new Lyrics \with {
      \override VerticalAxisGroup #'staff-affinity = #CENTER
    } \lyricsto "soprano" \verse
    \new Staff \with {
      midiInstrument = "choir aahs"
      instrumentName = \markup \center-column { "T." "B." }
      shortInstrumentName = \markup \center-column { "T." "B." }
    } <<
      \clef bass
      \new Voice = "tenor" { \voiceOne \tenor }
      \new Voice = "bass" { \voiceTwo \bass }
    >>
  >>
  \layout { }
  \midi {
    \tempo 4=100
  }
}

% Fichiers MIDI pour répétitions :
\book {
  \bookOutputSuffix "soprano"
  \score {
    \rehearsalMidi "soprano" "soprano sax" \verse
    \midi { }
  }
}

\book {
  \bookOutputSuffix "alto"
  \score {
    \rehearsalMidi "alto" "soprano sax" \verse
    \midi { }
  }
}

\book {
  \bookOutputSuffix "tenor"
  \score {
    \rehearsalMidi "tenor" "tenor sax" \verse
    \midi { }
  }
}

\book {
  \bookOutputSuffix "bass"
  \score {
    \rehearsalMidi "bass" "tenor sax" \verse
    \midi { }
  }
}

