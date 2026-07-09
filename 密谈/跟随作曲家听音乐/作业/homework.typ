#let config(course, subject, date, name, id, doc) = {
  set page(paper: "a4", margin: (top: 3.7cm, bottom: 3.5cm, inside: 2.8cm, outside: 2.6cm), header: [
    #name #id #h(1fr) #date #course #subject
    #line(length: 100%)
  ], numbering: "1 / 1")

  // show heading.where(level: 1): it => block(width: 100%, height: 2em, inset: 0.5em, radius: 0.5em, stroke: black)[
  //   #set align(center + horizon)
  //   #set text(15pt, weight: "extrabold")
  //   #it.body
  // ]

  show heading.where(level: 1): it => align(center)[
    #pad(top: 0pt, bottom: -10pt, [#smallcaps(it.body)])
    #line(length: 95%, stroke: 1pt)
  ]

  show heading.where(level: 2): it => block(width: 100%, height: 2em, inset: 0.5em, radius: 0.5em, fill: luma(225))[
    #set align(left + horizon)
    #set text(13pt, weight: "bold")
    #it.body
  ]

  show heading.where(level: 3): it => block(width: 100%, height: 2em, inset: 0.5em, radius: 0.5em, fill: luma(240))[
    #set text(13pt, weight: "regular")
    #it.body
  ]

  set text(font: ("New Computer Modern", "LXGW WenKai GB"), lang: "zh")

  set par(justify: true, leading: 0.75em)

  doc
}
