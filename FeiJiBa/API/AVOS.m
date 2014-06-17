//
//  AVOS.m
//  FeiJiBa
//
//  Created by MacBook on 14-6-16.
//  Copyright (c) 2014年 sqc. All rights reserved.
//

#import "AVOS.h"

@implementation AVOS

+ (void)testSendData
{
    AVObject *gameScore = [AVObject objectWithClassName:@"GameScore"];
    [gameScore setObject:[NSNumber numberWithInt:1337] forKey:@"score"];
    [gameScore setObject:@"Steve" forKey:@"playerName"];
    [gameScore setObject:[NSNumber numberWithBool:NO] forKey:@"cheatMode"];
    [gameScore save];
}


+ (void)testGetData
{
    AVQuery *query = [AVQuery queryWithClassName:@"GameScore"];
    
    NSLog(@"%@",[query findObjects]);
}

+ (void)testIncrement
{
    AVQuery *query= [AVQuery queryWithClassName:@"GameScore"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            AVObject *data = (AVObject *)obj;
            if ([data.objectId isEqualToString:@"539e9210e4b023daacbd7486"]) {
                [data incrementKey:@"score"];
                [data save];
            }
        }];
    }];
    
    
}

+ (void)testAddArray
{
    AVQuery *query = [AVQuery queryWithClassName:@"GameScore"];
    [query getObjectInBackgroundWithId:@"539e9210e4b023daacbd7486" block:^(AVObject *object, NSError *error) {
        AVObject *data = (AVObject *)object;
        [data addObjectsFromArray:@[@"facebook",@"google",@"youtube"] forKey:@"webSite"];
        [data save];
    }];
    
}

+ (void)testPostAndComment
{

    AVObject *comment = [AVObject objectWithClassName:@"Comment"];
    [comment setObject:@"family is ok" forKey:@"content"];
    
    [comment setObject:[AVObject objectWithoutDataWithClassName:@"Post" objectId:@"539ea2fbe4b0efed31bbcfa0"] forKey:@"parent"];
    [comment save];
}

+ (void)testRelative
{
    AVUser *user = [AVUser currentUser];
    
    AVRelation *relative = [user objectForKey:@"likes"];
    
    [relative addObject:[AVObject objectWithoutDataWithClassName:@"Post" objectId:@"39539ea27ae4b0efed31bbceb7"]];
    [user save];
}








+ (NSArray *)getProDataByNumber:(int)page
{
    AVQuery *query = [AVQuery queryWithClassName:@"ProAnswerList"];
    query.limit = 15;
    query.skip = 15*page;
    [query orderByDescending:@"createdAt"];
    return [query findObjects];
}





+ (NSArray *)getDSDataByNumber:(int)page
{
    AVQuery *query = [AVQuery queryWithClassName:@"DSAnswerList"];
    query.limit = 15;
    query.skip = 15*page;
    [query orderByDescending:@"createdAt"];
    return [query findObjects];
}



+ (void)likeArticle:(NSString *)objectID
          className:(NSString *)name
{
    AVQuery *query= [AVQuery queryWithClassName:name];
    [query getObjectInBackgroundWithId:objectID block:^(AVObject *object, NSError *error) {
        AVObject *data = (AVObject *)object;
        [data incrementKey:@"likes"];
        [data save];
    }];

}






















@end
