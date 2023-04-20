## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----libraries----------------------------------------------------------------
library(SPAS)

## ----loaddata-----------------------------------------------------------------
harrison.2011.chinook.F.csv <- textConnection("
  4   ,      2   ,      1   ,     1   ,     0   ,     0   ,   130
 12   ,      7   ,     14   ,     1   ,     3   ,     0   ,   330
  7   ,     11   ,     41   ,     9   ,     1   ,     1   ,   790
  1   ,     13   ,     40   ,    12   ,     9   ,     1   ,   667
  0   ,      1   ,      8   ,     8   ,     3   ,     0   ,   309
  0   ,      0   ,      0   ,     0   ,     0   ,     1   ,    65
744   ,   1187   ,   2136   ,   951   ,   608   ,   127   ,     0")

har.data <- as.matrix(read.csv(harrison.2011.chinook.F.csv, header=FALSE))
har.data

## -----------------------------------------------------------------------------
res <- SPAS.autopool(har.data)
res


## -----------------------------------------------------------------------------
mod..1 <- SPAS.fit.model(har.data,
                       model.id="Automated pooling",
                       autopool=TRUE)
SPAS.print.model(mod..1)

