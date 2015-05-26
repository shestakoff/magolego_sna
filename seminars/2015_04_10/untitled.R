r <- runif(10000)
xmin <- 1
xmax <- 100
alpha <- 2
#x <- (1 - r)^(-1.0/(alpha)) * xmin
x <- (xmin^(-alpha+1)+r*(xmax^(-alpha+1)-xmin^(-alpha+1)))^(1/(-alpha+1))
br = length(unique(x))
h <- hist(x, breaks = br)

freq = h$counts/sum(h$counts)
p = cumsum(freq)
m = sum(freq*h$mids)
w_up = cumsum(freq*h$mids)
w = w_up/m
plot(w,p)

h2 <- data.frame(mids=h$mids, dens=h$density)
