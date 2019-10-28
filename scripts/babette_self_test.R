# babette self-testing script

print("=====================")
print("Self-testing babette")
print("=====================")

library(babette)

print("------------")
print("Session info")
print("------------")

print(sessionInfo())

print("--------------------------")
print("babette's package version")
print("--------------------------")

print(packageVersion("babette"))

print("--------------------------")
print("Show functions in package ")
print("--------------------------")

print(lsf.str("package:babette"))

print("---------------")
print("Start self-test")
print("---------------")

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

print("============================")
print("Self-test of babette passed")
print("============================")
