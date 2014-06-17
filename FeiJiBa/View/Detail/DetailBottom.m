//
//  DetailBottom.m
//  FeiJiBa
//
//  Created by MacBook on 14-6-17.
//  Copyright (c) 2014年 sqc. All rights reserved.
//

#import "DetailBottom.h"

@implementation DetailBottom

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}



+ (DetailBottom *)getDetailBottom
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"DetailBottom" owner:self options:nil];
    DetailBottom *detailBottom = nibs[0];
    return detailBottom;
}



@end
