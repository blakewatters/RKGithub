//
//  RKGHTestEnvironment.m
//  RKGithub
//
//  Created by Blake Watters on 2/16/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import "RKGHTestEnvironment.h"
#import "RKGHMappingProvider.h"

@implementation RKTestFactory (RKGithub)

- (void)didInitialize {    
    /*
     Configure the RestKit test fixture support to load fixtures from the bundle
     containing the RKGithub Test Cases
     */
    [RKTestFixture setFixtureBundle:[NSBundle bundleWithIdentifier:@"org.restkit.RKGithubTests"]];
}

@end
