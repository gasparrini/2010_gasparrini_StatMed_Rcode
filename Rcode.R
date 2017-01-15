###############################################################################
# Updated version of the R code for the analysis in:
#
#   "Distributed lag non-linear models"
#   Gasparrini, Armstrong and Kenward
#   Statistics in Medicine 2010
#   http://www.ag-myresearch.com/statmed2010.html
#
# Update: 14 March 2016
# For any problem with this code, please contact antonio.gasparrini@lshtm.ac.uk
# Please refer to the original code for any copyright issue
#
#  See www.ag-myresearch.com for future updates
###############################################################################

###############################################################################
# NB: THE EXAMPLE IS DIFFERENT IF COMPARED TO THE PUBLICATION, AS THE ORIGINAL
#   DATA ARE NOT AVAILABLE ANY MORE THROUGH THE PACKAGE NMMAPSlite, NOW ARCHIVED
# NB: THE CODE HAS BEEN ADAPTED TO THE NEW VERSION OF THE R PACKAGE dlnm
###############################################################################

require(dlnm); require(splines)

# CHECK VERSION OF THE PACKAGE
  if(packageVersion("dlnm")<"2.2.0")
    stop("update dlnm package to version >= 2.2.0")

##############################
# LOAD AND PREPARE THE DATASET
##############################

data <- chicagoNMMAPS
data <- data[,c("date","dow","death","temp","dptp","rhum","o3","pm10")]

# POLLUTION: O3 AT LAG-01
data$o301 <- filter(data$o3,c(1,1)/2,side=1)
# DEW POINT TEMPERATURE AT LAG 0-1
data$dp01 <- filter(data$dptp,c(1,1)/2,side=1)

##############################
# CROSSBASIS SPECIFICATION
##############################

# FIXING THE KNOTS AT EQUALLY SPACED VALUES OF TEMPERATURE AND
# AT EQUALLY-SPACED LOG-VALUES OF LAG
ktemp <- equalknots(data$temp,nk=4)
klag <- logknots(30,nk=3)
# CROSSBASIS MATRIX
ns.basis <- crossbasis(data$temp,argvar=list(knots=ktemp),
  arglag=list(knots=klag),lag=30)
summary(ns.basis)

##############################
# MODEL FIT AND PREDICTION
##############################

ns <- glm(death ~  ns.basis + ns(dp01,df=3) + dow + o301 + 
	ns(date,df=14*7),	family=quasipoisson(), data)
ns.pred <- crosspred(ns.basis,ns,at=-26:33,cen=21)

##############################
# RESULTS AND PLOTS
##############################

# 3-D PLOT
plot(ns.pred,zlab="RR",xlab="Temperature")

# SLICES
percentiles <- round(quantile(data$temp,c(0.001,0.05,0.95,0.999)),1)
ns.pred <- crosspred(ns.basis,ns,at=-260:330/10,cen=21)
plot(ns.pred,var=percentiles,lag=c(0,5,15,28))

# OVERALL EFFECT
plot(ns.pred,"overall",xlab="Temperature",
	main="Overall effect of temperature on mortality
	Chicago 1987-2000")

# RR AT CHOSEN PERCENTILES VERSUS 21C (AND 95%CI)
ns.pred$allRRfit[as.character(percentiles)]
cbind(ns.pred$allRRlow,ns.pred$allRRhigh)[as.character(percentiles),]

##############################

# THE MOVING AVERAGE MODELS UP TO LAG x (DESCRIBED IN SECTION 5.2)
# CAN BE CREATED BY THE CROSSBASIS FUNCTION INCLUDING THE 
# fun="strata" AND df=1 IN arglag, AND lag=x

#
