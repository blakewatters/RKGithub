//
//  RKGHIssuesTableViewController.m
//  RKGithub
//
//  Created by Blake Watters on 2/22/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import <RestKit/RestKit.h>
#import <RestKit/UI.h>
#import "RKGHIssue.h"
#import "RKGHIssuesTableViewController.h"
#import "RKGHIssueDetailTableViewController.h"

@interface RKGHIssuesTableViewController ()
@property (nonatomic, strong) RKFetchedResultsTableController *tableController;
@end

@implementation RKGHIssuesTableViewController

@synthesize tableController;

- (void)viewDidLoad
{
    [super viewDidLoad];

    /**
     Configure the RestKit table controller to drive our view
     */
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/UI", RKLogLevelTrace);
    self.tableController = [[RKObjectManager sharedManager] fetchedResultsTableControllerForTableViewController:self];
    self.tableController.autoRefreshFromNetwork = YES;
    self.tableController.pullToRefreshEnabled = YES;
    self.tableController.resourcePath = @"/repos/RestKit/RestKit/issues";
    // TODO: Add a loading view...
    
    /**
     Configure our RKGHIssue -> UITableViewCell mappings. When RestKit loads the
     remote resource collection, the JSON payload will be object mapped into local
     RKGHIssue instances on a background thread. Once the payload has been processed,
     the table controller will object map the RKGHIssue instances into table cells and 
     render the tableView.
     */
    RKTableViewCellMapping *cellMapping = [RKTableViewCellMapping cellMapping];
    cellMapping.reuseIdentifier = @"RKGHIssueCell";
    [cellMapping mapKeyPath:@"title" toAttribute:@"textLabel.text"];
    [cellMapping mapKeyPath:@"body" toAttribute:@"detailTextLabel.text"];
    
    [tableController mapObjectsWithClass:[RKGHIssue class] toTableCellsWithMapping:cellMapping];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /**
     Load the table view!
     */
    [tableController loadTable];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetail"]) {        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        RKGHIssue *issue = [self.tableController objectForRowAtIndexPath:indexPath];
        [[segue destinationViewController] setIssue:issue];
    }
}

@end
