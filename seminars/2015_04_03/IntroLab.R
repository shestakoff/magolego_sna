# 1. Data types
#====================================================================================
# R has 5 basic classes of objects: character, numeric, integer, complex and logical (TRUE/FALSE).
# Numbers in R are generally treated as numeric objects. 
# R objects can have attributes: names, dimensions, class, length.

#============
# **Vectors** they are created the first time you assign values to them. 
#There are 3 basic functions for creating vectors: c(...), seq(...) and rep(...).
x<-seq(1,20,by=2)
class(x)
x
x<-seq(20,2,by=-4)
x
y<-rep(3,4)
y
z<-c(y,x)
z
i<-c(1,2,3)
x[i]  # Refer to an element i of x - returns an object of the same class as the original
j<-c(-1,-2,-3)
x[j]  # Negative values are omitted
length(x) # Number of elements in x
# Addition/Multiplication of two vectors of the same length
x<-c(2,3,4,5)
y<-c(1,2,3,4)
x*y
x+y
z<-c(1,2)
x+z # R automatically repeats the shorter vector
x<-0:5
class(x)
as.logical(x) # Convention: By default 0 is FALSE and all other numbers are TRUE
as.character(x)
# Vectors can only contain objects of the same class (exception is a list)
# When different objects are put together in a vector, coercion occurs
x<-c(TRUE,2)
x
x<-c("a",TRUE)
x
# Missing data are denoted by NaN (Not a Number - used for undefined maths operations) or NA (Not Avalaible - for anything else)
# NA values can also have types: integer NA, character NA,...
a<- NA
is.na(a)
a<-c(1, NA, 2, NaN)
is.nan(a) 
is.na(a)
any(is.na(a))
mean(a) #NA can propagate
a[!is.na(a)] #Removing bad values from a vector
a[!is.nan(a)]

#============
# **Matrices** are vectors with a dimension attribute (vector of length 2).
m<-matrix(1:6,nrow=2,ncol=3,byrow=FALSE)
m
m<-matrix(1:6,nrow=2,ncol=3,byrow=TRUE)
m
m<-matrix(1:6,nrow=2,ncol=3) #Default is by column: matrices are constructed column-wise
m
m<-matrix(1:4,nrow=2,ncol=3) #If insufficient data, it is reused as many times as needed
m
attributes(m)
dim(m)
#Matrices can be created by binding columns or rows
x<-seq(1,4)
y<-rep(c(1,2),2)
x
y
cbind(x,y)
rbind(x,y)

#============
# **Logical** expression formed using comparison operators <,>,<=,>=,==,!= and logical operators &, |,!
c(0,1,0,0)|c(1,0,0,0)
x<-c(1, NA, 3 , 4)
x>2
#Index the position of TRUE elements using the function which
x<-c(2,4,6,8,10,12)
which(x>5)

#============
# **Lists** are a type of vectors that contains elements of a different class.
my.list<-list(TRUE,FALSE, "a",2,2i)
my.list #Output is not printed like a vector: double brackets are used [[1]]
class(my.list)
my.list<-list(c(TRUE, FALSE), "one", c("t","w","o"), 3)
my.list[[3]] 
class(my.list[[3]])  #Object returned is not necessarily a list!
my.list[[3]][1]
# Compare with..
x<-c(TRUE,FALSE, "a",2,2i)
x #Coercion occured
class(x)

#============
# **Data frames** are used to store tabular data. It is a special type of list where
# every element of the list has the same length. Unlike matrices, the type can differ
# from one column to another. DF can have attributes called row.names
x<-data.frame(attr1=11:14,attr2=c(TRUE,FALSE,FALSE,FALSE),attr3=0:3)
class(x)
x
names(x)
x$attr1 #subsetting
x[,1] 
x[,"attr1"]
x[,c(1,3)]
ncol(x)
names(x)<-c("newattr1","newattr2","newattr3")
x
row.names(x)
#Large dataframes are usually read into R from a file
my.data<-read.table(file,header=FALSE,sep="") #assumed that each row of the file=one observation
my.data<-read.csv("data.csv")  #for data.csv


