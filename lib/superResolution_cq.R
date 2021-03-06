 ########################
### Super-resolution ###
########################

### Author: Chengliang Tang
### Project 3

 # Define function
superResolution <- function(LR_dir, HR_dir, modelList){
  
  ### Construct high-resolution images from low-resolution images with trained predictor
  
  ### Input: a path for low-resolution images + a path for high-resolution images 
  ###        + a list for predictors
  
  ### load libraries
  library("EBImage")
  n_files <- length(list.files(LR_dir))
  #MSE <- array(NA, n_files)
  #PSNR <- array(NA, n_files)
  
  ### read LR/HR image pairs
  require(parallel)
  cl <- makeCluster(4)
  
  ### read LR/HR image pairs
  for(i in 1:n_files){
  # LR_dir = train_LR_dir
  # imgLR <- readImage(paste0(LR_dir,"img_0003.jpg"))    
  # pathHR <- paste0(HR_dir,"img_0003.jpg")   
    
    imgLR <- readImage(paste0(LR_dir,  "img", "_", sprintf("%04d", i), ".jpg"))
    #display(imgLR)
    pathHR <- paste0(HR_dir,  "img", "_", sprintf("%04d", i), ".jpg")
    featMat <- array(NA, c(dim(imgLR)[1] * dim(imgLR)[2], 8, 3))
    
    imgLR <- abind(array(0, replace(dim(imgLR), 2, 1)),imgLR, array(0, replace(dim(imgLR), 2, 1)), along = 2)
    imgLR <- abind(array(0, replace(dim(imgLR), 1, 1)),imgLR, array(0, replace(dim(imgLR), 1, 1)), along = 1)
    
    ### step 1. for each pixel and each channel in imgLR:
    ###           save (the neighbor 8 pixels - central pixel) in featMat
    ###           tips: padding zeros for boundary points
    for (j in 2:(dim(imgLR)[1]-1)){
      for (k in 2:(dim(imgLR)[2]-1)){
        for (c in 1:3){
          neighbour8 <- c(imgLR[j-1, (k-1):(k+1), c],
                          imgLR[j, k-1, c], imgLR[j, k+1, c], 
                          imgLR[j+1, (k-1):(k+1), c])
          featMat[(j-1)*(k-1), 1:8, c] =  neighbour8 - c(imgLR[j, k, c])
        }
      }
    }
    imgLR <- imgLR[-c(1,dim(imgLR)[1]), -c(1,dim(imgLR)[2]), 1:3]
    imgHR_rec = array(NA, c((dim(imgLR)[1])*2, (dim(imgLR)[2])*2, 3)) 
    
    for (c in 1:3){
    ### step 2. apply the modelList over featMat
    # modelList = fit_train
    predMat <- test(modelList, featMat)
    ### step 3. recover high-resolution from predMat and save in HR_dir
    predMat_train <- array(predMat, c(dim(imgLR)[1]*dim(imgLR)[2],4,3))
    imgLR_arr_1 <- as.vector(t(imgLR[,,c]))
    imgLR_arr_1_4 <- cbind(imgLR_arr_1,imgLR_arr_1,imgLR_arr_1,imgLR_arr_1)
    predMat_tran_1 <- predMat_train[,,c] + imgLR_arr_1_4
    col12 <- c(rbind(predMat_tran_1[,1], predMat_tran_1[,2]))
    col34 <- c(rbind(predMat_tran_1[,3], predMat_tran_1[,4]))
    col12_tran <- matrix(col12, nrow = dim(imgLR)[1],byrow = TRUE)
    col34_tran <- matrix(col34, nrow = dim(imgLR)[1],byrow = TRUE)
    imgHR_rec[seq(1,dim(imgLR)[1]*2,2),,c] <- col12_tran
    imgHR_rec[seq(2,dim(imgLR)[1]*2,2),,c] <- col34_tran
    }
    path_predictive <- paste0(HR_dir,  "pred_img", "_", sprintf("%04d", i), ".jpg")
    imgHR <- Image(imgHR_rec, colormode="Color")
    #display(imgHR)
    #writeImage(Image(imgHR_rec, colormode="Color"), path_predictive)
    
    # Check error:
    #imgHR <- readImage(paste0(HR_dir,  "img", "_", sprintf("%04d", i), ".jpg"))
    #MSE[i] <- (1/(3*dim(imgLR)[1]*2*dim(imgLR)[2]*2)) * (imgHR - imgHR_rec)^2
    #PSNR[i] <- 10 * log10(max(imgHR)) - 10 * log10(MSE[i])
    
    # Save
    library(jpeg)
    writeJPEG(imgHR, target = pathHR)
  }
  stopCluster(cl)
}


