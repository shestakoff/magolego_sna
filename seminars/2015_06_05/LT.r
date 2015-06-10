library('igraph')

# Linear Threshold model (unweighted version)
#   - graph: igraph object
#   - activated: list of initially activated nodes
#   - a: payoff for activation
#   - b: payoff for being not activated
LT <- function (g, activated, a, b) {
  # Defining the graph layout to preserve it
  # the same throughout the visualization
  l <- layout.fruchterman.reingold(g)
  # calculating the threshold
  threshold <- b * 1.0 / (a + b)
  # Setting the activated nodes
  V(g)$activated <- F
  for (v in activated) {
    V(g)[v]$activated <- T
  }
  # Indicator of whether simulation should stop
  any.changes <- T
  while(any.changes) {
    # Network visualization (at each simulation step)
    V(g)$color <- ifelse(V(g)$activated, "red", "lightblue")
    plot(g, layout=l)
    any.changes <- F
    # Iterating through non-activated nodes
    for(v in V(g)) {
      if(! V(g)[v]$activated) {
        # Calculating the fraction of activated neighbors
        neighborhood <- neighbors(g, V(g)[v]$name)
        activated.neighbors <- 0
        total.neighbors <- length(neighborhood)
        for(w in neighborhood) {
          activated.neighbors <- activated.neighbors + 1
        }
        if (activated.neighbors * 1.0 / total.neighbors >= threshold) {
          V(g)[v]$activated <- T
          any.changes <- T
        }
      }
    }
  }
  # Network visualization after the process has terminated
  V(g)$color <- ifelse(V(g)$activated, "red", "lightblue")
  plot(g, layout=l)
}

g <- read.table("graph.txt", header=T)
g <- graph.data.frame(g, directed=F)

LT(g, c("a", "d"), a=3, b=2)
