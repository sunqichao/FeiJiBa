//
//  TimeLineModel.m
//  FeiJiBa
//
//  Created by MacBook on 14-6-16.
//  Copyright (c) 2014年 sqc. All rights reserved.
//

#import "TimeLineModel.h"
#import "AVOS.h"
@implementation TimeLineModel

- (void)initWithProData:(AVObject *)object
{
    self.objectID = object.objectId;
    self.proTitle = object[@"title"];
    self.proAuthor = object[@"author"];
    self.likes = [object[@"likes"] integerValue];
    self.proDescription = object[@"description"];
    self.proContent = object[@"content"];
    self.proLayoutType = object[@"type"];
}

- (void)initWithDSData:(AVObject *)object
{
    self.objectID = object.objectId;
    self.dsTitle = object[@"title"];
    self.dsAuthor = object[@"author"];
    self.likes = [object[@"likes"] integerValue];
    self.dsDescription = object[@"description"];
    self.dsContent = object[@"content"];
    self.dsLayoutType = object[@"type"];
}


- (void)addLike
{
    [AVOS likeArticle:self.objectID className:self.className];
    
}





+ (NSArray *)getProDataByPage:(int)page
{
    NSMutableArray *results = @[].mutableCopy;
    NSArray *proArray = [AVOS getProDataByNumber:page];
    [proArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TimeLineModel *model = [[TimeLineModel alloc] init];
        [model initWithProData:obj];
        model.className = @"ProAnswerList";
        [results addObject:model];
    }];
    return results.copy;
}

+ (NSArray *)getDSDataByPage:(int)page
{
    NSMutableArray *results = @[].mutableCopy;
    NSArray *proArray = [AVOS getDSDataByNumber:page];
    [proArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TimeLineModel *model = [[TimeLineModel alloc] init];
        [model initWithDSData:obj];
        model.className = @"DSAnswerList";
        [results addObject:model];
    }];
    return results.copy;
}


@end
