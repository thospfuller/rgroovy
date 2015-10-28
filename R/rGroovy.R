#'
#' @title Groovy scripting language integration
#'
#' @description This package integrates the Groovy scripting language with the
#' R Project for Statistical Computing.
#'
#' @details From \href{http://en.wikipedia.org/wiki/Groovy_(programming_language)}{Wikipedia}:
#'
#' "Groovy is an object-oriented programming language for the Java platform. It
#' is a dynamic language with features similar to those of Python, Ruby, Perl,
#' and Smalltalk. It can be used as a scripting language for the Java Platform,
#' is dynamically compiled to Java Virtual Machine (JVM) bytecode, and
#' interoperates with other Java code and libraries."
#'
#' Note that this package ships with Invoke Dynamic support and hence requires
#' Java version 1.7 or above.
#'
#' @seealso \href{http://groovy.codehaus.org/}{Groovy}
#' @seealso \href{http://www.groovy-lang.org/indy.html}{Invoke Dynamic}
#'
#' @import rJava
#'
#' @docType package
#'
#' @name rGroovy
#'
NULL

#'
#' An environment which is used by this package when managing package-scope
#' variables.
#'
.rGroovyAPI.env <- new.env()

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
#' constructor. Note that it is not necessary to invoke however the user will be
#' required to manage their own binding.
#'
#' @param binding An instance of \href{http://beta.groovy-lang.org/docs/latest/html/gapi/groovy/lang/Binding.html}{groovy.lang.Binding}.
#'
#' @examples
#'  Initialize ()
#'
#' @export
#'
Initialize <- function (binding = NULL) {

    if (!is.null (.rGroovyAPI.env$groovyShell)) {
        warning (
            paste (
                "Initialize has been invoked more than once -- are you sure ",
                "this is what you intended to do?"
            )
        )
    }

    if (is.null (binding)) {
        # We'll pass in an empty binding if the binding is null.
        binding <- .jnew("groovy.lang.Binding")
    }

    groovyShell <- .jnew("groovy.lang.GroovyShell", binding)

    assign("groovyShell", groovyShell, envir = .rGroovyAPI.env)
}

#' Function evaluates (executes) the groovy script and returns the result.
#'
#' @param groovyShell The groovyShell with which to execute the specified groovy
#'  script. Note that the groovyShell can be NULL, however if this is NULL then
#'  the Initialize function must have been called so that a global groovyShell
#'  instance will be available in the environment otherwise an exception is
#'  raised.
#'
#' @param groovyScript The groovy script being executed.
#'
#' @param binding The binding that will be used.
#'
#' @return The result of the script execution.
#'
#' @examples {
#'  Initialize ()
#'  Evaluate (groovyScript="print 'Hello world!'")
#' }
#'
#' @export
#'
Evaluate <- function (
    groovyShell = NULL,
    groovyScript,
    binding = NULL
) {

    if (is.null (groovyShell)) {
        groovyShell <- .rGroovyAPI.env$groovyShell
    }

    if (is.null (groovyShell)) {
        stop (
            paste (
                "Both the local and global groovyShell(s) are null -- have ",
                "you called the Initialize function?"
            )
        )
    }

    tryCatch (
        result <- groovyShell$evaluate (groovyScript),
        Throwable = function (exception) {
            stop (
                paste (
                    "An exception was thrown when executing the groovy ",
                    "script -- details follow.",
                    groovyScript, exception$getMessage(), sep=""))
    })

    return (result)
}

#' Function prints some information about this package.
#'
#' @export
#'
About <- function () {
    cat (
        " ***********************************************************\n",
        "***                                                     ***\n",
        "***         Welcome to the R Groovy API Package         ***\n",
        "***                                                     ***\n",
        "***                    version 1.0.                     ***\n",
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
