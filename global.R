
require(tibble)
require(dplyr)
diabetics<-read.csv('diabetic_data.csv',na.strings=c("?"))


############## Subset for Parallel Coordinate Plot ##########
diabetics_sub<-diabetics[,c('age','gender','insulin','race','number_diagnoses')]
diabetics_sub<-diabetics_sub[complete.cases(diabetics_sub),]

############# Aggregate for HEAT MAP #############

# subset features
diabeticsHM<-diabetics[, c('time_in_hospital','num_procedures','gender','race','admission_type_id',
                           'num_lab_procedures','num_medications','age')]
diabeticsHM<-filter(diabeticsHM, race %in% c('AfricanAmerican', 'Asian', 'Caucasian', 'Hispanic','Other'))

make_heatmap_plot<-function(feature){
  if (feature=='age'){
    aggregate_df<-group_by(diabeticsHM, age) %>%
      summarise(mean_time_in_hospital = mean(time_in_hospital),
                mean_num_procedure = mean(num_procedures),
                mean_num_lab_procedures = mean(num_lab_procedures),
                mean_num_medications = mean(num_medications)
      )
  }
  else if (feature=='race'){
    aggregate_df<-group_by(diabeticsHM, race) %>%
      summarise(mean_time_in_hospital = mean(time_in_hospital),
                mean_num_procedure = mean(num_procedures),
                mean_num_lab_procedures = mean(num_lab_procedures),
                mean_num_medications = mean(num_medications))
  }
  
  else if (feature=='admission_type_id'){
    
    aggregate_df<-group_by(diabeticsHM, admission_type_id) %>%
      summarise(mean_time_in_hospital = mean(time_in_hospital),
                mean_num_procedure = mean(num_procedures),
                mean_num_lab_procedures = mean(num_lab_procedures),
                mean_num_medications = mean(num_medications))
    
    
  }
  
  remove_rownames(aggregate_df)
  aggregate_df <- column_to_rownames(aggregate_df, var = feature)
  
  x  <- as.matrix(aggregate_df)
  rc <- rainbow(nrow(x), start = 0, end = .3)
  cc <- rainbow(ncol(x), start = 0, end = .3)
  hv <- heatmap(x, col = cm.colors(10), scale = 'column',
                RowSideColors = rc, ColSideColors = cc, margins = c(15,25),
                main = paste("Heatmap: Diabetics patients by",feature))
}


