# RobustDecisionProgramming.jl
## Overview
*Robust Decision Programming* extends [*Decision Programming*](https://gamma-opt.github.io/DecisionProgramming.jl/dev/) with robust optimization. We recommend becoming familiar with Decision Programming and its documentation, especially [*Influence Diagram*](https://gamma-opt.github.io/DecisionProgramming.jl/dev/decision-programming/influence-diagram/) and [*Decision Model*](https://gamma-opt.github.io/DecisionProgramming.jl/dev/decision-programming/decision-model/) sections, as we build upon its terminology and concepts in Robust Decision Programming. For an overview of different robust optimization models, we recommend the paper *Recent advances in robust optimization* [^1]. As a general reference for fundamental mathematical concepts and notation such as propositional logic and sets, we recommend the book *Logic and Proof* [^2]. For model building using convex optimization, we recommend *MOSEK Modeling Cookbook* [^3].

We can add robustness to Decision Programming either by making *Path Utilities* robust against uncertainty in the *Consequences* on  *Value Nodes* or by making *Path Probabilities* robust against uncertainty in the *Probabilities* on *Chance Nodes*. We focus on the latter approach to provide decision-makers tools to protect against uncertainty when estimating probabilities, which are difficult to know accurately in practice. We refer to the approach as **distributional robustness**.

## Distributional Robustness
Distributional robustness represents models that are robust against a pre-defined amount of uncertainty in the *Probabilities*. Instead of defining a single probability distribution, distributional robustness defines a set of probability distributions around the given distribution known as the **uncertainty set**. We can form the uncertainty set by allowing decision-makers to define an **upper** and **lower bound** to each probability instead of an individual value and to define an **uncertainty radius** which limits the possible distributions to ones that are within the given *Wasserstein distance* from the original probability distribution.  

Then, we can approach distributional robustness by optimizing the [**Best Worst-Case Expected Value**](@ref best-worst-case-expected-value) over a model with uncertainty sets. We have formulated the best-worst case in two steps. In the first step, the objective is to maximize the minimum expected value over the uncertainty sets. In the second step, we maximize the expected value with *Probabilities* fixed to the minimizing ones from the first step.

We can define an *Uncertainty Set* for each probability distribution in a *Chance node* to form **robust chance node**. Then, by applying the *Best Worst-Case Expected Value* objective to a *Decision Model* with robust chance nodes form the [**Distributionally Robust Decision Model**](@ref distributionally-robust-decision-model). The main challenge along with correctness is to create a tractable model. The computational complexity of these models depends on the number of robust chance nodes and how many *States* each node has. We can denote the set of robust chance nodes as a subset of chance nodes, formally $\hat{C}⊆C.$ Each robust chance node $i∈\hat{C}$ creates a number of path probability variables that is bounded by the factorial of the number states, formally $O(|S_i|!).$ The total number of path probability variables, which are linear variables and constraints, grows to the product of the factorials

$$O\big(∏_{i∈\hat{C}} |S_i|!\big).$$

However, the constant in factorial bound is less than one and in certain special cases, the bound is polynomial, which makes the distributionally robust model tractable when the number of states is reasonably small. Due to the complexity, we restrict our *Distributionally Robust Decision Model* to only **one** robust chance node, that is $|\hat{C}|=1.$

For example, we applied robust decision programming to the [N-monitoring](https://gamma-opt.github.io/DecisionProgramming.jl/dev/examples/n-monitoring/) example from decision programming such that we made the failure node robust.

Generalizing the model and finding tractable formulations for models with multiple robust chance nodes or a larger number of chance states is left for future research.


## References
[^1]: Gabrel, V., Murat, C., & Thiele, A. (2014). Recent advances in robust optimization: An overview. European Journal of Operational Research, 235(3), 471–483. [https://doi.org/10.1016/j.ejor.2013.09.036](https://doi.org/10.1016/j.ejor.2013.09.036)

[^2]: Avigad, J., Lewis, R., & van Doorn, F. (2020). Logic and Proof. Retrieved from [https://leanprover.github.io/logic\_and\_proof/](https://leanprover.github.io/logic_and_proof/)

[^3]: MOSEK. (2020). MOSEK Modeling Cookbook. Retrieved from [https://docs.mosek.com/modeling-cookbook/index.html](https://docs.mosek.com/modeling-cookbook/index.html)
