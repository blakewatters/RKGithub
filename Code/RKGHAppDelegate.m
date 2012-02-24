//
//  RKGHAppDelegate.m
//  RKGithub
//
//  Created by Blake Watters on 2/15/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>

#import "RKGHAppDelegate.h"
#import "RKGHMappingProvider.h"
#import "RKGHPullRequestsTableViewController.h"

@interface RKGHAppDelegate ()
@property (nonatomic, strong, readwrite) RKObjectManager *objectManager;
@property (nonatomic, strong, readwrite) RKManagedObjectStore *objectStore;
@end

@implementation RKGHAppDelegate

@synthesize window = _window;
@synthesize objectManager;
@synthesize objectStore;

- (void)initializeRestKit
{
    self.objectManager = [RKObjectManager managerWithBaseURLString:@"https://api.github.com/"];
    self.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"RKGithub.sqlite"];
    self.objectManager.objectStore = self.objectStore;
    self.objectManager.mappingProvider = [RKGHMappingProvider mappingProviderWithObjectStore:self.objectStore];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initializeRestKit];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    NSError *error = nil;
    if (! [self.objectStore save:&error]) {
        RKLogError(@"Failed to save RestKit managed object store: %@", error);
    }
}

@end
