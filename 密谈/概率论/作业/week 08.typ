#import "./homework.typ": config
#import "@preview/physica:0.9.7": dd, dv, pdv

#show: config.with("概率论与数理统计", "第八次作业", "", "匿名", "20XXXXXXXX")

#set table(inset: 10pt, stroke: 0.5pt)

= 习题 3-1

== 1

#image("img/week 08/image-1.png")

不能，有 $(1, 1) - F(1, 0) - F(0, 1) + F(0, 0) < 0$。


== 2

#image("img/week 08/image-2.png")

#figure(table(
  columns: 1 + 4,
  [X\\Y],
  $1$,
  $2$,
  $3$,
  $4$,
  $1$,
  $1/4$,
  $0$,
  $0$,
  $0$,
  $2$,
  $1/8$,
  $1/8$,
  $0$,
  $0$,
  $3$,
  $1/12$,
  $1/12$,
  $1/12$,
  $0$,
  $4$,
  $1/16$,
  $1/16$,
  $1/16$,
  $1/16$,
), caption: "习题 3-1 2")
