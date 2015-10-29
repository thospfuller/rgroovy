#
# IF Error: '\.' is an unrecognized escape in character string starting "'\."
#    AND the problem involves build -> test package
#
# THEN TRY THE FOLLOWING:
#
#     install.packages("devtools")
#
# TODO:
#   - install.packages("testthat")
#
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#
# WARNING:
#
# Using Test Package will result in a java.lang.ClassNotFoundException -- to run this test use Check Package.
#
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#

test_that (
    "Calling Initialize twice does not raise an error.",
    {
        Initialize ()
        expect_warning (Initialize ())
    }
)

test_that (
    "The Groovy script executes correctly.",
    {
        groovyScript <- "return 'Hello world!'"

        result <- Evaluate (groovyScript=groovyScript)

        expect_equal("Hello world!", result)
    }
)

test_that (
    "A NULL Groovy script raises an exception.",
    {
        expect_error(Evaluate (groovyScript=NULL), "The groovyScript parameter cannot be NULL.")
    }
)

test_that (
    "Execute with NULL variables does not raise an exception.",
    {
        groovyScript <- "return 'Hello world!'"

        Execute (groovyScript=groovyScript, variables=NULL)
    }
)