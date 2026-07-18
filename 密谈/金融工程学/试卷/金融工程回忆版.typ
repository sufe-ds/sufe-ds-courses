#set page(
  paper: "a4",
  margin: 2.5cm,
  footer: context align(center, counter(page).display()),
)

#set text(font: ("New Computer Modern", "Songti SC"), size: 12pt)

#align(center)[#text(size: 20pt, weight: "bold")[上海财经大学 · 金融工程回忆版试卷]]

#v(1em)

= 试题

// ────────────────────────────────────────────────
// 一、Financial Derivatives
// ────────────────────────────────────────────────

= 一、Financial Derivatives

+ What are Financial Derivatives?
+ Silver current price ¥8,000/kg, 1 lot = 15 kg. Silver is a futures contract with leverage ratio 10. If our margin account has ¥300,000, how many lots can we short?
+ We short 5 lots at beginning. After a week, our margin account becomes ¥306,000. What is the current silver futures price?

// ────────────────────────────────────────────────
// 二、Stochastic Calculus
// ────────────────────────────────────────────────

= 二、Stochastic Calculus

+ What is the distribution of $W_1 + W_2 + W_4$?
+ Compute $integral_0^T W_t dif W_t$.
+ Assume

  $ X_t = 3t^2 + W_t^4 + c t W_t^2 $

  prove $X_t$ is a diffusion process.
+ If the drift of $X_t$ is always 0, what is the possible value of $c$?
+ Is geometric Brownian motion a diffusion process? Why?
+ How to convert the BSM to the risk-neutral measure?
+ What is the biggest difference between the Itô integral and ordinary calculus?

// ────────────────────────────────────────────────
// 三、Black-Scholes Model
// ────────────────────────────────────────────────

= 三、Risk-Neutral Pricing

+ What is the Black-Scholes model?
+ Consider an option where we pay ¥1 to its holder at maturity $T$, if and only if $S_T > K$. Write the payoff function of this option.
+ Use Black-Scholes option pricing to price this option.
+ If you hold a long American call option, what is your optimal exercise strategy?

// ════════════════════════════════════════════════════
// Part 2: Answers
// ════════════════════════════════════════════════════

#pagebreak()

= 答案与解析

// ────────────────────────────────────────────────
// 一、Financial Derivatives — Answers
// ────────────────────────────────────────────────

== 一、Financial Derivatives

=== (1) What are Financial Derivatives?

*Answer:*
A financial derivative is a contract whose value derives from an underlying asset (stock, bond, commodity, currency, rate, or index). They are used for hedging, speculation, and arbitrage.

*Types:*
- Forward: OTC agreement to buy/sell at future date at price fixed today
- Futures: Standardized, exchange-traded forward with daily mark-to-market
- Options: Right (not obligation) to buy (call) or sell (put) at strike $K$; European (at $T$) or American (any time)
- Swaps: Exchange cash flows (interest rate, currency, CDS)

*Key characteristics:* leverage, zero-sum (forwards/futures), nonlinear payoffs (options), mark-to-market (futures).

*解析:*
Derivatives are called "derivative" because their price is derived from an underlying asset. They enable risk transfer between counterparties.

=== (2) Silver current price ¥8,000/kg, 1 lot = 15 kg. Silver is a futures contract with leverage ratio 10. If our margin account has ¥300,000, how many lots can we short?

*Answer:* 25 lots.

*解析:*
- Silver is a futures contract with leverage ratio 10, i.e. initial margin $= 1/10 = 10%$
- Notional per lot: $15 times 8000 = ¥120,000$
- Initial margin per lot: $0.10 times ¥120,000 = ¥12,000$ per lot
- Number of lots: $¥300,000 / ¥12,000 = 25$ lots

=== (3) We short 5 lots. After a week, margin account becomes ¥306,000. What is the current silver futures price?

*Answer:* ¥7,920/kg.

