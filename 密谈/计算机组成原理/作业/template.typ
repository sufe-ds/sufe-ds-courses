#let conf(
  course_name,
  course_code,
  student_name,
  student_id,
  major,
  assignment,
  doc,
) = {
  set document(
    title: [#course_name #assignment],
    author: student_name,
  )

  set page(
    header: align(center + horizon)[
      #set text(fill: gray)
      #course_name #course_code #h(1fr) #major #student_name #student_id
    ],
    numbering: "1/1",
  )

  set par(
    justify: true,
    // first-line-indent: (all: true, amount: 2em),
  )

  set text(
    lang: "zh",
    size: 11pt,
    font: "LXGW WenKai Mono GB",
  )

  show title: set text(weight: "black", size: 18pt)
  show title: set align(center + top)

  set heading(numbering: "问题 1.1")
  // #show heading: set text(font: "Microsoft YaHei")

  set table(inset: 10pt)

  title()

  doc
}

#let question(content) = [
  #set text(font: "Microsoft YaHei", weight: "thin")
  #set par(justify: false, first-line-indent: 0em)
  #set align(center)

  #box(width: 85%, content)
]

#let interval = line(length: 100%, stroke: gray)
