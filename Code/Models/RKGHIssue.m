//
//  RKGHIssue.m
//  RKGithub
//
//  Created by Blake Watters on 2/22/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import "RKGHIssue.h"

@implementation RKGHIssue

@dynamic body;
@dynamic closedAt;
@dynamic commentsNumber;
@dynamic createdAt;
@dynamic htmlURLString;
@dynamic issueURLString;
@dynamic number;
@dynamic state;
@dynamic title;
@dynamic updatedAt;
@dynamic user;
@dynamic assignee;
@dynamic milestone;

- (NSURL *)issueURL {
    return [NSURL URLWithString:self.issueURLString];
}

- (NSURL *)htmlURL {
    return [NSURL URLWithString:self.htmlURLString];
}

- (NSUInteger)commentsCount {
    return [self.commentsNumber integerValue];
}

@end
