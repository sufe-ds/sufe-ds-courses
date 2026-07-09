// util.typ - 统一的定理环境定义
// 所有章节通过 #import "util.typ": * 引入

// 定理计数器（每章独立）
#let thm-counter = counter("theorem")

// 定理环境
#let theorem(body, name: none) = {
  thm-counter.step()
  context {
    let num = thm-counter.get().first()
    block(
      width: 100%,
      inset: 8pt,
      stroke: (left: 3pt + rgb("2563eb")),
      fill: rgb("eff6ff"),
      radius: 3pt,
      [
        *定理 #num.* #if name != none [_（#name）_] \
        #body
      ],
    )
  }
}

// 定义环境
#let definition(body, name: none) = {
  thm-counter.step()
  context {
    let num = thm-counter.get().first()
    block(
      width: 100%,
      inset: 8pt,
      stroke: (left: 3pt + rgb("059669")),
      fill: rgb("ecfdf5"),
      radius: 3pt,
      [
        *定义 #num.* #if name != none [_（#name）_] \
        #body
      ],
    )
  }
}

// 引理环境
#let lemma(body, name: none) = {
  thm-counter.step()
  context {
    let num = thm-counter.get().first()
    block(
      width: 100%,
      inset: 8pt,
      stroke: (left: 3pt + rgb("7c3aed")),
      fill: rgb("f5f3ff"),
      radius: 3pt,
      [
        *引理 #num.* #if name != none [_（#name）_] \
        #body
      ],
    )
  }
}

// 推论环境
#let corollary(body, name: none) = {
  thm-counter.step()
  context {
    let num = thm-counter.get().first()
    block(
      width: 100%,
      inset: 8pt,
      stroke: (left: 3pt + rgb("d97706")),
      fill: rgb("fffbeb"),
      radius: 3pt,
      [
        *推论 #num.* #if name != none [_（#name）_] \
        #body
      ],
    )
  }
}

// 证明环境
#let proof(body) = block(
  width: 100%,
  inset: 8pt,
  stroke: (left: 2pt + rgb("a3a3a3")),
  radius: 3pt,
  [
    _证明._ #body $square$
  ],
)

// 断言环境
#let claim(body) = block(
  width: 100%,
  inset: 4pt,
  [
    *断言.* #body
  ],
)
