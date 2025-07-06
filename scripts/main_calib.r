#define vector for output
 root<-"C:/Users/galla/Documents/ediam/"

#this script has been created to find the optimal value of policies for a future id,
  library(deSolve)
  library(optimx)
  dir.harness<-paste0(root,"output")
#Source Experimental Design
  dir.exp<-paste0(root,"input/")
  dir.scripts<-paste0(root, "scripts/")
  experiment.version<-"Exp.design_calib.csv"
  Exp.design<-read.csv(paste(dir.exp,experiment.version,sep=""))
#run the model once

#Source Model
  dir.model<-paste0(root,"scripts/")
  model.version<-"InternationalGreenTechChangeModel_10_22_2015.r"
  source(paste(dir.model,model.version,sep=""))

target.run<-1
params<-c(
                         S.0=as.numeric(Exp.design[target.run,'S.0']),
                         TimeStep=as.numeric(Exp.design[target.run,'TimeStep']),
                         EndTime=as.numeric(Exp.design[target.run,'EndTime']),
                         alfa=as.numeric(Exp.design[target.run,'alfa']),
                         epsilon=as.numeric(Exp.design[target.run,'epsilon']),
                         Gamma.re=as.numeric(Exp.design[target.run,'Gamma.re']),
                         k.re=as.numeric(Exp.design[target.run,'k.re']),
                         Gamma.ce=as.numeric(Exp.design[target.run,'Gamma.ce']),
                         k.ce=as.numeric(Exp.design[target.run,'k.ce']),
                         Eta.re=as.numeric(Exp.design[target.run,'Eta.re']),
                         Eta.ce=as.numeric(Exp.design[target.run,'Eta.ce']),
                         Nu.re=as.numeric(Exp.design[target.run,'Nu.re']),
                         Nu.ce=as.numeric(Exp.design[target.run,'Nu.ce']),
                         qsi=as.numeric(Exp.design[target.run,'qsi']),
                         Delta.S=as.numeric(Exp.design[target.run,'Delta.S']),
						 Delta.Temp.Disaster=as.numeric(Exp.design[target.run,'Delta.Temp.Disaster']),
						 Beta.Delta.Temp=as.numeric(Exp.design[target.run,'Beta.Delta.Temp']),
						 CO2.base=as.numeric(Exp.design[target.run,'CO2.base']),
						 CO2.Disaster=as.numeric(Exp.design[target.run,'CO2.Disaster']),
                         labor.growth_N=as.numeric(Exp.design[target.run,'labor.growth_N']),
						 labor.growth_S=as.numeric(Exp.design[target.run,'labor.growth_S']),
                         lambda.S=as.numeric(Exp.design[target.run,'lambda.S']),
						 sigma.utility=as.numeric(Exp.design[target.run,'sigma.utility']),
						 rho=as.numeric(Exp.design[target.run,'rho']),
                         Yre.0_N=as.numeric(Exp.design[target.run,'Yre.0_N']),
                         Yce.0_N=as.numeric(Exp.design[target.run,'Yce.0_N']),
                         Yre.0_S=as.numeric(Exp.design[target.run,'Yre.0_S']),
                         Yce.0_S=as.numeric(Exp.design[target.run,'Yce.0_S']),
						 size.factor=as.numeric(Exp.design[target.run,'size.factor']),
						 Run.ID= as.numeric(Exp.design[target.run,'Run.ID']),
						 policy.name = as.character(Exp.design[target.run,'policy.name']),
						 dir.harness=dir.harness)

TechChangeMod(c(0.03,1.0,0.02,0.01,0.05,1.0,0.02,0.5),params)

## =====================================================================================================
## This section reads the output of simulations and reshapes it into time series split by region,
## =====================================================================================================
#Define directory parameters
 dir.inputs<-paste0(root,"input/")
 dir.harness<-paste0(root,"output/")
 dir.output<-paste0(root,"output/")
 dir.scripts<-paste0(root,"scripts/")

#create vector with file names
 experiment.version<-"Exp.design_calib.csv"
 filenames <- list.files(dir.harness, pattern="*.csv", full.names=FALSE)
#source function to process harnessed output data
 source(paste(dir.scripts,"harness_processing.r",sep=""))
#run post-processing in parallel
  library(data.table)
  library(snow)
  modelruns<-process.harness.data(filenames[1],dir.inputs,experiment.version,dir.harness)
#print time series for model
  write.csv(modelruns, paste(root,"ParameterCalibration\\", "model.runs_calib.csv", sep=""), row.names=FALSE)


## =====================================================================================================
## This section merges the historical table with the calibration run
## =====================================================================================================

#this script puts together the data for the historic calibration
  dir.output<-paste(root,"RDM Outputs\\",sep="")
  dir.historic<-paste0(root,"input/")

#read historic data
  historic<-read.csv(paste(dir.historic,"historic_energy_both_regions_v2.csv",sep=""))
#read simulated data
  data<-read.csv(paste(dir.historic,"model.runs_calib.csv",sep=""))
  data<-data[,c("Run.ID","time","Region","Y","Yce","Yre","Ace","Are","L","policy.name",
                "epsilon","rho","alfa","Eta.re","Eta.ce","Gamma.re","Gamma.ce","Nu.re","Nu.ce",
   				"k.re","k.ce","labor.growth","size.factor")]
  data$time<-data$time-29
 data<-Reduce(function(...) { merge(..., ) }, list(data,historic))
 #subset and create OECD and NONOECD regions
 data.historic<-subset(data,data$Run.ID==1)
 data.historic$Region<-gsub("N","OECD",data.historic$Region)
 data.historic$Region<-gsub("S","NONOECD",data.historic$Region)
 data.historic$Run.ID<-data.historic$Run.ID+1
 data<-rbind(data,data.historic)
  write.csv(data, paste(dir.output, "historic_calib.csv", sep=""), row.names=FALSE)
