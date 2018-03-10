\version "2.18.2"
\include "articulate.ly"
#(set-global-staff-size 16)

% collision for dynamics
% write remarks or modify title for C major version

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
lhMark = \markup { 
  \path #0.1 #'((moveto 0 1)(rlineto -0.5 0)(rlineto 0 -1.5))
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
  \tag #'c-major {
    f16 a-3 c-1 d-3 e-2 g-1 d-3 e-1
    e,16 g-3 c-1 d-3 e-2 g-1 d-3 e-1
    d,16 a'-2 c-1 e-3 f a e f-1
    c,16 g' c-1 d-3 e g d e-1
    a,,16 e' g a c4
    d,,16 a' c d fis4
    g,16 d'-2 f-1 a c-2 f-1 a,-4 c-2
  }
  \tag #'original {
    f,16 a c d e g d e
    e,16 g c d e g d e
    d,16 a' c-1 e f a e f
    c,16 g' c d e g d e
    a,,16 e' g a c4
    d,,16 a' c d fis4
    g,16 d'-2 f-1 a c-2 f-1 a,-4 c-2
  }
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
  \stemUp
  a4.\)^\( e'8 d4.\) d16^\( e
  g,4. d'8
  \stemNeutral
  c2\)
  \stemUp
  d4.^\( c8 d2\)
  \stemNeutral
  r16 g,^\( a c d c d e
  <f g,>8 e <d g,> c
  \stemUp
  a4.\)^\( e'8 d4.\)
  d16^\( e
  g4. a8
  \stemNeutral
  c,4~ c16\) c\( d e
  g8 e d c
  \stemUp
  d4. c8 c2\)
}
upper-chorus-end-one = \relative c' {
  <c e g>4.
}
upper-chorus-two = \relative c'' {
  <f g,>8^\( e <d g,> c
  \stemUp
  a4.^\)^\( e'8 d4.\) d16^\( e
  g,4. d'8
  \stemNeutral
  c2\)
  << {
    d4.\( c8 d4. a8
    e'2\)
  } \\ {
    s1
    \stemDown
    r16 g,_\( a c d c d e
    <f g,>8 e <d g,> c
    \stemUp
    a4.\)^\( e'8 d4.\)
  } >>
  \stemUp
  d16^\( e
  g4. a8
  \stemNeutral
  c,4~ c16\) c\( d e
  g8 e d c \stemUp d4. c8 c2\)
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
    \cl c,16 g' \cr e' d~ \stemDown d8 e
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
  e16^\( g \stemUp a4. g16 e d4.\)
  \tag #'c-major {
    c16^\(-3 d-1 g4.-5
  }
  \tag #'original {
    c,16^\( d g4.
  }
  g16 d c4.\)
  c16\(-3 d-4 e8 d-4 c-5 a-4 \stemNeutral

  \tag #'c-major {
    c8\finger "5-1"
  }
  \tag #'original {
    c8
  }
  d8 e a
  g2~\)\startTrillSpan g4\stopTrillSpan r4
}

lower-episode = \relative c {
  r8
  << {
    \stemUp
    f16 a c d
    \stemNeutral
    \cr
    \tag #'c-major { g-2 a-1 }
    \tag #'original { g-1 a-2 }
    \cl a, c
    \stemUp
    f,16 aes c d
    \stemNeutral
    \cr
    \tag #'c-major { g-1 aes-2 }
    \tag #'original { g aes }
    \cl c, d
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
    f c
    \set fingeringOrientations = #'(left)
    <e-2>
    \set fingeringOrientations = #'(up)
    f-1 \cl
    \stemUp
    d,16
    \tag #'c-major { \clef treble }
    a'-5 c-3 e-2
    \stemNeutral
    f-1
    \set fingeringOrientations = #'(left)
    <c'\finger \rhMark> e, f
    \clef bass
    \stemUp
    g,, d' g c g'8 e16( g d2)
  } \\ {
    f,2 f4. c16 d e4. e8 ees2
    d4. a8 d,2 g
    <g' b>2
  } >>
}

