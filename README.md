# collision-quantile

**Matlab code for the paper "Distributed remote estimation over the collisionchannel with and without local communication"
**

## Functions

* **Fig_4_Robustness_threshold.m**: Monte-Carlo Simulation for robustness with respect to the disturbances on the mean
* **Fig_5_Average_consensus_based_decentralized_scheme.m**: The empirical performance of average consensus based scheme as a function of time
* **Fig_6_Quantile_estimation_decentralized_scheme.m**`: The empirical performance of quantile estimation decentralized scheme as a function of time
* **Fig_7_Lipschitz_plot.m**: Optimal threshold  and its derivative as functions of the variance
* **Fig_8_Fast_quantile_estimation_decentralized_schem.m**: The empirical performance of fast quantile estimation decentralized scheme as a function of time
* **Table_I_Search_interval.m**: Search interval for Gaussian observations
* **Table_II_Switching_time.m**: Switching-time for different values delta

## Auxiliary functions

* **random_graph.m**: generate random geometric graph
* **laprnd.m**: generate i.i.d. laplacian random variables
* **threshold_symmetric.m**: cost function as a function of the threshold T
* **func_upperbound.m**: function in Lemma 4
* **qinv.m**: get the inverse function of the threshold T
* **func.m**

## Data

* **graph_n.mat**: random graph with n nodes
* **threshold_gaussian_n_k.mat**:
