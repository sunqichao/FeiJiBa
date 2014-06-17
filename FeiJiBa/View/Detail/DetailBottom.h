//
//  DetailBottom.h
//  FeiJiBa
//
//  Created by MacBook on 14-6-17.
//  Copyright (c) 2014年 sqc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailBottom : UIView


@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;




+ (DetailBottom *)getDetailBottom;



@end
