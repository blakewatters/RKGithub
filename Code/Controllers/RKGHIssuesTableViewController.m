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
#import "RKGHLoadingView.h"

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
    self.tableController = [[RKObjectManager sharedManager] fetchedResultsTableControllerForTableViewController:self];
    self.tableController.autoRefreshFromNetwork = YES;
    self.tableController.pullToRefreshEnabled = YES;
    self.tableController.resourcePath = @"/repos/RestKit/RestKit/issues";
    self.tableController.variableHeightRows = YES;
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"createdAt" ascending:NO];
    self.tableController.sortDescriptors = [NSArray arrayWithObject:descriptor];
    
    /**
     Configure the Pull to Refresh View
     */
    NSBundle *restKitResources = [NSBundle restKitResourcesBundle];
    UIImage *arrowImage = [restKitResources imageWithContentsOfResource:@"blueArrow" withExtension:@"png"];
    [[RKRefreshTriggerView appearance] setTitleFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:13]];
    [[RKRefreshTriggerView appearance] setLastUpdatedFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
    [[RKRefreshTriggerView appearance] setArrowImage:arrowImage];
    
    /**
     Configure a basic loading view
     */
    RKGHLoadingView *loadingView = [[RKGHLoadingView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    loadingView.center = self.tableView.center;
    self.tableController.loadingView = loadingView;
    
    /**
     Setup some images for various table states
     */
    self.tableController.imageForOffline = [UIImage imageNamed:@"offline.png"];
    self.tableController.imageForError = [UIImage imageNamed:@"error.png"];
    self.tableController.imageForEmpty = [UIImage imageNamed:@"empty.png"];
    
    /**
     Configure our RKGHIssue -> UITableViewCell mappings. When RestKit loads the
     remote resource collection, the JSON payload will be object mapped into local
     RKGHIssue instances on a background thread. Once the payload has been processed,
     the table controller will object map the RKGHIssue instances into table cells and 
     render the tableView.
     */
    RKTableViewCellMapping *cellMapping = [RKTableViewCellMapping cellMapping];
    cellMapping.cellClassName = @"RKGHIssueCell";
    cellMapping.reuseIdentifier = @"RKGHIssue";
    cellMapping.rowHeight = 100.0;
    [cellMapping mapKeyPath:@"title" toAttribute:@"titleLabel.text"];
    [cellMapping mapKeyPath:@"body" toAttribute:@"descriptionLabel.text"];
    [cellMapping mapKeyPath:@"number" toAttribute:@"issueNumber"];
    [cellMapping mapKeyPath:@"user.login" toAttribute:@"creatorName"];
    [cellMapping mapKeyPath:@"createdAgo" toAttribute:@"createdAgo"];
    
    [tableController mapObjectsWithClass:[RKGHIssue class] toTableCellsWithMapping:cellMapping];
    
    /**
     Use a custom Nib to draw our table cells for RKGHIssue objects
     */
    [self.tableView registerNib:[UINib nibWithNibName:@"RKGHIssueCell" bundle:nil] forCellReuseIdentifier:@"RKGHIssue"];
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