*解析:*
- Account gain: $¥306,000 - ¥300,000 = ¥6,000$ (short position profits when price falls)
- Total quantity: $5 times 15 = 75$ kg
- Price drop: $¥6,000 / 75 = ¥80$ per kg
- New price: $¥8,000 - ¥80 = ¥7,920$ per kg

// ────────────────────────────────────────────────
// 二、Stochastic Calculus — Answers
// ────────────────────────────────────────────────

== 二、Stochastic Calculus

=== (1) What is the distribution of $W_1 + W_2 + W_4$?

*Answer:* $W_1 + W_2 + W_4 tilde N(0, 15)$.

*解析:*
Rewrite as independent increments:
$W_1 + W_2 + W_4 = 3W_1 + 2(W_2 - W_1) + (W_4 - W_2)$

Variance:
$
    & 3^2 dot "Var"(W_1) + 2^2 dot "Var"(W_2 - W_1) + 1^2 dot "Var"(W_4 - W_2) \
  = & 9 dot 1 + 4 dot 1 + 1 dot 2 = 15
$

Mean is 0 (all Brownian increments have zero mean).

=== (2) Compute $integral_0^T W_t dif W_t$.

*Answer:* $integral_0^T W_t dif W_t = 1/2 W_T^2 - 1/2 T$.

*解析:*
Let $f(x) = 1/2 x^2$. By Ito's formula:
$
  dif f(W_t) & = f'(W_t) dif W_t + 1/2 f''(W_t) (dif W_t)^2 \
             & = W_t dif W_t + 1/2 dif t
$

So: $W_t dif W_t = dif(1/2 W_t^2) - 1/2 dif t$

Integrate from 0 to T: $integral_0^T W_t dif W_t = 1/2 W_T^2 - 1/2 T$ (since $W_0 = 0$)

The correction term $-T/2$ comes from quadratic variation of Brownian motion.

=== (3) Assume $X_t = 3t^2 + W_t^4 + c t W_t^2$, prove $X_t$ is a diffusion process.

*Answer:* $dif X_t = (4W_t^3 + 2c t W_t) dif W_t + [(6 + c) t + (6 + c) W_t^2] dif t$.

*解析:*
Apply Ito's formula to each term:

