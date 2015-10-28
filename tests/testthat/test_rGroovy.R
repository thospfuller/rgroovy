#
# IF Error: '\.' is an unrecognized escape in character string starting "'\."
#    AND the problem involves build -> test package
#
# THEN TRY THE FOLLOWING:
#
#     install.packages("devtools")
#
test_that (
    "Calling Initialize twice does not raise an error.",
    {
        rGroovy::Initialize ()
        rGroovy::Initialize ()
    }
)