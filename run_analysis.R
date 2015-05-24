train_raw = read.table("train/X_train.txt")
train_activity = read.table("train/Y_train.txt")
test_raw = read.table("test/X_test.txt")
test_activity = read.table("test/Y_test.txt")
measure_list = read.table("features.txt")
subject_train = read.table("train/subject_train.txt")
subject_test = read.table("test/subject_test.txt")
activity_labels = read.table("activity_labels.txt")
i = {}
l = 1
for (j in 1:length(measure_list$V2)){
  if (length(grep('mean()',measure_list$V2[j],ignore.case=FALSE,fixed=TRUE)) == 1){
    i[l] = j
    h = names(train_raw)[j]
    measurements = as.character(measure_list$V2)
    g = measurements[j]
    names(train_raw)[names(train_raw) == h] <- g
    names(test_raw)[names(test_raw)==h] <- g
    l = l + 1
  }
  if (length(grep('std()',measure_list$V2[j],ignore.case=FALSE,fixed=TRUE)) == 1){
    i[l] = j
    l = l + 1
    h = names(train_raw)[j]
    measurements = as.character(measure_list$V2)
    g = measurements[j]
    names(train_raw)[names(train_raw)==h] <- g
    names(test_raw)[names(test_raw)==h] <- g
  }
}
train_raw = select(train_raw,i)
test_raw = select(test_raw,i)
i = {}
for (counter in 1:length(train_activity$V1)){
  for (activity_counter in 1:length(activity_labels$V1)){
    if (activity_labels$V1[activity_counter] == train_activity$V1[counter]){
      i[counter] = as.character(activity_labels$V2[activity_counter])
    }
  }
}
train_raw$activity = i
train_raw$subject = subject_train$V1
i = {}
for (counter in 1:length(test_activity$V1)){
  for (activity_counter in 1:length(activity_labels$V1)){
    if (activity_labels$V1[activity_counter] == test_activity$V1[counter]){
      i[counter] = as.character(activity_labels$V2[activity_counter])
    }
  }
}
test_raw$activity = i
test_raw$subject = subject_test$V1
train_raw = arrange(train_raw,subject,activity)
test_raw = arrange(test_raw,subject,activity)
f = train_raw %>% group_by(subject,activity) %>% summarise_each(funs(mean))
e = test_raw %>% group_by(subject,activity) %>% summarise_each(funs(mean))
pl = rbind(f,e)
pl = arrange(pl,subject,activity)
write.table(pl,file="final.txt",row.name=FALSE)