- $dif(3t^2) = 6t dif t$
- $dif(W_t^4) = 4W_t^3 dif W_t + 6W_t^2 dif t$ (by Ito with $g(x)=x^4$, $g'=4x^3$, $g''=12x^2$)

For the product term $c t W_t^2$, use the stochastic product rule $dif(U_t V_t) = U_t dif V_t + V_t dif U_t + dif U_t dif V_t$:

Let $U_t = t$, $V_t = W_t^2$.
- $dif U_t = dif t$
- $dif V_t = dif(W_t^2) = 2W_t dif W_t + dif t$ (by Ito with $g(x)=x^2$)

$
  dif(t W_t^2) &= t dif(W_t^2) + W_t^2 dif t + dif t dif(W_t^2) \
               &= t(2W_t dif W_t + dif t) + W_t^2 dif t \
               &= 2t W_t dif W_t + (t + W_t^2) dif t
$

So: $dif(c t W_t^2) = 2c t W_t dif W_t + c(t + W_t^2) dif t$

Combining all three components:
$
  dif X_t &= 6t dif t + [4W_t^3 dif W_t + 6W_t^2 dif t] + [2c t W_t dif W_t + c(t + W_t^2) dif t] \
          &= (4W_t^3 + 2c t W_t) dif W_t + [6t + 6W_t^2 + c t + c W_t^2] dif t \
          &= (4W_t^3 + 2c t W_t) dif W_t + [(6 + c)t + (6 + c)W_t^2] dif t
$

$
  dif X_t = underbrace((4W_t^3 + 2c t W_t), sigma(t,W_t)) dif W_t + underbrace([(6 + c)t + (6 + c)W_t^2], mu(t,W_t)) dif t
$

This is in SDE form $dif X_t = mu dif t + sigma dif W_t$, so $X_t$ is an Ito process / diffusion process.

=== (4) If the drift of $X_t$ is always 0, what is the possible value of $c$?

*Answer:* $c = -6$.

*解析:*
From (3), the drift is: $mu = (6 + c)t + (6 + c)W_t^2 = (6 + c)(t + W_t^2)$.

For drift $equiv 0$, we need $(6 + c)(t + W_t^2) = 0$ for all $t$ and all $W_t$.

Since $t + W_t^2$ is not identically zero, we must have $6 + c = 0$.

Therefore: $c = -6$.

When $c = -6$, the drift vanishes completely: $(6 + (-6))(t + W_t^2) = 0 (t + W_t^2) = 0$.
The diffusion process becomes a pure martingale: $dif X_t = (4W_t^3 - 12t W_t) dif W_t$.

=== (5) Is geometric Brownian motion a diffusion process? Why?

*Answer:* Yes. Geometric Brownian motion (GBM) is a special case of a diffusion process.

*解析:*
The SDE form of GBM
$ d S_t = mu S_t dif t + sigma S_t dif W_t $
fully conforms to the general definition of a diffusion process
$ d X_t = mu(t, X_t) dif t + sigma(t, X_t) dif W_t $
where the drift coefficient $mu(t, x) = mu x$ and the diffusion coefficient $sigma(t, x) = sigma x$ are both continuous functions of $t$ and $x$.

- The drift coefficient $mu(t, x) = mu x$ and diffusion coefficient $sigma(t, x) = sigma x$ satisfy the *linear growth condition* $|mu(x,t)| + |sigma(x,t)| <= C(1+|x|)$ and the *Lipschitz condition* $|mu(x,t) - mu(y,t)| + |sigma(x,t) - sigma(y,t)| <= D|x-y|$, guaranteeing existence and uniqueness of a strong solution to the SDE.
- By Itô's lemma, starting from the explicit solution $S_t = S_0 exp((mu - sigma^2 / 2)t + sigma W_t)$, one can verify it satisfies the above SDE.
- The diffusion property of GBM guarantees the *Markov property* and *continuity* (continuous sample paths) of the asset price process, which is the theoretical foundation for pricing derivatives via PDEs (Feynman-Kac theorem) and the martingale pricing method.

*课件参考:* Chapter 2, Slides 46–47 (definition of diffusion process and SDE), Slide 49 (SDE of BSM and GBM), Slide 52 (examples of diffusion processes).

=== (6) How to convert the BSM to the risk-neutral measure?

*Answer:* Via a change of measure using the Girsanov theorem. Define the market price of risk $theta = (mu - r) / sigma$ and construct a new Brownian motion $dif tilde(W)_t = dif W_t + theta dif t$. Under the risk-neutral measure $ℚ$, the BSM SDE becomes $d S_t = r S_t dif t + sigma S_t dif tilde(W)_t$, and the discounted asset price $e^(-r t) S_t$ becomes a martingale.

*解析:*
The BSM SDE under the real-world measure is
$ d S_t = mu S_t dif t + sigma S_t dif W_t $

By the *Girsanov theorem*, take the constant market price of risk
$ theta = (mu - r) / sigma $
and define the Radon-Nikodym derivative process
$ Z(t) = exp(integral_0^t theta dif W_s - 1/2 integral_0^t theta^2 dif s), quad (d ℚ)/(d ℙ) = Z(t) $
Then $tilde(W)_t = W_t + theta t$ is a standard Brownian motion under $ℚ$.

Substituting $dif W_t = dif tilde(W)_t - theta dif t$ into the BSM SDE:
$
  d S_t &= mu S_t dif t + sigma S_t (dif tilde(W)_t - (mu - r)/sigma dif t) \
       &= r S_t dif t + sigma S_t dif tilde(W)_t
$
The drift changes from $mu S_t$ to $r S_t$.

*Economic intuition:*
- Under $ℚ$, the expected return of all assets equals the risk-free rate $r$.
- The discounted price process $e^(-r t) S_t$ is a martingale under $ℚ$: $E^ℚ[e^(-r T) S_T | cal(F)_t] = e^(-r t) S_t$.
- Risk-neutral pricing formula: $V_t = e^(-r(T-t)) E^ℚ[V_T | cal(F)_t]$.
- The real-world expected return $mu$ *completely disappears* from the pricing formula — consistent with the fact that the real probability $p$ does not appear in the binomial tree pricing formula.

*课件参考:* Chapter 2, Slide 67 (Girsanov theorem), Slide 69 (change of measure for BSM and market price of risk), Slide 73 (martingale pricing principle of risk-neutral pricing).

=== (7) What is the biggest difference between the Itô integral and ordinary calculus?

*Answer:* The biggest difference is that the quadratic variation of Brownian motion is non-zero. In ordinary calculus $(dif x)^2$ is negligible, but in stochastic calculus $(dif W_t)^2 = dif t$, so the second-order term is of the same order as the first-order infinitesimal and cannot be neglected. This leads to an additional second-order correction term $1/2 f''(X_t) dif[X, X]_t$ in Itô's lemma.

*解析:*
- *Quadratic variation of Brownian motion:* $[W, W]_t = t$, i.e. $(dif W_t)^2 = dif t$. This means $(dif W_t)^2$ is of order $dif t$, not $o(dif t)$.
- *Chain rule in ordinary calculus:* For a smooth function $x(t)$, $d f(x(t)) = f'(x(t)) dif x(t)$, because $(dif x)^2$ is a higher-order infinitesimal that can be discarded in the Taylor expansion.
- *Itô's lemma:* For a diffusion process $X_t$, since $dif[X, X]_t = sigma^2(X_t, t) dif t$,
$ dif f(X_t) = f'(X_t) dif X_t + 1/2 f''(X_t) dif[X, X]_t $
The second-order correction term $1/2 f''(X_t) dif[X, X]_t$ is the core feature distinguishing Itô calculus from ordinary calculus.

*Other key differences:*
- *Left-endpoint evaluation:* The Itô integral $integral_0^T X_s dif W_s = lim sum X_(t_(j-1)) (W_(t_j) - W_(t_(j-1)))$ evaluates the integrand at the left endpoint of each interval, ensuring non-anticipating (adapted) integrands. In the Riemann integral, the sampling point can be chosen arbitrarily.
- *Martingale property:* The Itô integral $integral_0^t X_s dif W_s$ is a martingale, which is crucial for risk-neutral pricing.
- *Itô isometry:* $E[(integral_0^t X_s dif W_s)^2] = E[integral_0^t X_s^2 dif s]$, which has no counterpart in ordinary integration.
- *Pathwise meaning:* Brownian motion sample paths are nowhere differentiable and have unbounded variation, so the Itô integral cannot be defined pathwise and must rely on probabilistic limits in the $L^2$ space.

*课件参考:* Chapter 2, Slides 31–35 (non-differentiability, unbounded variation, bounded quadratic variation of Brownian motion), Slide 42 (left-endpoint definition of the Itô integral), Slide 44 (martingale property and Itô isometry), Slide 48 (Itô's lemma and the second-order correction term).

// ────────────────────────────────────────────────
// 三、Risk-Neutral Pricing — Answers
// ────────────────────────────────────────────────

== 三、Risk-Neutral Pricing

=== (1) What is the Black-Scholes model?

*Answer:*
The Black-Scholes (Black-Scholes-Merton) model is a mathematical framework for pricing European options based on no-arbitrage principles.

*SDE under risk-neutral measure ℚ:* $dif S_t = r S_t dif t + sigma S_t dif tilde(W)_t$.

*Key assumptions:* no arbitrage, continuous trading, constant volatility $sigma$ and risk-free rate $r$, no dividends, European exercise, log-normal prices, perfect markets.

*BS PDE:*
$ (partial V)/(partial t) + 1/2 sigma^2 S^2 (partial^2 V)/(partial S^2) + r S (partial V)/(partial S) - r V = 0 $

*European Call formula:* $C = S_0 N(d_1) - K e^(-r T) N(d_2)$
*European Put formula:* $P = K e^(-r T) N(-d_2) - S_0 N(-d_1)$

where:
$d_1 = (ln(S_0/K) + (r + sigma^2/2)T) / (sigma sqrt(T))$
$d_2 = d_1 - sigma sqrt(T)$

*解析:*
The model was developed by Fischer Black, Myron Scholes, and Robert Merton (1997 Nobel Prize). It assumes log-normal stock prices and complete markets, enabling replication and no-arbitrage pricing.

=== (2) Payoff function for ¥1 if $S_T > K$ at maturity $T$.

*Answer:*
This is a cash-or-nothing binary call option.

$Phi(S_T) = bold(1)_({S_T > K}) = cases(1\, "if" S_T > K, 0\, "if" S_T <= K)$

=== (3) Use Black-Scholes option pricing to price this option.

*Answer:* $V_0 = e^(-r T) N(d_2)$.

*解析:*
Under ℚ: $dif S_t = r S_t dif t + sigma S_t dif tilde(W)_t$

Solving: $S_T = S_0 exp((r - sigma^2/2)T + sigma tilde(W)_T)$

Risk-neutral pricing:
$V_0 = e^(-r T) E_ℚ[bold(1)_({S_T > K})] = e^(-r T) ℚ(S_T > K)$

$
  ℚ(S_T > K) & = ℚ(ln(S_T/S_0) > ln(K/S_0)) \
             & = ℚ( (ln(S_0/K) + (r - sigma^2/2)T) / (sigma sqrt(T)) > -Z ) quad "where" Z tilde N(0,1) \
             & = N( (ln(S_0/K) + (r - sigma^2/2)T) / (sigma sqrt(T)) ) = N(d_2)
$

Therefore: $V_0 = e^(-r T) N(d_2)$.

Each ¥1 payout is discounted at $e^(-r T)$ and multiplied by the risk-neutral probability $N(d_2)$ that the option finishes in-the-money.

=== (4) If you hold a long American call option, what is your optimal exercise strategy?

*Answer:* Hold to maturity, never exercise early (assuming the underlying asset pays no dividends).

*解析:*
Courseware theorem (Slide 79): *American call option and European call option (with the same parameters) have the same price, if there is no dividend.* That is, without dividends, the optimal exercise strategy for an American call is not to exercise (hold to maturity).

Reasons:
+ *Positive time value:* For any $t < T$, the market price of an American call strictly exceeds its intrinsic value: $C^("Am")(S_t, t) > (S_t - K)^+ $. Early exercise yields only the intrinsic value, forfeiting all time value.
+ *The option acts as "insurance":* Holding a call offers unlimited upside while limiting downside risk to the premium; early exercise exposes the holder directly to the underlying's price risk.
+ *Interest benefit of delayed payment:* Early exercise pays $K$ at time $t$, while holding to maturity pays $K$ at time $T$. Delaying payment earns risk-free interest $K(1 - e^(-r(T-t))) > 0$.
+ *Price lower bound inequality:* $C^("Am")(S_t, t) >= C^("Eur")(S_t, t) >= S_t - K e^(-r(T-t)) > S_t - K$ holds for all $t < T$. Selling the option in the market is always superior to exercising.

*Exception:* When the underlying pays dividends, early exercise immediately before the ex-dividend date may be optimal (exercising captures the dividend but forfeits remaining time value). At all other times, holding remains optimal.

*Contrast:* For an American put, even without dividends, early exercise may be optimal (when $S_t$ is sufficiently low, the interest on $K$ may exceed the time value), requiring optimal stopping theory to determine the optimal exercise boundary.

*课件参考:* Chapter 2, Slide 79 (equivalence theorem of American and European calls), Slide 57 (intrinsic value and time value), Slide 76 (Put-Call Parity), Slides 78–80 (optimal stopping and American put exercise boundary).
