#' This is the R Groovy API package documentation.
#'
#' @import rJava
#'
#' @docType package
#'
#' @name rgroovyapi
#'
NULL

#'
#' An environment which is used by this package when managing package-scope
#' variables.
#'
rGroovyAPI.env <- new.env()

.onLoad <- function (libname, pkgname) {
    #
    # Note that we cannot add documentation to this function -- if we do, when
    # roxygen is executed we will see an error about a missing name and the only
    # way to get past this error is to add @name to this function or leave the
    # documentation off altogether.
    #
    # Function starts the Java virtual machine.
    #
    # @param libname The library name.
    #
    # @param pkgname The package name.
    #
    .jpackage(pkgname, lib.loc = libname)
}

#' Funtion does nothing.
#'
#' @param libpath The library path.
#'
.onUnload <- function (libpath) { 
}

#' Function sets the global binding that will be passed to the GroovyShell
#' constructor.
#'
#' See also http://beta.groovy-lang.org/docs/latest/html/gapi/groovy/lang/Binding.html.
#'
#' @param binding The binding 
#'
#' @export
#'
Initialize <- function (binding = NULL) {

    if (is.null (binding)) {
        # We'll pass in an empty binding if the binding is null.
        binding <- .jnew("groovy.lang.Binding")
    }

    groovyShell <- .jnew("groovy.lang.GroovyShell", binding)

    assign("groovyShell", groovyShell, envir = rGroovyAPI.env)
}

#' Executes the groovy script.
#'
#' @param groovyShell The groovyShell with which to execute the specified groovy
#'  script. Note that the groovyShell can be null, however if this is null then
#'  the Initialize function must have been called so that a global groovyShell
#'  instance will be available in the environment.
#'
#' @param groovyScript The groovy script being executed.
#'
#' @return The result of the Groovy script execution.
#'
#' @export
#'
Evaluate <- function (groovyShell = NULL, groovyScript) {

    if (is.null (groovyShell)) {
        groovyShell <- rGroovyAPI.env$groovyShell
    }

    tryCatch(
        result <- groovyShell$evaluate (groovyScript),
        Throwable = function (e) {
          e$printStackTrace ()
            stop (
                paste (
                    "An exception was thrown when executing the groovy script ",
                    "details follow.", groovyScript, e$getMessage(), sep=""))
    })

    return (result)
}

#' Function prints some information about this plugin.
#'
#' @export
#'
About <- function () {
    cat (
        " ***********************************************************\n",
        "***                                                     ***\n",
        "***         Welcome to the R Groovy API Package         ***\n",
        "***                                                     ***\n",
        "***                    version 0.85.                    ***\n",
        "***                                                     ***\n",
        "***                Follow us on LinkedIn:               ***\n",
        "***                                                     ***\n",
        "***       https://www.linkedin.com/company/229316       ***\n",
        "***                                                     ***\n",
        "***                Follow us on Twitter:                ***\n",
        "***                                                     ***\n",
        "***        https://twitter.com/CoherentLogicCo          ***\n",
        "***                                                     ***\n",
        "***********************************************************\n")
}
