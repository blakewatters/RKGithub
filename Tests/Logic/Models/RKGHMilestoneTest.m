//
//  RKGHMilestoneTest.m
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
#import "RKGHMilestone.h"

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface RKGHMilestoneTest : SenTestCase

@end

@implementation RKGHMilestoneTest

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
    id fixtureData = [RKTestFixture parsedObjectWithContentsOfFixture:@"GET_milestones.json"];
    RKManagedObjectStore *objectStore = [RKTestFactory objectStore];
    
    RKGHMappingProvider *mappingProvider = [RKGHMappingProvider mappingProviderWithObjectStore:objectStore];
    RKManagedObjectMapping *mapping = [mappingProvider milestoneObjectMapping];
    
    RKMappingTest *mappingTest = [RKMappingTest testForMapping:mapping object:fixtureData];
    mappingTest.verifiesOnExpect = YES;
    return mappingTest;
}

#pragma mark Attribute Mappings

- (void)testMappingOfTitle
{
    STAssertNoThrow([[self mappingTest] expectMappingFromKeyPath:@"title" toKeyPath:@"title" withValue:@"v1.0"], nil);
}

- (void)testMappingOfURL
{
    STAssertNoThrow([[self mappingTest] expectMappingFromKeyPath:@"url" toKeyPath:@"milestoneURLString" withValue:@"https://api.github.com/repos/octocat/Hello-World/milestones/1"], nil);
}

- (void)testMappingOfNumber
{
    STAssertNoThrow([[self mappingTest] expectMappingFromKeyPath:@"number" toKeyPath:@"number" withValue:[NSNumber numberWithInt:1]], nil);
}

- (void)testMappingOfState
{
    STAssertNoThrow([[self mappingTest] expectMappingFromKeyPath:@"state" toKeyPath:@"state" withValue:@"open"], nil);
}

- (void)testMappingOfDescription
{
    STAssertNoThrow([[self mappingTest] expectMappingFromKeyPath:@"description" toKeyPath:@"descriptionText" withValue:@""], nil);
}

- (void)testMappingOfOpenIssues
{
    STAssertNoThrow([[self mappingTest] expectMappingFromKeyPath:@"open_issues" toKeyPath:@"openIssues" withValue:[NSNumber numberWithInt:4]], nil);
}

- (void)testMappingOfClosedIssues {
    STAssertNoThrow([[self mappingTest] expectMappingFromKeyPath:@"closed_issues" toKeyPath:@"closedIssues" withValue:[NSNumber numberWithInt:8]], nil);
}

- (void)testMappingOfDueOn
{
    // Our fixture is null, nothing to expect
    // Add support for..
    // [mappingTest rejectMappingFromKeyPath:toKeyPath:] ??
}

- (void)testMappingOfCreatedAt
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];    
    NSDate *createdAt = [dateFormatter dateFromString:@"2011-04-22 13:33:48 +0000"];
    STAssertNoThrow([[self mappingTest] expectMappingFromKeyPath:@"created_at" toKeyPath:@"createdAt" withValue:createdAt], nil);
}

#pragma mark Relationship Mappings

- (void)testMappingOfCreator
{
    RKMappingTest *mappingTest = [self mappingTest];
    [mappingTest expectMappingFromKeyPath:@"creator" toKeyPath:@"creator" passingTest:^BOOL(RKObjectAttributeMapping *mapping, id value) {
        return [value isKindOfClass:[RKGHUser class]] && [[value login] isEqualToString:@"octocat"];
    }];
    STAssertNoThrow([mappingTest verify], nil);
}

- (void)testMappingOfIssues
{
    // Not mapped as nested...
}

- (void)testMilestoneURL
{
    [RKTestFactory objectStore];
    RKGHMilestone *milestone = [RKGHMilestone createEntity];
    milestone.milestoneURLString = @"https://api.github.com/repos/octocat/Hello-World/milestones/1";
    STAssertEqualObjects([NSURL URLWithString:@"https://api.github.com/repos/octocat/Hello-World/milestones/1"], milestone.milestoneURL, nil);
}

@end
