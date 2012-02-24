//
//  RKGHMilestone.m
//  RKGithub
//
//  Created by Blake Watters on 2/22/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import "RKGHMilestone.h"

@implementation RKGHMilestone

@dynamic milestoneURLString;
@dynamic number;
@dynamic state;
@dynamic title;
@dynamic descriptionText;
@dynamic creator;
@dynamic openIssues;
@dynamic closedIssues;
@dynamic createdAt;
@dynamic dueOn;
@dynamic issues;

- (NSURL *)milestoneURL {
    return [NSURL URLWithString:self.milestoneURLString];
}

- (NSUInteger)openIssuesCount {
    return [self.openIssues integerValue];
}

- (NSUInteger)closedIssuesCount {
    return [self.closedIssues integerValue];
}

@end
