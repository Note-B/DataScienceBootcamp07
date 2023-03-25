## standardization (z-score)
z_calculation <- function (x) {
  (x-mean(x))/sd(x)
}

z_calculation (c(1,2,3,4,5))

z_calculation(mtcars$hp)

## normalization (min-max normalization)
## 0-1 feature scaling

norm_cal <- function (x) {
  (x-min(x)) / (max (x) - min (x))
}

norm_cal(1:5)
norm_cal(mtcars$hp)


## standard deviation in R is sample (not population)
mean(mtcars$hp); sd(mtcars$hp)

sd_sample <- function(x) {
  sqrt (sum((x-mean(x))**2) / (length(x)-1))
}

sd_pop <- function(x) {
  sqrt (sum((x-mean(x))**2) / (length(x)))
}

sd_sample(mtcars$hp)
sd_pop(mtcars$hp)

# t.test() finding CI in R
t.test(mtcars$hp)


## create promotion A vs promotion B

## random from normal distribution
promo_a <- rnorm(100, mean=550, sd=10)
promo_b <- rnorm(100, mean=400, sd=8)

## ho: promo a-b = 0
## ha: promo a-b != 0
result <- t.test(promo_a, promo_b, alternative = "two.sided")

ifelse (result$p.value <= 0.05, "Significant", "Not Significant")