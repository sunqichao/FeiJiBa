//
//  TimeLineCell.m
//  FeiJiBa
//
//  Created by MacBook on 14-6-16.
//  Copyright (c) 2014年 sqc. All rights reserved.
//

#import "TimeLineCell.h"
#import "TimeLineModel.h"

@implementation TimeLineCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}


- (void)setDataSource:(id)dataSource
{
    TimeLineModel *model = (TimeLineModel *)dataSource;
    self.titleLabel.text = model.proTitle;
    self.contentLabel.text = model.proDescription;
    
}



+ (TimeLineCell *)getTimeLineCell
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"TimeLineCell" owner:self options:nil];
    TimeLineCell *cell = nibs[0];
    return cell;
}




@end
