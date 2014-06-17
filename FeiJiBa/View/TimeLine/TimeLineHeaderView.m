//
//  TimeLineHeaderView.m
//  FeiJiBa
//
//  Created by MacBook on 14-6-16.
//  Copyright (c) 2014年 sqc. All rights reserved.
//

#import "TimeLineHeaderView.h"

@implementation TimeLineHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


+ (TimeLineHeaderView *)getTimeLineHeaderView
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TimeLineHeaderView" owner:self options:nil];
    TimeLineHeaderView *header = nib[0];
    return header;
}



@end