upper-verse-two = \relative c' {
  s1 s1 s1 s2 <b d g>4\arpeggio g''
  \stemUp
  g,2.\( d'4 \stemNeutral e2. g8 g,
  \stemUp a2. g4
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
    \cr c16 g'~ \stemDown g8 d
    \stemNeutral
    \cl c,16 g'
    \cr d'16 g_~ \stemDown g d c d
    \stemDown
    \cl e,16
    b'16 d g~ g8 b,
    a,16 e'
    a16 c~ c e c g
    \stemNeutral
    f16
    \cr c'16 e g~ \stemDown g8 f
    \stemNeutral
    \cl d,16 g
    \cr c16 d_~ \stemDown d4
    \stemNeutral
    \cl c,16 g'
    \cr c16 d~ \stemDown d4
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
  g'16^\( g e
  \key c \major
  \stemUp a4. e8 d4.\) e8^\(
  g,4. d'8 c4~\) \stemNeutral c16
  c\( d e g16 a g e g e e d d4~ \stemUp d16\) c\( d c
  \stemNeutral
  <d e, g>8 c16 d~ d e8 f16~ f e~ e d32 e d16 c c8\)
  \stemUp
  a'4.\( e8 d4. d16 e g4. d16 e \stemNeutral c4~ c16\)
  << {
    \stemNeutral
    c16\( d e g a g e g e e d \stemUp d4 a
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
    e16\rest
    e
    \set fingeringOrientations = #'(left)
    <d\finger \lhMark>
    \once \override Glissando #'style = #'dashed-line
    c\glissando \cl a g e c
    \stemUp
    d16 a' c e~ e4
    \stemNeutral
    \cl g,,16 a' \cr \stemDown d f~ f4
    \stemNeutral
  } \\ {
    f,2 f
    e4. e16 b a2
    \stemDown d4. \stemDown a8 g2
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
    \cl g,,16 a' \cr \stemDown d f_~ f4
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
  s16 s\mp s4 s1*11
  s2 s2\mf s1*3 s16 s8.\< s4 s2\! s1\mf s1*7
  % second verse
  s1\mp s1*3 s1\mf s1*6 s16 s8.\< s4 s2\! s1\mf s1*2
  s2 s2\< s1\!\f s1*9 s1_\markup { \italic "rit." }
}

guitarchords = \chordmode {
  \partial 16*6
  s8 s4
  f2 c/e d:m7 c a:m7 d:7 g:11 g
  % verse 1
  c2 c:sus2 a1:m7 f:maj9 g2:sus4/d g
  c1:sus2 e2:m7 a:m7 f:maj9 g:sus4/d c:sus2 c4:sus4/g c:sus2/e
  % chorus 1
  f2 g:7/f e:m7 a:m d:m9 g:7sus2
  c2 c4:sus4 c:sus2/e
  f2 g:7/f e:m7 a:m d:m9 g:7sus2 c:sus2 c
  % episode
  f2:6 f:m6 c:sus2/e ees:dim7 d1:9 g2:sus4 g
  % verse 2
  c2 c4.:sus2 g8/b a1:m7 f:maj9 g2:sus4/d g
  c1:sus2 e2:m7 a:m7 f:maj9 g:sus4/d c:sus2 c4:sus4/g c:sus2/e
  % chorus 2
  f2 g:7/f e:m7 a:m d:m9 g:7sus2
  c2 c4:sus4 c:sus2/e
  f2 g:7/f e:m7 a:m d:m9 g:7sus2 c:sus2 g4:m7 c/e
  % chorus 3
  f2 g:7/f e:m7 a:m d:m9 g:7sus2
  c2 c4:sus4 c:sus2/e
  f2 g:7/f e:m7 a:m d:m9 g:7sus2
  % outro
  c1:sus2 f:sus2 a:m7 f:sus2
}

guitarchords-original-key = \chordmode {
  \partial 16*6
  s8 s4
  d2 a/cis b:m7 a fis:m7 b:7 e:11 e
  % verse 1
  a2 a:sus2 fis1:m7 d:maj9 e2:sus4/b e
  a1:sus2 cis2:m7 fis:m7 d:maj9 e:sus4/b a:sus2 a4:sus4/e a:sus2/cis
  % chorus 1
  d2 e:7/d cis:m7 fis:m b:m9 e:7sus2
  a2 a4:sus4 a:sus2/cis
  d2 e:7/d cis:m7 fis:m b:m9 e:7sus2 a:sus2 a
  % episode
  d2:6 d:m6 a:sus2/cis c:dim7 b1:9 e2:sus4 e
  % verse 2
  a2 a4.:sus2 e8/gis fis1:m7 d:maj9 e2:sus4/b e
  a1:sus2 cis2:m7 fis:m7 d:maj9 e:sus4/b a:sus2 a4:sus4/e a:sus2/cis
  % chorus 2
  d2 e:7/d cis:m7 fis:m b:m9 e:7sus2
  a2 a4:sus4 a:sus2/cis
  d2 e:7/d cis:m7 fis:m b:m9 e:7sus2 a:sus2 f4:m7 bes/d
  % chorus 3
  ees2 f:7/ees d:m7 g:m c:m9 f:7sus2
  bes2 bes4:sus4 bes:sus2/d
  ees2 f:7/ees d:m7 g:m c:m9 f:7sus2
  % outro
  bes1:sus2 ees:sus2 g:m7 ees:sus2
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
        \articulate << \keepWithTag #'c-major \upper-c-major \pedals >>
      }
      \new Staff = "left" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.6
        \set Staff.midiMaximumVolume = #0.7
        \articulate << \keepWithTag #'c-major \lower-c-major \pedals >>
      }
    >>
  >>
  \midi {
  }
}
}

