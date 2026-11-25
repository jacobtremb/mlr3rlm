library(testthat)

test_that("train and predict give one numeric prediction per row", {
  task <- mlr3::tsk("mtcars")
  learner <- mlr3rlm::LearnerRegrRlm$new()
  learner$train(task)
  pred <- learner$predict(task)
  expect_length(pred$response, task$nrow)
  expect_true(is.numeric(pred$response))
  expect_false(anyNA(pred$response))
})

test_that("predictions are the same as MASS::rlm", {
  task <- mlr3::tsk("mtcars")
  learner <- mlr3rlm::LearnerRegrRlm$new()
  learner$train(task)
  pred <- learner$predict(task)
  fit <- MASS::rlm(mpg ~ ., data = mtcars)
  expect_equal(pred$response, unname(predict(fit, mtcars)))
})

test_that("rlm is more accurate than featureless", {
  task <- mlr3::tsk("mtcars")
  rlm_learner <- mlr3rlm::LearnerRegrRlm$new()
  featureless <- mlr3::lrn("regr.featureless")
  rlm_mse <- rlm_learner$train(task)$predict(task)$score()
  featureless_mse <- featureless$train(task)$predict(task)$score()
  expect_lt(rlm_mse, featureless_mse)
})