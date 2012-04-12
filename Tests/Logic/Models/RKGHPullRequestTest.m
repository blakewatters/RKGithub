//
//  RKGHPullRequestTest.m
//  RKGithub
//
//  Created by Blake Watters on 2/16/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>
#import <RestKit/Testing.h>

#import "RKGHMappingProvider.h"
#import "RKGHPullRequest.h"

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface RKGHPullRequestTest : SenTestCase
@end

@implementation RKGHPullRequestTest

- (void)setUp
{
    [RKTestFactory setUp];
}

- (void)tearDown
{
    [RKTestFactory tearDown];
}

#pragma mark - RKGHPullRequest Object Mapping

- (void)testMappingOfTitle
{
    id fixtureData = [RKTestFixture parsedObjectWithContentsOfFixture:@"GET_pulls.json"];
    RKManagedObjectStore *objectStore = [RKTestFactory managedObjectStore];
    
    RKGHMappingProvider *mappingProvider = [RKGHMappingProvider mappingProviderWithObjectStore:objectStore];
    RKObjectMapping *mapping = (RKObjectMapping *) [mappingProvider pullRequestObjectMapping];
    
    RKMappingTest *test = [RKMappingTest testForMapping:mapping object:fixtureData];
    [test expectMappingFromKeyPath:@"title" toKeyPath:@"title" withValue:@"new-feature"];
    STAssertNoThrow([test verify], nil);
}

@end
