//
//  DSTimeLineCell.h
//  FeiJiBa
//
//  Created by MacBook on 14-6-16.
//  Copyright (c) 2014年 sqc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSTimeLineCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;



- (void)setDataSource:(id)dataSource;


+ (DSTimeLineCell *)getDSTimeLineCell;





@end
