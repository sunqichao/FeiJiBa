//
//  TimeLineModel.h
//  FeiJiBa
//
//  Created by MacBook on 14-6-16.
//  Copyright (c) 2014年 sqc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeLineModel : NSObject

@property (copy, nonatomic) NSString *className;

@property (copy, nonatomic) NSString *objectID;
@property (assign, nonatomic) NSInteger likes;

@property (copy, nonatomic) NSString *proTitle;
@property (copy, nonatomic) NSString *proAuthor;
@property (copy, nonatomic) NSString *proDescription;
@property (copy, nonatomic) NSString *proContent;
@property (copy, nonatomic) NSString *proLayoutType;

@property (copy, nonatomic) NSString *dsTitle;
@property (copy, nonatomic) NSString *dsAuthor;
@property (copy, nonatomic) NSString *dsDescription;
@property (copy, nonatomic) NSString *dsContent;
@property (copy, nonatomic) NSString *dsLayoutType;

- (void)addLike;


- (void)initWithProData:(AVObject *)object;

- (void)initWithDSData:(AVObject *)object;


+ (NSArray *)getProDataByPage:(int)page;

+ (NSArray *)getDSDataByPage:(int)page;

@end
