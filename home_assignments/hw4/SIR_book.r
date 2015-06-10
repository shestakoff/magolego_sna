gl <- list()
gl$ba <- barabasi.game(250, m=5, directed=FALSE)
gl$er <- erdos.renyi.game(250, 1250, type=c("gnm"))
gl$ws <- watts.strogatz.game(1, 100, 12, 0.01)

beta <- 0.5
gamma <- 1
ntrials <- 100

sim <- lapply(gl, sir, beta=beta, gamma=gamma,no.sim=ntrials)

plot(sim$er)
plot(sim$ba, color="palegoldenrod", median_color="gold", quantile_color="gold")
plot(sim$ws, color="pink", median_color="red", quantile_color="red")

x.max <- max(sapply(sapply(sim, time_bins), max))
y.max <- 1.05 * max(sapply(sapply(sim, function(x) median(x)[["NI"]]), max, na.rm=TRUE))

plot(time_bins(sim$er), median(sim$er)[["NI"]], type="l", lwd=2, col="blue", xlim=c(0, x.max), ylim=c(0, y.max), xlab="Time", ylab=expression(N[I](t)))
lines(time_bins(sim$ba), median(sim$ba)[["NI"]], lwd=2, col="gold")
lines(time_bins(sim$ws), median(sim$ws)[["NI"]],lwd=2, col="red")
legend("topright", c("ER", "BA", "WS"),col=c("blue", "gold", "red"), lty=1)