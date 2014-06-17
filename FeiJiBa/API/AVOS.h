//
//  AVOS.h
//  FeiJiBa
//
//  Created by MacBook on 14-6-16.
//  Copyright (c) 2014年 sqc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVOS : NSObject

+ (void)testSendData;

+ (void)testGetData;

+ (void)testIncrement;

+ (void)testAddArray;

+ (void)testPostAndComment;

+ (void)testRelative;


/**
 *  获取砖家的解答数据，
 *
 *  @param page 当前页数
 *
 *  @return 返回 AVObject 的数据数组
 */
+ (NSArray *)getProDataByNumber:(int)page;



/**
 *  获取屌丝的解答数据，
 *
 *  @param page 当前页数
 *
 *  @return 返回 AVObject 的数据数组
 */
+ (NSArray *)getDSDataByNumber:(int)page;

/**
 *  赞这篇文章
 *
 *  @param objectID 文章id
 */
+ (void)likeArticle:(NSString *)objectID
          className:(NSString *)name;


@end
