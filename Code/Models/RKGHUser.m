//
//  RKGHUser.m
//  RKGithub
//
//  Created by Blake Watters on 2/22/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import "RKGHUser.h"

@implementation RKGHUser

@dynamic login;
@dynamic userID;
@dynamic avatarURLString;
@dynamic gravatarID;
@dynamic userURLString;

- (NSURL *)avatarURL {
    return [NSURL URLWithString:self.avatarURLString];
}

- (NSURL *)userURL {
    return [NSURL URLWithString:self.userURLString];
}

@end
