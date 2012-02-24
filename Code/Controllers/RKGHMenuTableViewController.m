//
//  RKGHMenuTableViewController.m
//  RKGithub
//
//  Created by Blake Watters on 2/22/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import "RKGHMenuTableViewController.h"
#import "RKGHIssuesTableViewController.h"
#import "RKGHPullRequestsTableViewController.h"

// Enum for row indices
enum {
    RKGHMenuTableViewRowIssues = 0,
    RKGHMenuTableViewRowPullRequests,    
};

@interface RKGHMenuTableViewController ()

/**
 A RestKit table controller that serves as the delegate and data source
 for the receiver's table view.
 */
@property (nonatomic, strong) RKTableController *tableController;

@end

@implementation RKGHMenuTableViewController

@synthesize tableController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
     Initialize the RestKit table controller component. The table controller will serve
     as the delegate and data source for the controller's tableView.
     */
    self.tableController = [RKTableController tableControllerForTableViewController:self];
    
    /*
     Create an array of table items from simple text labels. This is a convenient way to create
     very basic textual tables. For each string passed in, an RKTableItem will created with its
     text property initialized to the given string.
     */
    NSArray *tableItems = [RKTableItem tableItemsFromStrings:@"Issues", @"Pull Requests", nil];
    
    /*
     Configure our cell mapping. When working with RestKit tables we configure mappings that direct the table controller 
     rather than working asynchronously within delegate and data source callback methods. For simple table views, this is a
     small convenience and saves on boilerplate code (when compared to iOS 4.x). When working in more complex scenarios including 
     asynchronous network access, it becomes very powerful.
     */
    RKTableViewCellMapping *tableCellMapping = [RKTableViewCellMapping defaultCellMapping];
    tableCellMapping.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    tableCellMapping.onSelectCellForObjectAtIndexPath = ^(UITableViewCell *cell, id object, NSIndexPath* indexPath) {
        switch (indexPath.row) {            
            case RKGHMenuTableViewRowIssues: {
                RKGHIssuesTableViewController *issuesTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"issues"];
                [self.navigationController pushViewController:issuesTableViewController animated:YES];
                break;
            }
            
            case RKGHMenuTableViewRowPullRequests: {
                RKGHPullRequestsTableViewController *pullRequestsTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pullRequests"];
                [self.navigationController pushViewController:pullRequestsTableViewController animated:YES];
                break;
            }                
            
            default: {
                [NSException raise:NSInternalInconsistencyException format:@"Unknown row index selected: %d", indexPath.row];
                break;
            }
        }
    };
    
    /*
     Load the table items into the table controller. A UITableViewCell will be created for each
     table item and state will be object mapped from the table item onto the cell.
     */
    [self.tableController loadTableItems:tableItems withMapping:tableCellMapping];
}

@end
