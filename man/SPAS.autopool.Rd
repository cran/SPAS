% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/SPAS.autopool.R
\name{SPAS.autopool}
\alias{SPAS.autopool}
\title{Autopooling a Stratified-Petersen (SP) data set.
This function applies pooling rules to pool a SPAS dataset to meeting minimum sparsity requirements
.}
\usage{
SPAS.autopool(
  rawdata,
  min.released = 100,
  min.inspected = 50,
  min.recaps = 50,
  min.rows = 1,
  min.cols = 1
)
}
\arguments{
\item{rawdata}{An (s+1) x (t+1) of the raw data BEFORE pooling.
The s x t upper left matrix is the number of animals released in row stratum i and recovered in
column stratum j. Row s+1 contains the total number of UNMARKED animals recovered in column stratum j.
Column t+1 contains the number of animals marked in each row stratum but not recovered in any column stratum.
The rawdata[s+1, t+1] is not used and can be set to 0 or NA.
The sum of the entries in each of the first s rows is then the number of animals marked in each row stratum.
The sum of the entries in each of the first t columns is then the number of animals captured (marked and unmarked) in each column stratum.
The row/column names of the matrix may be set to identify the entries in the output.}

\item{min.released}{Minimum number of releases in a pooled row}

\item{min.inspected}{Minimum number of inspections in a pooled column}

\item{min.recaps}{Minimum number of recaptures before any rows can be pooled}

\item{min.rows, min.cols}{Minimum number or rows and columns after pooling}
}
\value{
A list with a suggest pooling.
}
\description{
Autopooling a Stratified-Petersen (SP) data set.
This function applies pooling rules to pool a SPAS dataset to meeting minimum sparsity requirements
.
}
\details{
In many cases, the stratified set of releases and recapture is too sparse (many zeroes) or count
are very small. Pooling rows and columns may be needed.

Data needs to be pooled both row wise and column wise if the data are sparse
to avoid singularities in the fit.
This function automates pooling rows or columns following Schwarz and Taylor (1998).
\itemize{
\item All rows that have 0 releases are discarded
\item All columns that have 0 recaptures of tagged fish and 0 fish inspected are discarded
\item Starting at the first row and working forwards in time,
and then working from the final row and working backwards in time,
.  rows are pooled until a minimum of \code{min.released} are released.
An alternating pooling (from the top, from the bottom, from the top, etc) is used
\item Starting at the first column and working forwards in time,
.   and then working from the final column and working backwards in time,
columns are pooled until a minimum of \code{min.inspected} are inspected.
An alternating pooling (from the left, from the right, from the left, etc) is used.
\item If the sum of the total recaptures from released fish is <= \code{min.recaps}, then all rows are pooled
(which reduces to a Chapman estimator)
}
}
\examples{
conne.data.csv <- textConnection("
9  ,    21  ,     0  ,    0  ,    0  ,    0  ,   171
0  ,   101  ,    22  ,    1  ,    0  ,    0  ,   763
0  ,     0  ,   128  ,   49  ,    0  ,    0  ,   934
0  ,     0  ,     0  ,   48  ,   12  ,    0  ,   434
0  ,     0  ,     0  ,    0  ,    7  ,    0  ,    49
0  ,     0  ,     0  ,    0  ,    0  ,    0  ,     4
351,  2736  ,  3847  , 1818  ,  543  ,   191 ,     0")
conne.data <- as.matrix(read.csv(conne.data.csv, header=FALSE))
close(conne.data.csv)
 
SPAS.autopool(conne.data)
}
