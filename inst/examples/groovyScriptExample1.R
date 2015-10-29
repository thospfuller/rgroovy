Initialize ()

groovyScript <- paste (
    "@Grab(group='org.apache.logging.log4j', module='log4j-core', version='2.1')",
    "@Grab(group='org.apache.logging.log4j', module='log4j-api', version='2.1')",
    "import org.apache.logging.log4j.core.Logger",
    "import org.apache.logging.log4j.LogManager",
    "final Logger log = LogManager.getLogger(this.class)",
    "log.error 'Hello world!'",
    "return Math.E",
    sep="\n")

result <- Evaluate (groovyScript=groovyScript)

result