\version "2.16"
\language "français"

\header {
  tagline = ""
  composer = ""
}                                        

MetriqueArmure = {
  
  \time 2/4
  \key la \major
}

italique = { \override Score . LyricText #'font-shape = #'italic }

roman = { \override Score . LyricText #'font-shape = #'roman }

MusiqueI = \relative do'' {
 \autoBeamOff
\repeat volta 2 {
 la4^"Solo puis chœur" la8 la8 la4. la8 si8 dod si la fad4 mi 
}
 dod'4 dod dod si8 la si r8 r8
 mi, la si dod re dod la dod mi 
 dod r8 si r8 la r8 r4 \bar "|."
}


MusiqueII = \relative do'' {
 s2*4
 la4 mi la sold8 fad mi
 r8 r8
 mi dod mi la fad mi mi dod la 
 mi' r8 mi r8 la r8 r4
}

Paroles = \lyricmode {
    \set stanza = "1."
Jeanne en chan -- tant
  est par -- ti' pour la Fran -- ce,
  Ti -- rou -- li, Ra -- tan -- plan_!
  Est par -- ti' pour la Fran -- ce,
  Ra -- ta -- plan_! plan_! plan_!
}

\score{
    \new Staff <<
      \set Staff.midiInstrument = "flute"
      \set Staff.autoBeaming = ##f
      \new Voice = "theme" {\voiceOne
	\override Score.PaperColumn #'keep-inside-line = ##t
	\MetriqueArmure
	\MusiqueI
      }
      \new Voice = "accompagnement" {\voiceTwo
	\override Score.PaperColumn #'keep-inside-line = ##t
	\MusiqueII
      }
      \new Lyrics \lyricsto theme {
	\Paroles
      }                       
    >>
\layout{}
\midi{
\tempo 4=120}
}
