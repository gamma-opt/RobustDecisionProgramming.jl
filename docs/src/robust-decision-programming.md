# Robust Decision Programming
## Difference
Difference vector is

$$\{d(X_i=s_i∣X_{I(i)}=s_{I(i)})∣s_i∈S_i\}=𝐝(s_{I(i)})∈Δ(s_{I(i)})$$

$$\{𝐝({s_{I(i)}})∣s_{I(i)}∈S_{I(i)}\}=𝐝(S_{I(i)})∈Δ^{×}(S_{I(i)})=∏_{s_{I(i)}∈S_{I(i)}}Δ(s_{I(i)})$$


## Path Probability
Uncertainty in chance node $i∈C$

$$\begin{aligned}
ℙ_d(X_i=𝐬_i∣X_{I(i)}=𝐬_{I(i)}) =
& ℙ(X_i=𝐬_i∣X_{I(i)}=𝐬_{I(i)}) + \\
& d(X_i=𝐬_i∣X_{I(i)}=𝐬_{I(i)})
\end{aligned}$$

Upper bound of path probability with uncertainty

$$p_{d,i}(𝐬)= ℙ_d(X_i=𝐬_i∣X_{I(i)}=𝐬_{I(i)})⋅∏_{j∈C∖i} ℙ(X_j=𝐬_j∣X_{I(j)}=𝐬_{I(j)})$$

Path probability with uncertainty

$$ℙ_{d,i}(X=𝐬∣Z)=p_{d,i}(𝐬)⋅q(𝐬∣Z)$$


## Expected Value
Expected value with uncertainty

$$𝔼_{𝐝(S_{I(i)})}(Z)= ∑_{𝐬∈𝐒} ℙ_{𝐝(𝐬_i∣𝐬_{I(i)})}(X=𝐬∣Z)⋅\mathcal{U}(𝐬)$$


## Maximin
Maximizing the minimum expected value with one uncertain chance node $i∈C.$

$$\underset{Z∈ℤ}{\text{maximize}} \min_{𝐝(S_{I(i)})∈Δ^{×}(S_{I(i)})} 𝔼_{𝐝(S_{I(i)})}(Z)$$

---

Linearization of the problem

$$\underset{Z∈ℤ}{\text{maximize}} ∑_{s_{I(i)}∈S_{I(i)}} x_{s_{I(i)}}$$

$$x_{s_{I(i)}} ≤ ∑_{𝐬∈𝐒,\, 𝐬_{I(i)}=s_{I(i)}} π_d(𝐬)⋅\mathcal{U}(𝐬),\quad ∀d(s_{I(i)})∈Δ(s_{I(i)}),\, s_{I(i)}∈S_{I(i)}$$

$$π_d(𝐬)↔ℙ_{d_i}(X=𝐬∣Z)$$