\book {
\bookOutputSuffix "c-major-no-vocal"
\score {
  <<
    \new PianoStaff <<
      \new Staff = "right" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.6
        \set Staff.midiMaximumVolume = #0.7
        \articulate << \keepWithTag #'c-major \upper-c-major \pedals >>
      }
      \new Staff = "left" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.6
        \set Staff.midiMaximumVolume = #0.7
        \articulate << \keepWithTag #'c-major \lower-c-major \pedals >>
      }
    >>
  >>
  \midi {
  }
}
}

\book {
\bookOutputSuffix "c-major"
\score {
  <<
    \new ChordNames {
      \guitarchords
    }
    \new Staff = "melodystaff" \with {
      % fontSize = #-3
      % \override StaffSymbol.staff-space = #(magstep -3)
      % \override StaffSymbol.thickness = #(magstep -3)
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
      \new Staff = "right" { \keepWithTag #'c-major \upper-c-major }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" { \keepWithTag #'c-major \lower-c-major }
    >>
  >>
  \layout {
    % \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      % \Staff \RemoveEmptyStaves
    % }
    \context {
      \Score
      % Remove all-rest staves also in the first system
      \override VerticalAxisGroup.remove-first = ##t
      % If only one non-empty staff in a system exists, still print the starting bar
      \override SystemStartBar.collapse-height = #1
    }
    \context {
      \ChordNames
      % \override ChordName #'font-size = #-1
    }
  }
}
}

\book {
\bookOutputSuffix "original-key"
\score {
  <<
    \new ChordNames {
      \guitarchords-original-key
    }
    \new Staff = "melodystaff" \with {
      % fontSize = #-3
      % \override StaffSymbol.staff-space = #(magstep -3)
      % \override StaffSymbol.thickness = #(magstep -3)
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
      \new Staff = "right" { \keepWithTag #'original \upper-original-key }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" { \keepWithTag #'original \lower-original-key }
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
      % \override ChordName #'font-size = #-1
    }
  }
}
\score {
  <<
    \new Staff = "melodystaff" <<
      \set Staff.midiInstrument = #"electric guitar (clean)"
      \set Staff.instrumentName = #"Ocarina"
      \set Staff.midiMinimumVolume = #0.9
      \set Staff.midiMaximumVolume = #1
      \new Voice = "melody" {
        \melody-original-key
      }
      \context Lyrics = "lyrics" { \lyricsto "melody" { \lyricsmain } }
    >>
    \new PianoStaff <<
      \new Staff = "right" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.6
        \set Staff.midiMaximumVolume = #0.7
        \articulate << \keepWithTag #'original \upper-original-key \pedals >>
      }
      \new Staff = "left" {
        \set Staff.midiInstrument = #"acoustic grand"
        \set Staff.midiMinimumVolume = #0.6
        \set Staff.midiMaximumVolume = #0.7
        \articulate << \keepWithTag #'original \lower-original-key \pedals >>
      }
    >>
  >>
  \midi {
  }
}
}

