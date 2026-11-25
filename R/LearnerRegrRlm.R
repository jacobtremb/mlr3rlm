LearnerRegrRlm <- R6::R6Class(
  "LearnerRegrRlm",
  inherit = mlr3::LearnerRegr,
  public = list(
    initialize = function() {
      param_set <- paradox::ps(
        method = paradox::p_fct(c("M", "MM"), default = "M", tags = "train"),
        maxit = paradox::p_int(lower = 1L, default = 20L, tags = "train")
      )
      super$initialize(
        id = "regr.rlm",
        param_set = param_set,
        predict_types = "response",
        feature_types = c("logical", "integer", "numeric"),
        packages = c("mlr3rlm", "MASS"),
        label = "Robust Linear Regression",
        man = "mlr3rlm::LearnerRegrRlm"
      )
    }
  ),
  private = list(
    .train = function(task) {
      pv <- self$param_set$get_values(tags = "train")
      do.call(MASS::rlm, c(
        list(formula = task$formula(), data = task$data()),
        pv))
    },
    .predict = function(task) {
      newdata <- task$data(cols = task$feature_names)
      response <- stats::predict(self$model, newdata = newdata)
      list(response = unname(response))
    }
  )
)