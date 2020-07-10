data {
  int<lower=0> N;
  vector[N] day;
  vector[N] temp;
  vector[N] tot_mort;
  vector[N] so2;
  
  int<lower=1> J;
  int<lower=1, upper=J> year_idx[N];
}
parameters {
  real alpha;
  real beta_day;
  real beta_temp;
  real beta_so2;
  
  vector[J] mu_raw; 
  vector[J] kappa_raw;
  real<lower=0> sigma_mu; 
  real<lower=0> sigma_kappa; 

  real<lower=0> sigma;
}

transformed parameters {
  //real sigma = inv(inv_phi);
  
  vector[J] mu = alpha + mu_raw*sigma_mu;
  vector[J] kappa = beta_so2 + kappa_raw*sigma_kappa;
}

model {
  alpha ~ normal(0,50);
  
  beta_day ~ normal(0,15);
  beta_temp ~ normal(0,15);
  beta_so2 ~ normal(0,15);
  
  sigma_mu ~ normal(0, 10);
  sigma_kappa ~ normal(0, 10);

  mu_raw ~ normal(0,1);
  kappa_raw ~ normal(0,1);
  
  sigma ~ normal(0, 15); //inv_phi
  
  tot_mort ~ normal(mu[year_idx] + beta_day*day + beta_temp*temp + kappa[year_idx].*so2, sigma);
}

generated quantities {
  real y_rep[N];
  real log_lik[N];
  
  for (n in 1:N) {
    
    real mu_n = mu[year_idx[n]] + beta_day*day[n] + beta_temp*temp[n] +  kappa[year_idx[n]]*so2[n];
    y_rep[n] = normal_rng(mu_n, sigma);
    
    log_lik[n] = normal_lpdf(tot_mort[n]| mu_n, sigma);

  }
}
