# mlr3rlm

[![R-CMD-check](https://github.com/jacobtremb/mlr3rlm/actions/workflows/check.yaml/badge.svg)](https://github.com/jacobtremb/mlr3rlm/actions/workflows/check.yaml)

Robust linear regression learner for
[mlr3](https://mlr3.mlr-org.com/), using `rlm()` from the
[MASS](https://cran.r-project.org/package=MASS) package.

## Installation

```r
install.packages("remotes")
remotes::install_github("jacobtremb/mlr3rlm")
```

## Usage

```r
task <- mlr3::tsk("mtcars")
learner <- mlr3rlm::LearnerRegrRlm$new()
learner$param_set$values$method <- "MM"
learner$train(task)
pred <- learner$predict(task)
pred$score()
```

`LearnerRegrRlm` has two hyper-parameters:

- `method`: fitting method, `"M"` (default) or `"MM"` (more robust
  to outliers).
- `maxit`: maximum number of iterations (default 20).

Like any other `mlr3` learner, it can be used in `mlr3::resample()`
and `mlr3::benchmark()`.

## Related work

- [Course wiki](https://github.com/tdhock/2026-01-aa-grande-echelle/wiki/projets):
  list of learner projects, including this one.
- [MASS::rlm()](https://github.com/cran/MASS): the robust linear
  regression function called by this learner for train and predict.
- [mlr3extralearners](https://github.com/mlr-org/mlr3extralearners):
  other learners for mlr3, where this learner could be submitted.