#============
# **Factors** are used for categorical variables (ordered or unordered)
x<-factor(c("a","b","c","a"))
x
class(x)
table(x)
x<-factor(c("a","b","c","a"), levels=c("b","a","c"))
x #order of the levels in modified: b is the baseline level



# 2. Functions
#====================================================================================
# One of the main building blocks for large programs.
myfun<-function(a,b){
  c<-a+b
  d<-a-b
}
f<-myfun(2,3)
f

myfun<-function(a,b){
  c<-a+b
  d<-a-b
  return(c)
}
f<-myfun(2,3)
f

myfun<-function(a,b){
  c<-a+b
  d<-a-b
  return(c(c,d))
}
f<-myfun(2,3)
f

# The 'apply' family of functions
#
# **tapply** vectorises the application of a function to subsets of data
# tapply(x,index,fun,...)
# x = target vector to which the function will be applied to
# index = factor or the same length as x, used to group the elements of x
# fun = function to be applied
x<-c(rnorm(10), runif(10), rnorm(10,mean=1))
x
f<-gl(3,10)
f
tapply(x,f,mean)

# **lapply/sapply** apply a function to a vector or an array, or a list
# lapply necessarily returns a list
# sapply can return a list or a vector
my.list<-list(0:4,runif(8))
my.list
lapply(my.list,mean)
sapply(my.list,mean)

m1<-matrix(1:6,nrow=2,ncol=3,byrow=TRUE)
m2<-matrix(1:6,nrow=3,ncol=2,byrow=TRUE)
my.list<-list(m1,m2)
my.list
sapply(my.list,colSums)
lapply(my.list,mean) #A list is returned
sapply(my.list,mean) #A vector is returned
sapply(m1,mean)


# 3. Graphics
#====================================================================================

#============
# **Exploratory graphs**
library(UsingR)
data(diamond)
# A data set on 48 diamond rings containing price in Singapore dollars and 
# size of diamond in carats.
# 1D -> summary/boxplot/histogram
summary(diamond$carat)
boxplot(diamond$carat)
?abline
abline(h=median(diamond$carat), col="red")
hist(diamond$carat)
hist(diamond$price, col="blue")
abline(v=median(diamond$price), col="red")
# 2D -> scatter plots
with(diamond,plot(carat,price))
plot(diamond$carat,diamond$price, pch=19)
?plot
# pch = plotting symbol
# lty = line type
# lwd = line width
# xlab/ylab = axes labels
plot(diamond$carat,diamond$price, pch=19, xlab="size in carat", ylab="price", main="diamond data")
abline(lm(price~carat, data=diamond), lwd=2, lty=2, col="blue")
# xlim/ylim also set the lower and upper values on the x/y axes.
plot(diamond$carat,diamond$price, pch=19, xlim=c(0.1,.4), ylim=c(180,1200), xlab="size in carat", ylab="price", main="diamond data")
legend(x=.27, y=400, "diamond data set", pch=19)

#============
# **Better graphics**
#
# Graphic parameter: par
par() #List of all graphics parameters
par("pch") #Value of a particular parameter
# We can make changes which will be applied to all graphics
par(mfrow=c(2,2)) #Create a matrix of plots filled by rows
hist(diamond$carat)
boxplot(diamond$carat)
hist(diamond$price, col="blue")
plot(diamond$carat,diamond$price, pch=19)
dev.off()

par(mar=c(1,2,3,4)) #creates space around each plot
plot(diamond$carat,diamond$price, pch=19)
dev.off()

# Mathematical typesetting
# Expression alerts that the text should be interpreted as a mathematical markup language (output format)
# paste allows mixing mathematical expressions and character strings
plot(diamond$carat,diamond$price, pch=19, xlab=expression(paste("size ", omega, " in carat")), ylab="price", main="diamond data")




