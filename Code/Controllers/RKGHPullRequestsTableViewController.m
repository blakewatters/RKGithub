//
//  RKGHPullRequestsTableViewController.m
//  RKGithub
//
//  Created by Blake Watters on 2/15/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import "RKGHPullRequestsTableViewController.h"
#import "RKGHPullRequestViewController.h"
#import "RKGHPullRequest.h"

@interface RKGHPullRequestsTableViewController ()
@property (nonatomic, strong) RKTableController *tableController;
@end

@implementation RKGHPullRequestsTableViewController

@synthesize tableController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Setup the RestKit table controlelr
    self.tableController = [[RKObjectManager sharedManager] tableControllerForTableViewController:self];    
    
    /**
     Configure our RKGHPullRequest -> UITableViewCell mappings. When RestKit loads the
     remote resource collection, the JSON payload will be object mapped into local
     RKGHIssue instances on a background thread. Once the payload has been processed,
     the table controller will object map the RKGHPullRequest instances into table cells and 
     render the tableView.
     */
    RKTableViewCellMapping *cellMapping = [RKTableViewCellMapping cellMapping];
    cellMapping.reuseIdentifier = @"RKGHPullRequestCell";
    [cellMapping mapKeyPath:@"title" toAttribute:@"textLabel.text"];
    [cellMapping mapKeyPath:@"body" toAttribute:@"detailTextLabel.text"];
    
    [self.tableController mapObjectsWithClass:[RKGHPullRequest class] toTableCellsWithMapping:cellMapping];        
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.tableController loadTableFromResourcePath:@"/repos/RestKit/RestKit/pulls"];
}

@end
