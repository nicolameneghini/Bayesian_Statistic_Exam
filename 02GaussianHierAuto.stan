data {
  int<lower=0> N;
  vector[N] temp;
  vector[N] tot_mort;
  vector[N] so2;
  
  int<lower=1> J;
  int<lower=1, upper=J> year_idx[N];
  
  // day info
  int<lower=1> D;
  int<lower=1,upper=D> day_idx[N];
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
  
  real<lower=0,upper=1> rho_raw;  

  vector[D] day_raw;
  real<lower=0> sigma_day;
}

transformed parameters {
  //real sigma = inv(inv_phi);
  
  vector[J] mu = alpha + mu_raw*sigma_mu;
  vector[J] kappa = beta_so2 + kappa_raw*sigma_kappa;
  
  
  // AR(1) process priors
  real rho = 2.0 * rho_raw - 1.0;
  vector[D] day = sigma_day * day_raw;
  day[1] /= sqrt(1 - rho^2);
  for (d in 2:D) {
    day[d] += rho * day[d-1];
  }
}

model {
  alpha ~ normal(0,50);
  
  beta_day ~ normal(0,15);
  beta_temp ~ normal(0,15);
  beta_so2 ~ normal(0,15);
  
  sigma_mu ~ normal(0, 5);
  sigma_kappa ~ normal(0, 5);

  mu_raw ~ normal(0,1);
  kappa_raw ~ normal(0,1);
  
  rho_raw ~ beta(3, 2);
  day_raw ~ normal(0,1);
  sigma_day ~ normal(0,1);
  
  sigma ~ normal(0, 15); //inv_phi
  
  tot_mort ~ normal(mu[year_idx] + day[day_idx] + beta_temp*temp + kappa[year_idx].*so2, sigma);
}

generated quantities {
  real y_rep[N];
  real log_lik[N];
  
  for (n in 1:N) {
    real mu_n = mu[year_idx[n]] + day[day_idx[n]] + beta_temp*temp[n] + kappa[year_idx[n]]*so2[n];
    y_rep[n] = normal_rng(mu_n, sigma);
    
    log_lik[n] = normal_lpdf(tot_mort[n]| mu_n, sigma);

  }
}
