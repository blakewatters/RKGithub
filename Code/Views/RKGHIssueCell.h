//
//  RKGHIssueCell.h
//  RKGithub
//
//  Created by Brian Morton on 2/24/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RKGHIssueCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *bottomDetailLabel;

@property (nonatomic, strong) NSString *issueNumber;
@property (nonatomic, strong) NSString *creatorName;
@property (nonatomic, strong) NSString *createdAgo;

@end
