# EDIAM - Model Calibration and Scenario Design
This repository contains all necessary files to run the EDIAM model

About the Model

This repository contains results from a calibration exercise using the Exploratory Dynamic Integrated Assessment Model (EDIAM) developed by Edmundo Molina-Pérez and collaborators. The model is designed to explore climate policy under deep uncertainty, incorporating heterogeneous regions, technological change, and non-linear climate damages.

EDIAM builds on the foundational work of integrated assessment modeling  while explicitly incorporating exploratory scenarios and Robust Decision Making (RDM) principles, as described in:

- Molina-Pérez, E., Keenan, J. M., & Lempert, R. J. (2020). A dynamic exploratory model for climate policy design under uncertainty. Environmental Modelling & Software, 131, 104778.
- Acemoglu, D., Aghion, P., Bursztyn, L., & Hemous, D. (2012). The Environment and Directed Technical Change. American Economic Review, 102(1), 131–166.
- Also, see more information related to the model in the following repository: https://github.com/emolinaperez/Ediam_vFrontiers/blob/Master/Main/ClimateCalibration.r

Experiment Description
This experiment explores three distinct climate policy pathways, each characterized by different assumptions about two key parameters:
- ρ (rho): Intertemporal discount rate, which reflects the degree of intertemporal myopia. Lower values imply stronger concern for future generations.
- ε (epsilon): Clean technology learning rate; higher values indicate more rapid declines in clean technology costs as deployment increases.

| Run ID | ρ (Intertemporal Myopia) | ε (Clean Tech Efficiency) | Descriptive Scenario Name                                | Economic Interpretation                                                                                                                   |
| ------ | ------------------------ | ------------------------- | -------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| 14893  | 0.001 (**Very Low**)     | 3 (**Moderate**)          | **Intergenerational Solidarity with Gradual Transition** | Strong concern for future generations. Moderate but effective transition to clean technologies.                                           |
| 14877  | 0.009 (**Moderate**)     | 6.51 (**High**)           | **Pragmatic Collaboration with Efficient Transition**    | Some preference for present-day benefits, but effective mitigation is achieved through technological learning.                            |
| 18240  | 0.015 (**High**)         | 10 (**Very High**)        | **Present Bias with Strong Tech Subsidies**              | High short-term bias; requires strong subsidies to accelerate the transition, but significant investment in clean tech still takes place. |


# Beyond Intergenerational Solidarity: Why Strong Climate Subsidies Matter (and maybe the most)


