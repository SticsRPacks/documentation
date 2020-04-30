#devtools::install_github("SticsRPacks/SticsRPacks")
library("SticsRPacks")
library("SticsOnR")
library("SticsRFiles")

# Download the example USMs:
data_dir= file.path(SticsRFiles::download_data(),"study_case_1","V9.0")
# NB: all examples are now in data_dir

# DEFINE THE PATH TO YOUR LOCALLY INSTALLED VERSION OF JAVASTICS
####################################################################################
path_to_JavaStics="C:/Users/Thomas/Documents/GitHub/SticsRTests/inst/stics"  ############ A MODIFIER #####################
####################################################################################
javastics_path=file.path(path_to_JavaStics,"JavaSTICS-1.41-stics-9.0")
stics_path=file.path(javastics_path,"bin/stics_modulo.exe")

#'
#' ## Generate Stics input files from JavaStics input files
#' The Stics wrapper function used in CroptimizR works on text formatted input files (new_travail.usm,
#' climat.txt, ...) stored per USMs in different directories (which names must be the USM names).
#' `stics_inputs_path` is here the path of the directory that will contain these USMs folders.
stics_inputs_path=file.path(data_dir,"TxtFiles")
dir.create(stics_inputs_path)

gen_usms_xml2txt(javastics_path = javastics_path, workspace_path = file.path(data_dir,"XmlFiles"),
  target_path = stics_inputs_path, display = TRUE)

#' ## Run the model before optimization for a prior evaluation
# Set the model options (see '? stics_wrapper_options' for details)
model_options=stics_wrapper_options(stics_path,stics_inputs_path,
                                    parallel=FALSE)
# Run the model on all situations found in stics_inputs_path
sim_before_optim=stics_wrapper(model_options=model_options)
