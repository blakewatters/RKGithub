//
//  RKGHMappingProvider.m
//  RKGithub
//
//  Created by Blake Watters on 2/16/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import "RKGHMappingProvider.h"
#import "RKGHPullRequest.h"
#import "RKGHIssue.h"
#import "RKGHUser.h"
#import "RKGHMilestone.h"

@implementation RKGHMappingProvider

@synthesize objectStore;

+ (id)mappingProviderWithObjectStore:(RKManagedObjectStore *)objectStore {
    return [[self alloc] initWithObjectStore:objectStore];    
}

- (id)initWithObjectStore:(RKManagedObjectStore *)theObjectStore {
    self = [super init];
    if (self) {
        self.objectStore = theObjectStore;
        
        [self setObjectMapping:[self issueObjectMapping] forResourcePathPattern:@"/repos/:user/:repo/issues" withFetchRequestBlock:^NSFetchRequest *(NSString *resourcePath) {
            // NOTE: We could use RKPathMatcher here to easily tokenize the requested resourcePath
            NSFetchRequest *fetchRequest = [RKGHIssue fetchRequest];
            fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
            return fetchRequest;
        }];
        [self setObjectMapping:[self pullRequestObjectMapping] forResourcePathPattern:@"/repos/:user/:repo/pulls"];
    }
    
    return self;
}

- (RKManagedObjectMapping *)userObjectMapping {
    RKManagedObjectMapping *mapping =  [RKManagedObjectMapping mappingForEntityWithName:@"RKGHUser" inManagedObjectStore:self.objectStore];
    mapping.primaryKeyAttribute = @"userID";
    [mapping mapKeyPathsToAttributes:
     @"login", @"login",
     @"id", @"userID",
     @"avatar_url", @"avatarURLString",
     @"gravatar_id", @"gravatarID",
     @"url", @"userURLString",
     nil];
    
    return mapping;
}

- (RKManagedObjectMapping *)milestoneObjectMapping {
    RKManagedObjectMapping *mapping = [RKManagedObjectMapping mappingForEntityWithName:@"RKGHMilestone" inManagedObjectStore:self.objectStore];
    mapping.primaryKeyAttribute = @"number";
    [mapping mapKeyPathsToAttributes:
     @"url", @"milestoneURLString",
     @"number", @"number",
     @"state", @"state",
     @"title", @"title",
     @"description", @"descriptionText",
     @"open_issues", @"openIssues",
     @"closed_issues", @"closedIssues",
     @"created_at", @"createdAt",
     @"due_on", @"dueOn", 
     nil];
    
    [mapping mapKeyPath:@"creator" toRelationship:@"creator" withMapping:[self userObjectMapping]];

    return mapping;
}

- (RKManagedObjectMapping *)issueObjectMapping {
    RKManagedObjectMapping *mapping = [RKManagedObjectMapping mappingForClass:[RKGHIssue class] 
                                                         inManagedObjectStore:self.objectStore];
    mapping.primaryKeyAttribute = @"number";
    [mapping mapAttributes:@"state", @"number", @"title", @"body", nil];
    [mapping mapKeyPathsToAttributes:
     @"url", @"issueURLString",
     @"html_url", @"htmlURLString",
     @"comments", @"commentsNumber",
     @"closed_at", @"closedAt",
     @"created_at", @"createdAt",
     @"updated_at", @"updatedAt",
     nil];
    
    // Relationships
    [mapping mapKeyPath:@"user" toRelationship:@"user" withMapping:[self userObjectMapping]];
    [mapping mapKeyPath:@"assignee" toRelationship:@"assignee" withMapping:[self userObjectMapping]];
    [mapping mapKeyPath:@"milestone" toRelationship:@"milestone" withMapping:[self milestoneObjectMapping]];
    
    return mapping;    
}

- (RKObjectMapping *)pullRequestObjectMapping {
    RKObjectMapping *mapping =  [RKObjectMapping mappingForClass:[RKGHPullRequest class]];
    [mapping mapAttributes:@"number", @"state", @"title", @"body", nil];
    [mapping mapKeyPathsToAttributes:
     @"url", @"selfURL",
     @"diff_url", @"diffURL",
     @"patch_url", @"patchURL",
     @"issue_url", @"issueURL",
     @"created_at", @"createdAt",
     @"updated_at", @"updatedAt",
     @"closed_at", @"closedAt",
     @"merged_at", @"mergedAt",
     nil];
    
    return mapping;
}

@end
