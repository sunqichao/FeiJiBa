//
//  DetailViewController.h
//  FeiJiBa
//
//  Created by MacBook on 14-6-17.
//  Copyright (c) 2014年 sqc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeLineModel.h"
@interface DetailViewController : UIViewController


@property (weak, nonatomic) TimeLineModel *dataModel;

@property (assign, nonatomic) BOOL isPro;

@end
