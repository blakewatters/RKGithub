//
//  RKGHMappingProviderTest.m
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
#import "RKGHIssue.h"

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface RKGHMappingProviderTest : SenTestCase

@end

@implementation RKGHMappingProviderTest

- (void)setUp
{
    [RKTestFactory setUp];
}

- (void)tearDown
{
    [RKTestFactory tearDown];
}

- (void)testLoadingOfIssues
{
    RKManagedObjectStore *objectStore = [RKTestFactory managedObjectStore];
    RKGHMappingProvider *mappingProvider = [RKGHMappingProvider mappingProviderWithObjectStore:objectStore];
    RKTestResponseLoader *responseLoader = [RKTestResponseLoader responseLoader];
    RKURL *URL = [[RKTestFactory baseURL] URLByAppendingResourcePath:@"/repos/RestKit/RestKit/issues"];
    RKObjectLoader *objectLoader = [RKObjectLoader loaderWithURL:URL mappingProvider:mappingProvider];
    objectLoader.delegate = responseLoader;
    [objectLoader sendAsynchronously];
    [responseLoader waitForResponse];
    
    STAssertEquals(YES, responseLoader.wasSuccessful, nil);
    RKGHIssue *issue = [responseLoader.objects objectAtIndex:0];
    STAssertNotNil(issue, @"Expected issue not to be nil");
    STAssertEqualObjects(issue.title, @"Found a bug", nil);
}

@end
