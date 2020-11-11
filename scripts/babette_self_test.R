# babette self-testing script

message("=====================")
message("Self-testing babette")
message("=====================")

library(babette)

message("------------")
message("Session info")
message("------------")

message(sessionInfo())

message("--------------------------")
message("babette's package version")
message("--------------------------")

message(packageVersion("babette"))

message("--------------------------")
message("Show functions in package ")
message("--------------------------")

message(lsf.str("package:babette"))

message("---------------")
message("Start self-test")
message("---------------")

library(testthat)

testit::assert(is_beast2_installed())

# Do a BEAST2 run
inference_model <- create_test_inference_model()
beast2_options <- create_beast2_options()


expect_false(file.exists(inference_model$mcmc$tracelog$filename))
expect_false(file.exists(inference_model$mcmc$treelog$filename))
expect_false(file.exists(beast2_options$output_state_filename))

output <- bbt_run_from_model(
  fasta_filename = beautier::get_fasta_filename(),
  inference_model = inference_model,
  beast2_options = beast2_options
)

expect_true(length(output$output) > 40)
expect_true(file.exists(inference_model$mcmc$tracelog$filename))
expect_true(file.exists(inference_model$mcmc$treelog$filename))
expect_true(file.exists(beast2_options$output_state_filename))

message("============================")
message("Self-test of babette passed")
message("============================")
