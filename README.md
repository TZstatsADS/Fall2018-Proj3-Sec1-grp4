# Project 3 : Can you unscramble a blurry image? 
![image](figs/example.png)

### [Full Project Description](doc/project3_desc.md)

Term: Fall 2018

+ Team # 4 
+ Team members
	+ Yadir Lakehal (yl3435@columbia.edu)
	+ Chuqiao Rong (cr2945@columbia.edu)
	+ Amon Tokoro (at3250@columbia.edu)
	+ Anke Xu (ax2127@columbia.edu)
	+ Yiqiao Yin (yy2502@columbia.edu)

## Project Summary  

In this project, we created a classification engine to enhance the resolution of images. To do so, we will carry out model evaluation and selection for predictive analytics on image data. 

We started out with a set of [1500 pairs of images](https://www.dropbox.com/s/7agsll3t5t7spkr/train_set.zip?dl=0). For each pair, we have a high-resolution image that serves as the *ground truth* and a down-sampled low-resolution image as the *input* for the learning task. 
Our learning goal was to produce a *predicted* high resolution image as *output* based on the low-resolution input that is as close to the *ground truth* as possible. 

We were tasked with creating a program that can **enhance the resolution of blurry and low-resolution images**. 

The portability of this program (holding storage and memory cost) as well as the computational efficiency (test running time cost) are a great concern, so we needed to find a balance between the complexity of variables/features/models used and our predictive performance. 

There already exists a current practice using boosted decision stumps on neighboring pixels and the R package gbm is used to implement this classifier.

Our **task** for this project is to
1) implement the *current* practice as the *baseline model* of our system
2) implement an improvement to the current practice. To do this, we used a linear regression model and an xgboost model.
3) evaluate the performance gain of our proposed improvements against the baselines. 

**To run this script, follow the instructions on the [doc folder](https://github.com/TZstatsADS/Fall2018-Proj3-Sec1-grp4/tree/master/doc) of this repository. **
	
**Contribution statement**: 

Project leader:

Yiqiao Yin：Designed and organized the structure of whole project. Built the baseline model and initiated linear regression model.  Trained the baseline model. Helped debugging through the whole project. Also helped making the presentation slide.


Anke Xu: Built and optimized XGBoost model and built linear model. Tuned parameters for the XGBoost model and baseline model. Trained the improved models. Helped debugging the baseline model. Also helped to make the presentation slide.

Chuqiao Rong: Coded feature.R and superResolution.R files. Tuned parameters for the baseline model. Made the presentation slide and presented the project.

Amon Tokoro: Helped debugging for the whole project. Tuned parameters for the baseline model and XGBoost model. Trained the improved models.

Yadir Lakehal: Tuned parameters for the baseline model and made efforts on linear model. Edited the readme file and helped the presenter with the presentation. Helped to make the presentation slide. 


We also want to thank Professor Ying Liu and Professor Tian Zheng for hosting lectures of Advanced Data Science this semester. It is with transcending gratitude that we announce here what an inspiration both professors have been throughout our experience of building this shiny app. Their knowledge, understanding and genuine “care” for others is illuminated in everything they do! We, Group 4, are in forever debt for their teachings. Moreoever, we also want to thank to TA, Chengliang Tang. There is not enough we can say about how much we thank heaven that he is our teaching assistance. His patience and understanding are unsurpassed. We are grateful for being his students.

Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
