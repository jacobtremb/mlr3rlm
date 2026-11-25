\name{LearnerRegrRlm}
\alias{LearnerRegrRlm}
\title{Robust linear regression learner}
\description{
  Learner for robust linear regression, using
  \code{\link[MASS]{rlm}} from the \pkg{MASS} package.
  Robust regression is less sensitive to outliers
  than ordinary least squares, because it gives
  smaller weights to observations with large residuals.
  This learner can be used in \pkg{mlr3} functions such as
  \code{resample} and \code{benchmark}.
}
\section{Hyper-parameters}{
  \describe{
    \item{method}{Fitting method: \code{"M"} (M-estimation, default)
      or \code{"MM"} (more robust to outliers).}
    \item{maxit}{Maximum number of iterations (integer, default 20).}
  }
}
\author{Jacob Tremblay}
\seealso{\code{\link[MASS]{rlm}}}
\examples{
task <- mlr3::tsk("mtcars")
learner <- mlr3rlm::LearnerRegrRlm$new()
learner$param_set$values$method <- "M"
learner$train(task)
pred <- learner$predict(task)
pred$score()
}