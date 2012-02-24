//
//  RKGHMilestone.h
//  RKGithub
//
//  Created by Blake Watters on 2/22/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RKGHUser.h"
#import "RKGHIssue.h"

@interface RKGHMilestone : NSManagedObject

@property (nonatomic, retain) NSString *milestoneURLString;
@property (nonatomic, retain) NSNumber *number;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *descriptionText;
@property (nonatomic, retain) NSNumber *openIssues;
@property (nonatomic, retain) NSNumber *closedIssues;
@property (nonatomic, retain) NSDate *createdAt;
@property (nonatomic, retain) NSDate *dueOn;

@property (nonatomic, retain) RKGHUser *creator;
@property (nonatomic, retain) NSSet *issues;

@property (nonatomic, readonly) NSURL *milestoneURL;

- (NSUInteger)openIssuesCount;
- (NSUInteger)closedIssuesCount;

@end
