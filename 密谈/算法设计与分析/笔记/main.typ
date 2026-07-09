// 算法设计与分析 · 中文讲义
// 基于 Kleinberg & Tardos, Algorithm Design (2006)
// 主文件：包含文档设置、封面、目录，并 include 各章

#let cjk-fonts = ("Songti SC", "Noto Serif CJK SC", "Source Han Serif SC")
#let mono-fonts = ("Menlo", "Monaco", "DejaVu Sans Mono")

#set page(
  numbering: "1",
  margin: (top: 2.4cm, bottom: 2.4cm, inside: 2.2cm, outside: 2.2cm),
  header: context {
    let n = here().page()
    if n > 1 {
      set text(size: 9pt, fill: gray, font: cjk-fonts)
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [算法设计与分析 · 讲义], [Kleinberg & Tardos *Algorithm Design*],
      )
      line(length: 100%, stroke: 0.5pt + gray)
    }
  },
)

#set text(font: cjk-fonts, size: 11pt, lang: "zh", region: "cn")
#set par(justify: true, leading: 0.9em, spacing: 0.8em)

// 标题样式
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  v(2em)
  block(width: 100%, spacing: 0pt)[
    #set text(size: 22pt, weight: "bold")
    #it.body
  ]
  v(0.4em)
  line(length: 100%, stroke: 1.2pt + black)
  v(1em)
}

#show heading.where(level: 2): it => {
  v(1.2em)
  block[
    #set text(size: 15pt, weight: "bold")
    #it.body
  ]
  v(0.3em)
}

#show heading.where(level: 3): it => {
  v(0.8em)
  block[
    #set text(size: 12.5pt, weight: "bold")
    #it.body
  ]
  v(0.2em)
}

#show heading.where(level: 4): it => {
  v(0.5em)
  block[
    #set text(size: 11pt, weight: "bold")
    #it.body
  ]
}

// 代码块样式（使用 codly 包）
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()

// ===== 表格全局样式 =====
#let table-header-bg = rgb("#2c3e50")
#let table-stripe-bg = rgb("#f5f7fa")
#let table-border-color = rgb("#d0d4dc")

#set table(
  inset: (x: 10pt, y: 6pt),
  align: horizon,
  stroke: (x: none, y: 0.4pt + table-border-color),
  fill: (_, y) => if y == 0 {
    table-header-bg
  } else if calc.odd(y) {
    table-stripe-bg
  } else {
    none
  },
)

// 表头行：白色粗体
#show table.cell.where(y: 0): set text(fill: white, weight: "bold")

// ===== 封面 =====
#v(3cm)
#align(center)[
  #text(size: 34pt, weight: "bold")[算法设计与分析]
  #v(0.3cm)
  #block(width: 70%)[
    #align(center)[
      #text(size: 13pt, fill: gray)[
        基于 Jon Kleinberg \& Éva Tardos \
        *Algorithm Design* (2006)
      ]
    ]
  ]
  #v(15cm)
  #text(size: 12pt, fill: gray)[上海财经大学 2025–2026 学年第二学期]
  #v(0.3cm)
  #text(size: 11pt, fill: gray)[数据科学与大数据技术]
  #v(0.3cm)
  #text(size: 11pt, fill: gray)[匿名]
]
#pagebreak()

// ===== 目录 =====
#outline(title: [目录], indent: auto, depth: 2)
#pagebreak()

// ===== 各章 =====
#codly(languages: codly-languages)
#include "ch01.typ"
#include "ch02.typ"
#include "ch03.typ"
#include "ch04.typ"
#include "ch05.typ"
#include "ch06.typ"
#include "ch07.typ"
#include "ch08.typ"
