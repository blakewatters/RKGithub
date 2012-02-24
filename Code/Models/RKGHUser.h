//
//  RKGHUser.h
//  RKGithub
//
//  Created by Blake Watters on 2/22/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RKGHUser : NSManagedObject

@property (nonatomic, retain) NSString *login;
@property (nonatomic, retain) NSNumber *userID;
@property (nonatomic, retain) NSString *avatarURLString;
@property (nonatomic, retain) NSString *gravatarID;
@property (nonatomic, retain) NSString *userURLString;

@property (nonatomic, readonly) NSURL *avatarURL;
@property (nonatomic, readonly) NSURL *userURL;

@end
