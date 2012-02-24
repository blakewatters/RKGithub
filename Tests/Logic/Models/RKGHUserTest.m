//
//  RKGHUserTest.m
//  RKGithub
//
//  Created by Blake Watters on 2/22/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import <RestKit/Testing.h>

#import "RKGHMappingProvider.h"
#import "RKGHUser.h"

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface RKGHUserTest : SenTestCase

@end

@implementation RKGHUserTest

- (void)setUp
{
    [RKTestFactory setUp];
}

- (void)tearDown
{
    [RKTestFactory tearDown];
}

#pragma mark - Object Mapping

- (RKMappingTest *)mappingTest
{
    id fixtureData = [RKTestFixture parsedObjectWithContentsOfFixture:@"GET_issues.json"];
    NSDictionary *userData = [fixtureData valueForKey:@"user"];
    RKManagedObjectStore *objectStore = [RKTestFactory objectStore];
    
    RKGHMappingProvider *mappingProvider = [RKGHMappingProvider mappingProviderWithObjectStore:objectStore];
    RKManagedObjectMapping *mapping = [mappingProvider userObjectMapping];
    
    return [RKMappingTest testForMapping:mapping object:userData];
}

#pragma mark Attributes

- (void)testMappingOfLogin
{
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"login" toKeyPath:@"login" withValue:@"octocat"];
    STAssertNoThrow([mappingTest verify], nil);
}

- (void)testMappingOfUserID
{
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"id" toKeyPath:@"userID" withValue:[NSNumber numberWithInt:1]];
    STAssertNoThrow([mappingTest verify], nil);
}

- (void)testMappingOfAvatarURLString
{
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"avatar_url" toKeyPath:@"avatarURLString" withValue:@"https://github.com/images/error/octocat_happy.gif"];
    STAssertNoThrow([mappingTest verify], nil);
}

- (void)testMappingOfGravatarID
{
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"gravatar_id" toKeyPath:@"gravatarID" withValue:@"somehexcode"];
    STAssertNoThrow([mappingTest verify], nil);
}

- (void)testMappingOfUserURLString
{
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"url" toKeyPath:@"userURLString" withValue:@"https://api.github.com/users/octocat"];
    STAssertNoThrow([mappingTest verify], nil);
}

#pragma mark - Helper Methods

- (void)testAvatarURL
{
    [RKTestFactory objectStore];
    RKGHUser *user = [RKGHUser createEntity];
    user.avatarURLString = @"https://github.com/images/error/octocat_happy.gif";
    STAssertEqualObjects([NSURL URLWithString:@"https://github.com/images/error/octocat_happy.gif"], user.avatarURL, nil);
}

- (void)testUserURL
{
    [RKTestFactory objectStore];
    RKGHUser *user = [RKGHUser createEntity];
    user.userURLString = @"https://api.github.com/users/octocat";
    STAssertEqualObjects([NSURL URLWithString:@"https://api.github.com/users/octocat"], user.userURL, nil);
}

@end
