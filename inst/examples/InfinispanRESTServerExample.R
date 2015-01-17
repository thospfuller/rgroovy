library ('RJSONIO')
library ('rinfinispanapi')

# 19 Nov 2014
msftOpen <- c("Open", 48.66)
msftHigh <- c("High", 48.75)
msftLow <- c("Low", 47.93)

msftDataFrame <- data.frame (msftOpen, msftHigh, msftLow)

msftAsJson <- RJSONIO::toJSON (msftDataFrame)

# Substitute the IP address below accordingly. Also note the absense of the
# trailing '/' -- this is deliberate and should not appear at the end of the
# URL.
SetEndpointURL ("http://192.168.1.4:8585/infinispan-server-rest/rest")

#
# Expected "Error: Not Found" as the entry does not exist in the cache.
#
DoGet  ("___defaultcache", cacheKey="msft")

DoPut ("___defaultcache", cacheKey="msft", payload=msftAsJson, headers=list ("Content-Type"="application/json"))

newMsftAsJson <- DoGet  ("___defaultcache", cacheKey="msft")
newMsftDataFrame <- RJSONIO::fromJSON (newMsftAsJson)
newMsftDataFrame
DoHead ("___defaultcache", cacheKey="msft")
DoDelete ("___defaultcache", cacheKey="msft")
#
# Expected "Error: Not Found" as the entry has been deleted.
#
DoGet  ("___defaultcache", cacheKey="msft")