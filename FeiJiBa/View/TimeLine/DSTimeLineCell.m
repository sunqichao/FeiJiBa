//
//  DSTimeLineCell.m
//  FeiJiBa
//
//  Created by MacBook on 14-6-16.
//  Copyright (c) 2014年 sqc. All rights reserved.
//

#import "DSTimeLineCell.h"
#import "TimeLineModel.h"

@implementation DSTimeLineCell

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
    self.titleLabel.text = model.dsTitle;
    self.contentLabel.text = model.dsDescription;
    
}



+ (DSTimeLineCell *)getDSTimeLineCell;
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"DSTimeLineCell" owner:self options:nil];
    DSTimeLineCell *cell = nibs[0];
    return cell;
}











@end
