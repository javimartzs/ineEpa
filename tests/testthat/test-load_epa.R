test_that("load_epa works as expected", {
    expect_type(load_epa("activos", "edad"), "list")
    expect_error(load_epa("invalid_prefix"), "Invalid prefix")
})
