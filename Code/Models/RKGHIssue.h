//
//  RKGHIssue.h
//  RKGithub
//
//  Created by Blake Watters on 2/22/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RKGHUser, RKGHMilestone;

@interface RKGHIssue : NSManagedObject

// Attributes
@property (nonatomic, strong) NSString *body;
@property (nonatomic, strong) NSDate *closedAt;
@property (nonatomic, strong) NSNumber *commentsNumber;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *htmlURLString;
@property (nonatomic, strong) NSString *issueURLString;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDate *updatedAt;

@property (nonatomic, readonly) NSURL *htmlURL;
@property (nonatomic, readonly) NSURL *issueURL;
@property (nonatomic, readonly) NSUInteger commentsCount;

// Relationships
@property (nonatomic, strong) RKGHUser *user;
@property (nonatomic, strong) RKGHUser *assignee;
@property (nonatomic, strong) RKGHMilestone *milestone;

@end
