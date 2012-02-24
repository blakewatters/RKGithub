//
//  RKGHIssueTest.m
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
#import "RKGHIssue.h"
#import "RKGHUser.h"
#import "RKGHMilestone.h"

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface RKGHIssueTest : SenTestCase

@end

@implementation RKGHIssueTest

- (void)setUp
{
    [RKTestFactory setUp];
}

- (void)tearDown
{
    [RKTestFactory tearDown];
}

#pragma mark - RKGHIssue Object Mapping

- (RKMappingTest *)mappingTest
{
    id fixtureData = [RKTestFixture parsedObjectWithContentsOfFixture:@"GET_issues.json"];
    RKManagedObjectStore *objectStore = [RKTestFactory objectStore];
    
    RKGHMappingProvider *mappingProvider = [RKGHMappingProvider mappingProviderWithObjectStore:objectStore];
    RKObjectMapping *mapping = (RKObjectMapping *) [mappingProvider issueObjectMapping];
    
    return [RKMappingTest testForMapping:mapping object:fixtureData];
}

#pragma mark Attribute Mappings

- (void)testMappingOfTitle {
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"title" toKeyPath:@"title" withValue:@"Found a bug"];
    [mappingTest verify];
}

- (void)testMappingOfURL {
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"url" toKeyPath:@"issueURLString" withValue:@"https://api.github.com/repos/octocat/Hello-World/issues/1"];
    [mappingTest verify];
}

- (void)testMappingOfHtmlURL {
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"html_url" toKeyPath:@"htmlURLString" withValue:@"https://github.com/octocat/Hello-World/issues/1"];
    [mappingTest verify];
}

- (void)testMappingOfNumber {
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"number" toKeyPath:@"number" withValue:[NSNumber numberWithInt:1347]];
    [mappingTest verify];
}

- (void)testMappingOfState {
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"state" toKeyPath:@"state" withValue:@"open"];
    [mappingTest verify];
}

- (void)testMappingOfBody {
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"body" toKeyPath:@"body" withValue:@"I'm having a problem with this."];
    [mappingTest verify];
}

- (void)testMappingOfCommentsNumber {
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"comments" toKeyPath:@"commentsNumber" withValue:[NSNumber numberWithInt:0]];
    [mappingTest verify];
}

- (void)testMappingOfClosedAt {
    // Our fixture is null, nothing to expect
    // Add support for..
    // [mappingTest rejectMappingFromKeyPath:toKeyPath:] ??
}

- (void)testMappingOfCreatedAt {
    RKMappingTest *mappingTest = [self mappingTest];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];    
    NSDate *createdAt = [dateFormatter dateFromString:@"2011-04-22 13:33:48 +0000"];
    [mappingTest expectMappingFromKeyPath:@"created_at" toKeyPath:@"createdAt" withValue:createdAt];
    [mappingTest verify];
}

- (void)testMappingOfUpdatedAt {
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"updated_at" toKeyPath:@"updatedAt" passingTest:^BOOL(RKObjectAttributeMapping *mapping, id value) {
        return [[(NSDate *)value description] isEqualToString:@"2011-04-22 13:33:48 +0000"];
    }];
    [mappingTest verify];
}

#pragma mark Relationship Mappings

- (void)testMappingOfUser {
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"user" toKeyPath:@"user" passingTest:^BOOL(RKObjectAttributeMapping *mapping, id value) {
        return [value isKindOfClass:[RKGHUser class]] && [[value login] isEqualToString:@"octocat"];
    }];
    [mappingTest verify];
}

- (void)testMappingOfAssignee {
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"assignee" toKeyPath:@"assignee" passingTest:^BOOL(RKObjectAttributeMapping *mapping, id value) {
        return [value isKindOfClass:[RKGHUser class]] && [[value login] isEqualToString:@"octocat"];
    }];
    [mappingTest verify];
}

- (void)testMappingOfMilestone {
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"milestone" toKeyPath:@"milestone" passingTest:^BOOL(RKObjectAttributeMapping *mapping, id value) {
        return [value isKindOfClass:[RKGHMilestone class]] && [[value title] isEqualToString:@"v1.0"];
    }];
    [mappingTest verify];    
}

#pragma mark - Convenience Accessors

- (void)testCommentsCountReturnsValueOfCommentsNumber {
    [RKTestFactory objectStore];
    RKGHIssue *issue = [RKGHIssue createEntity];
    issue.commentsNumber = [NSNumber numberWithInt:1234];
    NSUInteger count = 1234;
    STAssertEquals(count, issue.commentsCount, nil);
}

- (void)testHtmlURLReturnsValueOfHtmlURLString {
    [RKTestFactory objectStore];
    RKGHIssue *issue = [RKGHIssue createEntity];
    issue.htmlURLString = @"http://restkit.org/";
    STAssertEqualObjects([NSURL URLWithString:@"http://restkit.org/"], issue.htmlURL, nil);
}

- (void)testIssueURLReturnsValueOfIssueURLString {
    [RKTestFactory objectStore];
    RKGHIssue *issue = [RKGHIssue createEntity];
    issue.issueURLString = @"http://restkit.org/";
    STAssertEqualObjects([NSURL URLWithString:@"http://restkit.org/"], issue.issueURL, nil);
}

@end
