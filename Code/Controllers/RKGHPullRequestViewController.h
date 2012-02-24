//
//  RKGHDetailViewController.h
//  RKGithub
//
//  Created by Blake Watters on 2/15/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKGHPullRequestViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end
