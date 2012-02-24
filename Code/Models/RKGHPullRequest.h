//
//  RKGHPullRequest.h
//  RKGithub
//
//  Created by Blake Watters on 2/16/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RKGHPullRequest : NSObject

@property (nonatomic, retain) NSURL *selfURL;
@property (nonatomic, retain) NSURL *diffURL;
@property (nonatomic, retain) NSURL *patchURL;
@property (nonatomic, retain) NSURL *issueURL;
@property (nonatomic, retain) NSNumber *number;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *body;
@property (nonatomic, retain) NSDate *createdAt;
@property (nonatomic, retain) NSDate *updatedAt;
@property (nonatomic, retain) NSDate *closedAt;
@property (nonatomic, retain) NSDate *mergedAt;
@property (nonatomic, retain) NSArray *links;

@end
