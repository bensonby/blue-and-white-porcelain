\version "2.18.2"
\include "articulate.ly"
#(set-global-staff-size 15)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%  http://lsr.di.unimi.it/LSR/Item?id=445

%LSR by Jay Anderson.
%modyfied by Simon Albrecht on March 2014.
%=> http://lilypond.1069038.n5.nabble.com/LSR-445-error-td160662.html

#(define (octave-up m t)
 (let* ((octave (1- t))
      (new-note (ly:music-deep-copy m))
      (new-pitch (ly:make-pitch
        octave
        (ly:pitch-notename (ly:music-property m 'pitch))
        (ly:pitch-alteration (ly:music-property m 'pitch)))))
  (set! (ly:music-property new-note 'pitch) new-pitch)
  new-note))

#(define (octavize-chord elements t)
 (cond ((null? elements) elements)
     ((eq? (ly:music-property (car elements) 'name) 'NoteEvent)
       (cons (car elements)
             (cons (octave-up (car elements) t)
                   (octavize-chord (cdr elements) t))))
     (else (cons (car elements) (octavize-chord (cdr elements ) t)))))

#(define (octavize music t)
 (if (eq? (ly:music-property music 'name) 'EventChord)
       (ly:music-set-property! music 'elements (octavize-chord
(ly:music-property music 'elements) t)))
 music)

makeOctaves = #(define-music-function (parser location arg mus) (integer? ly:music?)
 (music-map (lambda (x) (octavize x arg)) (event-chord-wrap! mus)))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cr = \change Staff = "right"
cl = \change Staff = "left"
rhMark = \markup { 
  \path #0.1 #'((moveto -1 0)(rlineto 0 -1.5)(rlineto 0.5 0))
}

\paper {
  oddFooterMarkup = \markup { \fill-line { "https://music.bensonby.me" }}
  evenFooterMarkup = \markup { \fill-line { "https://music.bensonby.me" }}
}

\header {
  title = "周杰倫 - 青花瓷"
  subtitle = "鋼琴伴奏版"
  arranger = "Arranged by Benson"
  composer = "Composed by Jay Chou"
}

upper-prelude = \relative c''' {
  s16 \acciaccatura g a\( g e d e d c a8~ a8 d16 e d c g8~ g d'16 e d c a8 c16 d8 a16 e'4\)
  \makeOctaves 1 { c16\( d e g g e e8 d c } <d fis d'>16 \makeOctaves 1 { c a8 c16 d e8 }
  <g g'>2~\startTrillSpan\finger \markup \tied-lyric #"45-13" g'4\stopTrillSpan\) r4
}

lower-prelude = \relative c {
  s16 r16 r4
  f16 a-3 c-1 d-3 e-2 g-1 d-3 e-1
  e,16 g-3 c-1 d-3 e-2 g-1 d-3 e-1
  d,16 a'-2 c-1 e-3 f a e f-1
  c,16 g' c-1 d-3 e g d e-1
  a,,16 e' g a c4
  d,,16 a' c d fis4
  g,16 d'-2 f-1 a-3 c-2 f-1 a,-4 c-2
  <g b d>2
}

upper-verse-one = \relative c' {
  s1 s1 s1 s2 <b d g>4\arpeggio g''
  s1 s1 s1 s2
}

lower-verse-one = \relative c {
  << {
    \stemNeutral
    \cl c16 g'
    \cr c16 g'~ g4
    \cl c,,16 g'
    \cr d'16 g~ g d c d
    \cl a,16 g'
    \cr c16 g'~ g4
    \cl a,,16
    \cr c'16 d g~ g d c d
    \cl f,,16
    \cr c''16 e g~ g4
    \cl f,,16
    \cr c''16 e g~ g e d e
    \cl d,16 g
    \cr c16 g'~ g8 c,
  } \\ {
    c,2 c2 a2 a f f d'
  } >>
  g,2
  << {
    \stemNeutral
    \cl c16 g'
    \cr c16 g'~ g8 d
    \cl c,16 g'
    \cr d'16 g~ g d c d
    \cl e,16
    \cr b'16 d g~ g8 b,
    \cl a,16 e'
    \cr a16 c~ c e c g
    \cl f16
    \cr c'16 e g~ g8 f
    \cl d,16 g
    \cr c16 d~ d8 g
    \cl c,,16 g'
    \cr c16 d~ d4
  } \\ {
    c,2 c e a, f' d c4. c8
  } >>
}

upper-chorus-one = \relative c'' {
  <f g,>8\( e <d g,> c
  a4.\)\( e'8 d4.\) d16\( e
  g,4. d'8 c2\)
  d4.\( c8 d2\)
  r16 g,^\( a c d c d e
  <f g,>8 e <d g,> c
  a4.\)^\( e'8 d4.\)
  d16\( e
  g4. a8 c,4~ c16\) c\( d e
  g8 e d c d4. \stemUp c8 \stemNeutral c2\)
}
upper-chorus-end-one = \relative c' {
  <c e g>4.
}
upper-chorus-two = \relative c'' {
  <f g,>8\( e <d g,> c
  a4.\)\( e'8 d4.\) d16\( e
  g,4. d'8 c2\)
  << {
    \stemNeutral
    d4.\( c8 d4. a8
    \stemUp
    e'2\)
  } \\ {
    s1
    \stemDown
    r16 g,^\( a c d c d e
    <f g,>8 e <d g,> c
    \stemNeutral
    a4.\)^\( e'8 d4.\)
  } >>
  d16\( e
  g4. a8 c,4~ c16\) c\( d e
  g8 e d c d4. \stemUp c8 \stemNeutral c2\)
}

lower-chorus-start = \relative c {
  g4 e'
}
lower-chorus-one = \relative c {
  << {
    \stemNeutral
    f16 c' \cr f a~ \stemDown a4
    \stemNeutral
    \cl f,16 d' \cr \stemDown g b~ b4
    \stemNeutral
    \cl e,,16 b' d \cr \stemDown g~ g4
    \stemUp
    \cl a,,16 e' a c~ \stemDown c4
    \stemNeutral
    d,16 a' c \cr \stemDown e~ e4
    \stemNeutral
    \cl g,,16 a' \cr \stemDown d f~ f4
    \stemNeutral
  } \\ {
    f,2 f
    e4. e16 b a2
    d4. a8 g2
  } >>
  c2 c8 c16 d e4
  << {
    \stemNeutral
    f16 c' \cr f a~ \stemDown a4
    \stemNeutral
    \cl f,16 d' \cr \stemDown g b~ b4
    \stemNeutral
    \cl e,,16 b' d \cr \stemDown g~ g4
    \stemUp
    \cl a,,16 e' a c~ \stemDown c4
    \stemUp
    d,16 a' c e~ e4
    \stemNeutral
    \cl g,,16 a' \cr \stemDown d f~ f4
    \stemNeutral
    \cl c,16 g' \cr e' d~ d8 e
  } \\ {
    f,4. c8 f2
    e4. e16 b a2
    d2 g,2
    c2
  } >>
}
lower-chorus-end-one = \relative c {
  c4.
}

upper-episode = \relative c'' {
  e16\( g a4. \stemUp g16 e \stemNeutral d4.\)
  \stemUp c16\(-3 d-1 \stemNeutral g4.-5 \stemUp g16 d c4.\)
  \stemUp c16\(-3 d-4 e8 d-4 c-5 a-4 \stemNeutral c\finger "5 - 1" d e a
  g2~\)\startTrillSpan g4\stopTrillSpan r4
}

lower-episode = \relative c {
  r8
  << {
    \stemUp
    f16 a c d
    \stemNeutral
    \cr g-2 a-1 \cl a, c
    \stemUp
    f,16 aes c d
    \stemNeutral
    \cr g-1 aes-2 \cl c, d
    \stemUp
    e,16 g c d
    \stemNeutral
    \cr g c \cl c, d
    \stemUp
    ees,16 fis c' ees
    \stemDown
    \cr fis-1 a-2 fis a \cl
    \stemNeutral
    d,,16 a' c \cr e
    \stemDown
    f c e-2 f-1 \cl
    \stemUp
    d,16 \clef treble a'-5 c-3 e-2
    \stemNeutral
    f-1
    \set fingeringOrientations = #'(left)
    <c'\finger \rhMark> e, f
    \clef bass
    \stemUp
    g,, d' g c g'8\noBeam e16[( g d2])
  } \\ {
    f,2 f4. c16 d e4. e8 ees2
    d4. a8 d,2 g
    <g' b>2
  } >>
}

upper-verse-two = \relative c' {
  s1 s1 s1 s2 <b d g>4\arpeggio g''
  g,2.\( \stemUp d'4 \stemNeutral e2. \stemUp g8 g,
  a2. g4
  \stemNeutral
  c2\)
}

lower-verse-two = \relative c {
  << {
    \stemNeutral
    \cl c16 g'
    \cr c16 g'~ g4
    \cl c,,16 g'
    \cr d'16 g~ g d c d
    \cl a,16 g'
    \cr c16 g'~ g4
    \cl a,,16
    \cr c'16 d g~ g d c d
    \cl f,,16
    \cr c''16 e g~ g4
    \cl f,,16
    \cr c''16 e g~ g e d e
    \cl d,16 g
    \cr c16 g'~ g8 c,
  } \\ {
    c,2 c4. b8 a2 a4. g8 f2 f d'
  } >>
  g,2
  << {
    \stemNeutral
    \cl c16 g'
    \cr c16 g'~ g8 d
    \cl c,16 g'
    \cr d'16 g~ \stemDown g d c d
    \stemDown
    \cl e,16
    b'16 d g~ g8 b,
    a,16 e'
    a16 c~ c e c g
    \stemNeutral
    f16
    \cr c'16 e g~ g8 f
    \cl d,16 g
    \cr c16 d~ \stemDown d4
    \stemNeutral
    \cl c,16 g'
    \cr c16 d~ d4
  } \\ {
    c,2 c4. d8
    \stemUp
    e2 a,
    \stemDown
    f' d c4. c8
  } >>
}

upper-chorus-last-and-outro = \relative c' {
  f32\( bes c d f d bes g c16\)
  g'16\( g e
  \key c \major
  a4. \stemUp e8 \stemNeutral d4.\) \stemUp e8\(
  g,4. d'8 \stemNeutral c4~ c16\)
  c\( d e g16 a g e g e e d d4~ \stemUp d16\) c\( d c
  \stemNeutral
  <d e, g>8 c16 d~ d e8 f16~ f e~ e d32 e d16 c c8\)
  a'4.\( e8 d4. d16 e g4. d16 e c4~ c16\)
  << {
    \stemNeutral
    c16\( d e g a g e g e e d d4 a
    \stemDown
    c\)
  } \\ {
    s16*3 s1
    \stemUp d16^\( e d e
    \stemNeutral
    g e g e d8 d16 e a,8 g\)
    d'16^\( e d e g e g e d8 d16 e a,8 g\)
    d'16^\( e d e g e g e d8 d16 e a,8 g\)
    d'16^\( e d e g e g e d2\)
  } >>
}

lower-chorus-end-two = \relative c' {
  << {
    g16 bes d f e, g c e
  } \\ {
    g,4 e
  } >>
}
lower-chorus-last = \relative c {
  \key c \major
  << {
    \stemNeutral
    f16 c' f \cr a~ \stemDown a4
    \stemNeutral
    \cl f,16 d' \cr \stemDown g b~ b4
    \stemNeutral
    \cl e,,16 b' d \cr \stemDown g~ g4
    \stemDown
    \cl a,,16
    \set fingeringOrientations = #'(left)
    <e''\finger \rhMark>
    d c a g e c
    \stemNeutral
    d16 a' c e~ e4
    \stemNeutral
    \cl g,,16 a' \cr \stemDown d f~ f4
    \stemNeutral
  } \\ {
    f,2 f
    e4. e16 b \stemUp a2
    \stemUp d4. \stemDown a8 g2
  } >>
  c2 c8 c16 d e4
  << {
    \stemNeutral
    f16 c' f \cr a~ \stemDown a4
    \stemNeutral
    \cl f,16 d' \cr \stemDown g b~ b4
    \stemNeutral
    \cl e,,16 b' d \cr \stemDown g~ g4
    \stemUp
    \cl a,,16 e' a c~ \stemDown c4
    \stemUp
    d,16 a' c e~ e4
    \stemNeutral
    \cl g,,16 a' \cr \stemDown d f~ f4
    \stemDown
    \cl c,16 g' c d~ d4
    c,16 g' c d~ d4
    f,16 c' f g~ g4
    f,16 c' f g~ g4
    a,,16 g' c e~ e4
    a,,16 g' c e~ e4
    f,16 c' f g~ g4
  } \\ {
    f,4. c8 f2
    e4. e16 b a2
    d2 g,2
    \stemUp
    c2 c f f a, a f'1
  } >>
}

pedals = {
  s8 s4
  s2\sustainOn
  \repeat unfold 22 { s2\sustainOff\sustainOn }
  \repeat unfold 2 { s4\sustainOff\sustainOn }
  \repeat unfold 7 { s2\sustainOff\sustainOn }
  \repeat unfold 2 { s4\sustainOff\sustainOn }
  \repeat unfold 8 { s2\sustainOff\sustainOn }
  % episode
  s2\sustainOff\sustainOn
  s4.\sustainOff\sustainOn
  s16
  s16\sustainOff\sustainOn
  s4.\sustainOff\sustainOn
  s8\sustainOff\sustainOn
  s2\sustainOff\sustainOn
  \repeat unfold 4 { s2\sustainOff\sustainOn }
  % verse 2
  s2\sustainOff\sustainOn
  s4.\sustainOff\sustainOn
  s8\sustainOff\sustainOn
  s2\sustainOff\sustainOn
  s4.\sustainOff\sustainOn
  s8\sustainOff\sustainOn
  \repeat unfold 4 { s2\sustainOff\sustainOn }
  s2\sustainOff\sustainOn
  s4.\sustainOff\sustainOn
  s8\sustainOff\sustainOn
  \repeat unfold 5 { s2\sustainOff\sustainOn }
  \repeat unfold 2 { s4\sustainOff\sustainOn }
  % chorus
  \repeat unfold 7 { s2\sustainOff\sustainOn }
  \repeat unfold 2 { s4\sustainOff\sustainOn }
  \repeat unfold 7 { s2\sustainOff\sustainOn }
  \repeat unfold 2 { s4\sustainOff\sustainOn }
  \repeat unfold 7 { s2\sustainOff\sustainOn }
  \repeat unfold 2 { s4\sustainOff\sustainOn }
  \repeat unfold 6 { s2\sustainOff\sustainOn }
  \repeat unfold 6 { s2\sustainOff\sustainOn }
  s2.\sustainOff\sustainOn s4\sustainOff
}

upper-c-major = \relative c' { \set fingeringOrientations = #'(up)
  \clef treble
  \tempo 4 = 54
  \time 4/4
  \key c \major
  \partial 16*6
  \upper-prelude
  \upper-verse-one
  \upper-chorus-one
  \upper-chorus-end-one
  \upper-episode
  \upper-verse-two
  \upper-chorus-two
  \upper-chorus-last-and-outro
  \bar "|."
}

lower-c-major = \relative c {
  \clef bass
  \time 4/4
  \key c \major
  \partial 16*6
  \lower-prelude
  \lower-verse-one
  \lower-chorus-start
  \lower-chorus-one
  \lower-chorus-end-one
  \lower-episode
  \lower-verse-two
  \lower-chorus-start
  \lower-chorus-one
  \lower-chorus-end-two
  \lower-chorus-last
  \bar "|."
}

upper-original-key = \relative c' {
  \set fingeringOrientations = #'(up)
  \clef treble
  \tempo 4 = 54
  \time 4/4
  \key a \major
  \partial 16*6
  \transpose c a, {
    \upper-prelude
    \upper-verse-one
    \upper-chorus-one
    \upper-chorus-end-one
    \upper-episode
    \upper-verse-two
    \upper-chorus-two
  }
  \transpose c bes, {
    \upper-chorus-last-and-outro
  }
  \bar "|."
}

lower-original-key = \relative c {
  \clef bass
  \time 4/4
  \key a \major
  \partial 16*6
  \transpose c a, {
    \lower-prelude
    \lower-verse-one
    \lower-chorus-start
    \lower-chorus-one
    \lower-chorus-end-one
    \lower-episode
    \lower-verse-two
    \lower-chorus-start
    \lower-chorus-one
  }
  \transpose c bes, {
    \lower-chorus-end-two
    \lower-chorus-last
  }
  \bar "|."
}

dynamics = {
  \partial 16*6
  s8 s4 s1\mp s1*10
  s2 s2\mf s1*3 s16 s8.\< s4 s2\! s1\mf s1*7
  % second verse
  s1\mp s1*3 s1\mf s1*6 s16 s8.\< s4 s2\! s1\mf s1*2
  s2 s2\< s1\!\f s1*9 s1_\markup { \italic "rit." }
}

guitarchords = \chordmode {
  % ais1:m
}

lyricsmain = \lyricmode {
  素 胚 勾 勒 出 青 花 筆 鋒 濃 轉 淡
  瓶 身 描 繪 的 牡 丹 一 如 妳 初 妝
  冉 冉 檀 香 透 過 窗 心 事 我 了 然
  宣 紙 上 走 筆 至 此 擱 一 半

  釉 色 渲 染 仕 女 圖 韻 味 被 私 藏
  而 妳 嫣 然 的 一 笑 如 含 苞 待 放
  妳 的 美 一 縷 飄 散 去 到 我 去 不 了 的 地 方

  天 青 色 等 煙 雨 而 我 在 等 妳
  炊 煙 裊 裊 昇 起 隔 江 千 萬 里
  在 瓶 底 書 漢 隸 仿 前 朝 的 飄 逸
  就 當 我 為 遇 見 妳 伏 筆

  天 青 色 等 煙 雨 而 我 在 等 妳
  月 色 被 打 撈 起 暈 開 了 結 局
  如 傳 世 的 青 花 瓷 自 顧 自 美 麗 妳 眼 帶 笑 意

  色 白 花 青 的 錦 鯉 躍 然 於 碗 底
  臨 摹 宋 體 落 款 時 卻 惦 記 著 妳
  妳 隱 藏 在 窯 燒 裡 千 年 的 秘 密
  極 細 膩 猶 如 繡 花 針 落 地

  簾 外 芭 蕉 惹 驟 雨 門 環 惹 銅 綠
  而 我 路 過 那 江 南 小 鎮 惹 了 妳
  在 潑 墨 山 水 畫 裡  妳 從 墨 色 深 處 被 隱 去

  天 青 色 等 煙 雨 而 我 在 等 妳
  炊 煙 裊 裊 昇 起 隔 江 千 萬 里
  在 瓶 底 書 漢 隸 仿 前 朝 的 飄 逸
  就 當 我 為 遇 見 妳 伏 筆

  天 青 色 等 煙 雨 而 我 在 等 妳
  月 色 被 打 撈 起 暈 開 了 結 局
  如 傳 世 的 青 花 瓷 自 顧 自 美 麗
  妳 眼 帶 笑 意

  天 青 色 等 煙 雨 而 我 在 等 妳
  炊 煙 裊 裊 昇 起 隔 江 千 萬 里
  在 瓶 底 書 漢 隸 仿 前 朝 的 飄 逸
  就 當 我 為 遇 見 妳 伏 筆

  天 青 色 等 煙 雨 而 我 在 等 妳
  月 色 被 打 撈 起 暈 開 了 結 局
  如 傳 世 的 青 花 瓷 自 顧 自 美 麗
  妳 眼 帶 笑 意
}

melody-verse = \relative c'' {
  r16 d c a c8 c16 a c8 c16 a c a g8
  r16 d' c a c8 c16 a c8 c16 e d c c8
  r16 g a e' e8 e16 d e8 e16 d e g8 e16
  r16 e e e d d d d d8 c16 e~( e d8.)
  r16 d c a c8 c16 a c8 c16 a c a g8
  r16 g a e' g8 g16 e g8 g16 e d c c8
  r16 d c d e d d( c) d r c a d c c a c8 c16 c~ c4 r4 r4
}

melody-verse-two = \relative c'' {
  r16 d c a c8 c16 a c8 c16 a c a g8
  r16 d' c a c8 c16 a c8 c16 e d c c8
  r16 g a e' e8 e16 d d( e) e16 d e g8 e16
  r16 e e e d d d d d8 c16 e~( e d8.)
  r16 d c a c8 c16 a c8 c16 a c a g8
  r16 g a e' g8 g16 e g8 g16 e d c c8
  r16 d c d e d d( c) d r c a d c c a c8 c16 d~( d c8.) r4 r4
}

melody-chorus = \relative c''' {
  r16 g16 g e d e a,8 d16 e g e d4
  r16 g g e d e g,8 d'16 e g d c4
  r16 c d e g a g e g e e d d4
  r16 c d c d8 c16 d~ d16 e8 g16~ g e8.
  r16 g16 g e d e a,8 d16 e g e d4
  r16 g g e d e g,8 d'16 e g d c4
  r16 c d e g a g e g e e d d8 r16
  g,16 e'8 d16 d~ d c8.~ c4 r4
}

melody-chorus-two = \relative c''' {
  r16 g16 g e
  \key c \major
  d e a,8 d16 e g e d4
  r16 g g e d e g,8 d'16 e g d c4
  r16 c d e g a g e g e e d d4
  r16 c d c d8 c16 d~ d16 e8 g16~ g e8.
  r16 g16 g e d e a,8 d16 e g e~ e d8.
  r16 g g e d e g,8 d'16 e g d~ d c8.
  r16 c d e g a g e g e e d d8 r16
  g,16 e'8 d16 d~ d c8.~ c4 r2
}

melody = \relative c' {
  \clef treble
  \time 4/4
  \key c \major
  \partial 16*6
  s16 r16 r4 R1 R1 R1 r2 r4
  \melody-verse
  \melody-chorus
  r4 R1 R1 R1 r2 r4
  \melody-verse-two
  \melody-chorus
  \melody-chorus-two
  R1 R1 R1
  \bar "|."
}

melody-original-key = \relative c' {
  \clef treble
  \time 4/4
  \key a \major
  \partial 16*6
  s16 r16 r4 R1 R1 R1 r2 r4
  \transpose c a, {
    \melody-verse
    \melody-chorus
    r4 R1 R1 R1 r2 r4
    \melody-verse-two
    \melody-chorus
  }
  \transpose c bes, {
  \melody-chorus-two
  }
  R1 R1 R1
  \bar "|."
}

\book {
\score {
  <<
    % \new ChordNames {
      % \guitarchords
    % }
    \new Staff = "melodystaff" <<
      \set Staff.midiInstrument = #"electric guitar (clean)"
      \set Staff.instrumentName = #"Ocarina"
      \set Staff.midiMinimumVolume = #0.9
      \set Staff.midiMaximumVolume = #1
      \new Voice = "melody" {
        \melody
      }
      \context Lyrics = "lyrics" { \lyricsto "melody" { \lyricsmain } }
    >>
    \new PianoStaff <<
      \new Staff = "right" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.6
        \set Staff.midiMaximumVolume = #0.7
        \articulate << \upper-c-major \pedals >>
      }
      \new Staff = "left" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.6
        \set Staff.midiMaximumVolume = #0.7
        \articulate << \lower-c-major \pedals >>
      }
    >>
  >>
  \midi {
    \context {
      \ChordNameVoice \remove Note_performer
    }
  }
}
}

\book {
\bookOutputSuffix "c-major-no-vocal"
\score {
  <<
    % \new ChordNames {
      % \guitarchords
    % }
    \new PianoStaff <<
      \new Staff = "right" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.6
        \set Staff.midiMaximumVolume = #0.7
        \articulate << \upper-c-major \pedals >>
      }
      \new Staff = "left" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.6
        \set Staff.midiMaximumVolume = #0.7
        \articulate << \lower-c-major \pedals >>
      }
    >>
  >>
  \midi {
    \context {
      \ChordNameVoice \remove Note_performer
    }
  }
}
}

\book {
\bookOutputSuffix "c-major"
\score {
  <<
    % \new ChordNames {
      % \set chordChanges = ##t
      % \guitarchords
    % }
    \new Staff = "melodystaff" \with {
      fontSize = #-3
      \override StaffSymbol.staff-space = #(magstep -3)
      \override StaffSymbol.thickness = #(magstep -3)
    }
    <<
      \set Staff.instrumentName = #"Solo"
      \new Voice = "melody" {
        \melody
      }
      \context Lyrics = "lyrics" { \lyricsto "melody" { \lyricsmain } }
    >>
    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Piano"
      \new Staff = "right" { \upper-c-major }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" { \lower-c-major }
    >>
  >>
  \layout {
    \context {
      \Score
      % Remove all-rest staves also in the first system
      \override VerticalAxisGroup.remove-first = ##t
      % If only one non-empty staff in a system exists, still print the starting bar
      \override SystemStartBar.collapse-height = #1
    }
    \context {
      \ChordNames
      \override ChordName #'font-size = #-3
    }
  }
}
}

\book {
\bookOutputSuffix "original-key"
\score {
  <<
    % \new ChordNames {
      % \set chordChanges = ##t
      % \guitarchords
    % }
    \new Staff = "melodystaff" \with {
      fontSize = #-3
      \override StaffSymbol.staff-space = #(magstep -3)
      \override StaffSymbol.thickness = #(magstep -3)
    }
    <<
      \set Staff.instrumentName = #"Solo"
      \new Voice = "melody" {
        \melody-original-key
      }
      \context Lyrics = "lyrics" { \lyricsto "melody" { \lyricsmain } }
    >>
    \new PianoStaff <<
      \set PianoStaff.instrumentName = #"Piano"
      \new Staff = "right" { \upper-original-key }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" { \lower-original-key }
    >>
  >>
  \layout {
    \context {
      \Score
      % Remove all-rest staves also in the first system
      \override VerticalAxisGroup.remove-first = ##t
      % If only one non-empty staff in a system exists, still print the starting bar
      \override SystemStartBar.collapse-height = #1
    }
    \context {
      \ChordNames
      \override ChordName #'font-size = #-3
    }
  }
}
}

