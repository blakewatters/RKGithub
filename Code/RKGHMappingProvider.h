//
//  RKGHMappingProvider.h
//  RKGithub
//
//  Created by Blake Watters on 2/16/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>

/**
 The RKGithub application specific mapping provider class. Organizes
 the configuration of object mappings outside of the application delegate
 */
@interface RKGHMappingProvider : RKObjectMappingProvider

/**
 A reference to the RKManagedObjectStore for the RKGithub application
 */
@property (nonatomic, strong) RKManagedObjectStore *objectStore;

///-----------------------------------------------------------------------------
/// @name Initializing a Mapping Provider
///-----------------------------------------------------------------------------

/**
 Create and initialize a mapping provider for the RestKit Github sample applicaion.
 
 @return An initialized RKGHMappingProvider object
 */
+ (id)mappingProviderWithObjectStore:(RKManagedObjectStore *)objectStore;

/**
 Initialize an RKGHMappingProvider with a RestKit managed object store object.
 
 @param objectStore The RKManagedObjectStore with which to initialize the mapping provider.
 @return An initialized RKGHMappingProvider instance.
 */
- (id)initWithObjectStore:(RKManagedObjectStore *)objectStore;

///-----------------------------------------------------------------------------
/// @name Retrieving Issues Managed Object Mappings
///-----------------------------------------------------------------------------

/**
 Create and return a RestKit object mapping suitable for mapping a Github Issue
 resource.
 
 See http://developer.github.com/v3/issues/
 
 @return A RKObjectMapping suitable for mapping a Github issue.
 */
- (RKManagedObjectMapping *)issueObjectMapping;

/**
 Create and return a RestKit object mapping suitable for mapping a Github User
 resource.
 
 See http://developer.github.com/v3/issues/
 
 @return A RKObjectMapping suitable for mapping a Github issue.
 */
- (RKManagedObjectMapping *)userObjectMapping;

- (RKManagedObjectMapping *)milestoneObjectMapping;

///-----------------------------------------------------------------------------
/// @name Retrieving Pull Requests Object Mappings
///-----------------------------------------------------------------------------

/**
 Create and return a RestKit object mapping suitable for mapping a Github Pull Request resource.
 
 See http://developer.github.com/v3/pulls/
 
 @return An RKObjectMapping suitable for mapping a Github pull request.
 */
- (RKObjectMapping *)pullRequestObjectMapping;

@end
