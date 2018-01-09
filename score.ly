\version "2.18.2"
#(set-global-staff-size 16)

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


\header {
  title = "周杰倫 - 青花瓷"
  subtitle = "For ocarina and piano accompaniment"
  arranger = "Arranged by Benson"
}

upper-midi = \relative c' {
  \set Staff.pedalSustainStyle = #'bracket
  \clef treble
  \tempo 4 = 54
  \time 4/4
  \key c \major
  \bar "|."
}

lower-midi = \relative c {
  \set Staff.pedalSustainStyle = #'bracket
  \clef bass
  \time 4/4
  \key c \major
  \bar "|."
}

upper-print = \relative c' {
  \set Staff.pedalSustainStyle = #'bracket
  \set fingeringOrientations = #'(up)
  \clef treble
  \tempo 4 = 54
  \time 4/4
  \key c \major
  \bar "|."
}

lower-print = \relative c {
  \set Staff.pedalSustainStyle = #'bracket
  \clef bass
  \time 4/4
  \key c \major
  \bar "|."
}

dynamics = {
  s1
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

melody-verse = \relative c' {
  r16 d c a c8 c16 a c8 c16 a c a g8
  r16 d' c a c8 c16 a c8 c16 e d c c8
  r16 g a e' e8 e16 d e8 e16 d e g8 e16
  r16 e e e d d d d d8 c16 e~( e d8.)
  r16 d c a c8 c16 a c8 c16 a c a g8
  r16 g a e' g8 g16 e g8 g16 e d c c8
  r16 d c d e d d( c) d r c a d c c a c8 c16 c~ c4 r4 r4
}

melody-verse-two = \relative c' {
  r16 d c a c8 c16 a c8 c16 a c a g8
  r16 d' c a c8 c16 a c8 c16 e d c c8
  r16 g a e' e8 e16 d d( e) e16 d e g8 e16
  r16 e e e d d d d d8 c16 e~( e d8.)
  r16 d c a c8 c16 a c8 c16 a c a g8
  r16 g a e' g8 g16 e g8 g16 e d c c8
  r16 d c d e d d( c) d r c a d c c a c8 c16 d~( d c8.) r4 r4
}

melody-chorus = \relative c'' {
  r16 g16 g e d e a,8 d16 e g e d4
  r16 g g e d e g,8 d'16 e g d c4
  r16 c d e g a g e g e e d d4
  r16 c d c d8 c16 d~ d16 e8 g16~ g e8.
  r16 g16 g e d e a,8 d16 e g e d4
  r16 g g e d e g,8 d'16 e g d c4
  r16 c d e g a g e g e e d d8 r16
  g,16 e'8 d16 d~ d c8.~ c4 r4
}

melody-chorus-two = \relative c'' {
  r16 g16 g e d e a,8 d16 e g e d4
  r16 g g e d e g,8 d'16 e g d c4
  r16 c d e g a g e g e e d d4
  r16 c d c d8 c16 d~ d16 e8 g16~ g e8.
  r16 g16 g e d e a,8 d16 e g e~ e d8.
  r16 g g e d e g,8 d'16 e g d~ d c8.
  r16 c d e g a g e g e e d d8 r16
  g,16 e'8 d16 d~ d c8.~ c4 r4
}

melody = \relative c' {
  \clef treble
  \time 4/4
  \key c \major
  \partial 2
  r2 R1 R1 R1 r2 r4
  \melody-verse
  \melody-chorus
  r4 R1 R1 R1 r2 r4
  \melody-verse-two
  \melody-chorus
  \melody-chorus-two
  r4 R1 R1 R1
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
      \set Staff.midiInstrument = #"acoustic grand"
      \set Staff.instrumentName = #"Piano"
      \new Staff = "right" {
        \set Staff.midiMinimumVolume = #0.1
        \set Staff.midiMaximumVolume = #0.4
        \upper-midi
      }
      \new Staff = "left" {
        \set Staff.midiMinimumVolume = #0.1
        \set Staff.midiMaximumVolume = #0.4
        \lower-midi
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
      \set Staff.midiInstrument = #"choir aahs"
      \set Staff.instrumentName = #"Ocarina"
      \new Voice = "melody" {
        \melody
      }
      \context Lyrics = "lyrics" { \lyricsto "melody" { \lyricsmain } }
    >>
    \new PianoStaff <<
      \set Staff.midiInstrument = #"acoustic grand"
      \set Staff.instrumentName = #"Piano"
      \new Staff = "right" { \upper-print }
      \new Dynamics = "Dynamics_pf" \dynamics
      \new Staff = "left" { \lower-print }
    >>
  >>
  \layout {
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      \Staff \RemoveEmptyStaves
    }
    \context {
      % add the RemoveEmptyStaffContext that erases rest-only staves
      \Dynamics \RemoveEmptyStaves
    }
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

