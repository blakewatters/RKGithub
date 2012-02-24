//
//  RKGHIssueCell.m
//  RKGithub
//
//  Created by Brian Morton on 2/24/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import "RKGHIssueCell.h"

@implementation RKGHIssueCell
@synthesize titleLabel;
@synthesize descriptionLabel;
@synthesize bottomDetailLabel;
@synthesize issueNumber = _issueNumber;
@synthesize creatorName = _creatorName;
@synthesize createdAgo = _createdAgo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setIssueNumber:(NSString *)issueNumber {
    _issueNumber = issueNumber;
    [self updateBottomDetailLabel];
}

- (void)setCreatorName:(NSString *)creatorName {
    _creatorName = creatorName;
    [self updateBottomDetailLabel];
}

- (void)setCreatedAgo:(NSString *)createdAgo {
    _createdAgo = createdAgo;
    [self updateBottomDetailLabel];
}

- (void)updateBottomDetailLabel {
    self.bottomDetailLabel.text = [NSString stringWithFormat:@"Issue #%@ / %@ / %@", self.issueNumber, self.creatorName, self.createdAgo];
}

@end
