#import "@preview/touying:0.6.1": *
#import themes.stargazer: *

#import "@preview/numbly:0.1.0": numbly

// #import "@preview/codly:1.3.0": *
// #import "@preview/codly-languages:0.1.1": *

// #show: codly-init.with()

// #codly(languages: codly-languages)

#set text(lang: "zh")
#set raw(block: true)

#show: stargazer-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [PatchTST: 64 Words],
    subtitle: [],
    author: [第三组 匿名（数据科学与大数据技术）同学X（匿名）],
    date: datetime(year: 2025, month: 12, day: 18),
    institution: [SUFE SIME],
    logo: emoji.ABCD,
  ),
)

#set heading(numbering: numbly("{1}.", default: "1.1"))

#title-slide()

#outline-slide()

= 关于论文

== PatchTST

#align(center + horizon)[
  #tblock(title: [ICLR 2023])[
    A Time Series is Worth 64 Words: Long-term Forecasting with Transformers
  ]

  Yuqi Nie#super[_1_ 1], Nam H. Nguyen#super[_2_], Phanwadee Sinthong#super[_2_], Jayant Kalagnanam#super[_2_]

  #super[_1_] Princeton University, #super[_2_] IBM Research

  _Equal contribution._

]

一个时间序列 #sym.arrow 64 个 Patch

ViT/JiT: An Image is Worth 16x16 Words

== 背景与动机

=== 背景

- Transformer 在 NLP、 CV 领域取得巨大成功
- 时间序列预测是重要研究方向
- 现有 Transformer 模型（Informer、Autoformer、FEDformer）设计复杂

=== 挑战
- DLinear（简单线性模型）超越复杂 Transformer
- 质疑 Transformer 对时序预测的有效性

#focus-slide[Transformer 是否真的适用于时间序列预测？]

=== 本文贡献

- 提出 PatchTST 模型
- 证明 Transformer 在时序预测中的有效性
- 在监督学习和自监督学习中均达到 *SOTA*

= 核心 Idea

== Channel Independence

#figure(image("assets/image-2.png"), caption: [PatchTST 模型总览])

不含 CI 则需要进行通道混合，分块信息和通道信息会混合在一起，且容易过拟合。

#tblock(title: "关键洞察")[
  CI 已在 CNN 和线性模型中证明有效，但首次应用于 Transformer！
]

== Patching & Instance Norm

#grid(
  columns: (2fr, 3fr),
  figure(image("assets/image-3.png"), caption: [PatchTST backbone]),
  [
    + 一个时间序列 #h(1fr) $x^(i) in RR^(1 times L)$
    + Instance Norm + 分块（重复末尾）#h(1fr) $x_p^(i) in RR^(P times N)$
    + 线性 + 位置嵌入（加性可学习）#h(1fr) $x_d^(i) in RR^(D times N)$
    + vanilla Transformer encoder #h(1fr) $z^(i) in RR^(D times N)$
    + 线性头 #h(1fr) $hat(x)^(i) in RR^(1 times T)$
  ],
)

= 实验

== 实验设置与数据

=== 数据集

- 大型数据集：时间序列数量较多，结果更稳定，不易过拟合。
  - Weather (21 个特征)
  - Traffic (862 个特征)
  - Electricity (321 个特征)
- 其他数据集：
  - ILI（流感样疾病比率）
  - ETT 数据集（ETTh1, ETTh2, ETTm1, ETTm2）。

#pagebreak()

=== 基线模型

- Transformer 模型：FEDformer、Autoformer、Informer、Pyraformer、LogTrans。
  - 其中，为了避免低估基线模型，重新运行了 FEDformer、Autoformer 和 Informer
  - 尝试了六种不同的回顾窗口长度 $L in {24, 48, 96, 192, 336, 720}$
  - 为每个预测任务选取了最佳结果作为强基线进行对比。
- 非 Transformer 模型：DLinear

#pagebreak()

=== 模型变体和参数

- 提出了两个 PatchTST 版本，用于不同的实验设置。
  - PatchTST/42：输入分块数为 42，默认回顾窗口长度 $L=336$。
  - PatchTST/64：输入分块数为 64，回顾窗口长度 $L=512$。
- 两者都使用分块长度 $P=16$ 和步长 $S=8$。
- 参数配置： 默认配置包含 3 个编码器层，头数 $H=16$，潜在空间维度 $D=128$。
  - 对于较小的数据集，则采用更少的参数以减轻过拟合（如 $H=4, D=16$）。
- 评估指标： MSE、MAE

