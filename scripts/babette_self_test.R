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
beast2_options <- create_beast2_options(
  input_filename = get_babette_path("2_4.xml")
)

expect_false(file.exists(beast2_options$output_log_filename))
expect_false(file.exists(beast2_options$output_trees_filenames))
expect_false(file.exists(beast2_options$output_state_filename))

output <- run_beast2_from_options(beast2_options)

expect_true(length(output) > 40)
expect_true(file.exists(beast2_options$output_log_filename))
expect_true(file.exists(beast2_options$output_trees_filenames))
expect_true(file.exists(beast2_options$output_state_filename))

print("============================")
print("Self-test of babette passed")
print("============================")
