# Bayesian_Statistic_Exam
Exam project for the Course of Bayesian Statistics

![Alt text](/img/cover_image.jpg?raw=true "Mortality in Milan")

## Original Paper

In the paper [Vigotti, M.A., Rossi, G., Bisanti, L., Zanobetti, A. and Schwartz, J. (1996). Short term effect of urban air pollution on respiratory health in Milan, Italy, 1980-1989. Journal of Epidemiology and Community Health, 50, 71-75.](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1060893/pdf/jepicomh00187-0073.pdf), it was proved the existance of a correlation between the number of respiratory deaths and the presence of polluting agents. The study is based on data collected every single day in the years between 1980 and 1989 in the city of Milan. This amounts to 3652 observations.

## Objectives of This Project

Using the same data, I tried to answer the following questions using a Bayesian approach:
 * What the the most relevant predictors in describing the daily number of deaths?
 * Is it better to describe the response variable with a Gaussian or a Possoinian distribution?
 * Is there some nonlinearity?
 
## Proposed Models
I explored the following solutions:
 * Linear Model (Gaussian family)
 * GAM Model (Gaussian family)
 * GLM (Poisson family)
 * Hierarchial Model (with Gaussian response)
 * Hierarchial Model with an Autoregressive effect (with Gaussian response)

The results are reported in the html file.