== 结果

=== 监督

- PatchTST/64 和 PatchTST/42 均优于所有基线方法
- 对比表现最佳的 Transformer 模型
  - PatchTST/64 在 MSE 上平均降低了 21.0%，在 MAE 上平均降低了 16.7%
- 对比 DLinear
  - PatchTST 总体上优于 DLinear
  - 尤其在大型数据集（Weather, Traffic, Electricity）上优势显著

#figure(image("assets/image-9.png"), caption: [监督学习实验结果])

#pagebreak()

=== 长回顾窗口

#grid(
  columns: (1fr, 1fr),
  [

    - 实验证明，随着回顾窗口长度 $L$ 的增加，PatchTST 的 MSE 评分一致地降低
      - 例如，在 Traffic 数据集上，将 $L$ 从 96 增加到 336，MSE 从 0.518 降至 0.397
    - 这证实了模型能够有效地从更长的历史信息中学习。
    - 相比之下，大多数基线 Transformer 模型并未从更长的 $L$ 中获益。
  ],
  figure(image("assets/image-7.png"), caption: [不同模型、不同回顾窗口的预测效果]),
)


#pagebreak()

=== 子监督表征学习

#tblock(title: "MAE")[*Masked Autoencoder*]

- 预训练设置
  - 采用非重叠分块，输入序列长度 $L=512$，分块大小 $P=12$，产生 42 个分块
  - 采用 40% 的高掩码比例。
- 评估策略
  - 线性探测（Linear Probing）： 冻结网络主体，仅训练顶部的线性预测头
  - 端到端微调（End-to-End Fine-tuning）： 先线性探测后对整个网络微调

#pagebreak()

- 在大型数据集上，自监督预训练显著提高了性能。
  - 在 Traffic 数据集上
    - 自监督模型通过端到端微调达到了最佳的 0.349 MSE
    - 仅使用线性探测
      - 预测性能就已与从头开始训练整个网络的结果相当
      - 优于 DLinear。
- 与其他自监督方法的对比
  - 在 ETTh1 数据集上
    - PatchTST 在预测性能上大幅优于其他 SOTA 对比学习表示方法
    - MSE 提升幅度在 34.5% 至 48.8% 之间。

#figure(image("assets/image-10.png"), caption: [自监督实验结果])

#pagebreak()

=== 迁移

- 模型在 Electricity 数据集上预训练
- 然后迁移到其他数据集（如 Weather 和 Traffic）上进行微调
- 尽管在跨数据集迁移时，微调性能略低于在同一数据集上预训练
- 但在预测准确率方面，迁移学习的 PatchTST 表现仍然优于所有其他基线模型

#figure(image("assets/image-11.png", height: 150pt), caption: [迁移实验结果])

== 消融实验

=== Patching & Channel Independence

消融实验证实了 Patching 和 CI 是 PatchTST 成功的两个重要因素。

- P + CI： 实现了最佳性能
- 仅 CI： 性能下降
  - 在大型数据集上，由于 $L$ 值较大，模型经常遇到 GPU 内存不足的问题。
- 仅 P： 性能不如
- 无 P 无 CI： 性能最差

*计算优势*：Patching 通过减少输入标记数量 $N approx L/S$，将计算和内存复杂度二次降低，从而使训练时间大幅缩短（在 Traffic 数据集上，训练时间减少了 22 倍）。

#figure(image("assets/image-8.png"), caption: [消融实验结果])

#pagebreak()

=== Attention Map

#grid(
  columns: (2fr, 3fr),
  figure(image("assets/image-6.png", width: 200pt), caption: [Attention Map 与 预测结果]),
  [
    - 每个时间序列学习自己的 Attention Pattern
      - 相似的序列产生相似的 Attention Map
      - 不同行为的序列有不同的 Attention Pattern
    - 优势
      - 适应性：每个序列有独立 Attention
      - 收敛快：需要更少的训练数据
      - 不易过拟合：模型更稳健
  ],
)

#pagebreak()

=== Instance Norm

- Instance Norm*略微提高*了预测性能。
- 即使*不使用*Instance Norm，PatchTST 仍优于其他 Transformer 方法，这表明性能提升主要源于 Patching 和 CI 设计。

#pagebreak()

=== 超参数的稳健性

- 分块长度 $P$： 在 $L=336$ 时改变 $P$，MSE 评分变化不显著，表明模型对分块长度超参数具有稳健性。
  - 最佳 $P$ 值通常在 $[8, 16]$ 之间。
