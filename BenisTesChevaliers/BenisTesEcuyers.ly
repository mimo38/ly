\version "2.16"
\language "français"

\header {
  tagline = ""
  composer = ""
}   
\paper {
  #(set-paper-size "a5")
}

MetriqueArmure = {
  
  \time 6/8
  \key sib \major
}

italique = { \override Score . LyricText #'font-shape = #'italic }

roman = { \override Score . LyricText #'font-shape = #'roman }

MusiqueI = \relative do' {
 \autoBeamOff
\partial 8 re8 sol4 la8 sib[re] sib la[sol] fad sol re re la'4 sib8 do4 do8 sib8.[re16]
sib8 la4\fermata
re,8 sol4 la8 sib[re] sib
la [sol] fad sol re re la'4 sib8 do[mib] do8
sib[re,] la' sol4\fermata

 sib8^\markup" (un peu plus vite)"
sib4 sib8 sib4 sib8 do[re] mib re sib re re4 re8 re4 re8 mi[do] mi 
re4 ^\markup { \italic lento } r8
mib4. do4 do8 re4 re8 sib4 sib8 do4.(sib4.) la4.\fermata r8 r8\fermata
re,8^\markup { \italic "a tempo" }
sol4 la8 sib[re] sib
la^\p [re,] la' sol4.\fermata
}


MusiqueII = \relative do'' {

}

Paroles = \lyricmode {
    \set stanza = "1."
Di -- vin Jé -- sus, nous vou -- lons ê -- tre Tes É -- cuy -- ers jus -- qu'à la mort,
Ar -- me_- nous toi_- même, ô bon Maî -- tre_;
Sois no -- tre di -- vin ré -- con -- fort.
\set stanza = "Refrain."
Nous t'imm -- mo -- lons no -- tre jeu -- nes -- se,
Dé -- si -- reux des di -- vins com -- bats_;
Ô Dieu, crois en no -- tre pro -- mes -- se, 
Nous com -- bat -- trons en bons sol -- dats.
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
\tempo 4=100}
}