- 随机种子：在不同的随机种子下（2019 到 2023），有监督和自监督 PatchTST 的结果方差都非常小，表明模型的稳健性高，特别是在大型数据集上。

= 分析

== MLP？

#grid(
  columns: (3fr, 2fr),
  [
    我认为PatchTST主要性能提升在于变量独立和Patch操作。PatchTST的输入长度为336，可能不需要捕捉变量间的关系？只依据自己的历史数据就能很好的预测了。

    我对PatchTST的消融实验结果如下，在将Transformer encoder替换为MLP之后，在除了Traffic之外的数据集上的性能基本持平。感兴趣的朋友可以自己尝试一下消融实验。

    - 作者：Aikwed
    - 链接：https://zhuanlan.zhihu.com/p/30166651655
  ],
  figure(image("assets/image-4.png"), caption: [对Transformer的消融实验结果]),
)

== Convolution?

PatchTST 上的 Patching + 自注意力 可以被视为一种更先进的卷积。

- *注意力机制的本质*：自注意力机制的本质是一种搜索匹配机制，即通过查询（Query）去搜索特定的键（Key）。
- *分块*：当采用 Patching 后，注意力机制不再是点对点的搜索，而是转变为序列（块）与序列（块）之间的匹配搜索问题。
- *类比卷积*： 这种序列块的匹配搜索，其本质与卷积的原理高度一致：卷积通过学习卷积核，在感受野内搜索特定的模式。

这是因为注意力机制通常比标准卷积具有更大的参数量和更强的拟合能力，使其能更好地学习如何搜索和利用对降低损失最有帮助的感受野模式。

= 代码

== 监督

=== 主体

```python
class PatchTST_backbone(nn.Module):
    def forward(self, z):
        if self.revin:
            z=self.revin_layer(z.permute(0,2,1),"norm").permute(0,2,1)
        if self.padding_patch == "end":
            z = self.padding_patch_layer(z)
        z = z.unfold(
            dimension=-1,size=self.patch_len,step=self.stride
        ).permute(0,1,3,2)
        z = self.head(self.backbone(z))
        if self.revin:
            z=self.revin_layer(z.permute(0,2,1),"denorm").permute(0,2,1)
        return z
```
#pagebreak()

=== Channel Independence

```py
class Flatten_Head(nn.Module):
    def forward(self, x):
        if self.individual:
            x_out = []
            for i in range(self.n_vars):
                z = self.flattens[i](x[:, i, :, :])
                z = self.linears[i](z)
                z = self.dropouts[i](z)
                x_out.append(z)
            x = torch.stack(x_out, dim=1)
        else:
            ...
        return x

```

== 无监督 & 迁移

```python
class PatchMaskCB(Callback):
    def patch_masking(self):
        xb_patch, num_patch = create_patch(
            self.xb, self.patch_len, self.stride
        )  # xb_patch: [bs x num_patch x n_vars x patch_len]
        xb_mask, _, self.mask, _ = random_masking(
            xb_patch, self.mask_ratio
        )  # xb_mask: [bs x num_patch x n_vars x patch_len]
        self.mask = self.mask.bool()  # mask: [bs x num_patch x n_vars]
        self.learner.xb = xb_mask  # learner.xb: masked 4D tensor
        self.learner.yb = xb_patch  # learner.yb: non-masked 4d tensor
```

#pagebreak()

```python
class PatchTST(nn.Module):
    def __init__(...):
        ...
        if head_type == "pretrain":
            self.head=PretrainHead(d_model, patch_len, head_dropout)
        elif head_type == "prediction":
            self.head=PredictionHead(...)
        elif head_type=="regression":
            self.head=RegressionHead(...)
        elif head_type == "classification":
            self.head=ClassificationHead(...)
```

= 反思

== PatchTST

- 核心优势
  - CI 与 Patching 显著降低计算量，同时保持预测精度。
  - 自监督预训练（高掩码比例 + 线性探测/微调）在大规模数据集上带来稳定收益，迁移学习表现也优于传统基线。
  - 模型对超参数（分块长度、随机种子）表现稳健，为后续实验与复现实践提供了信心。
// - 局限性
//   - 忽略跨通道相关性
//     - 结合图神经网络建模通道关系

== 机器学习 & 科研

#grid(
  columns: (2fr, 5fr),
  [
    - 做 $>$ 想
    - AI 太好用了
      - Notebooklm
      - Github Copilot
  ],
  figure(image("assets/image-5.png"), caption: [PatchTST 信息图，使用 Notebooklm 制作]),
)


