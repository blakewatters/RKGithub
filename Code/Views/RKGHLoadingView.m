//
//  RKGHLoadingView.m
//  RKGithub
//
//  Created by Blake Watters on 2/24/12.
//  Copyright (c) 2012 RestKit. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "RKGHLoadingView.h"

@interface RKGHLoadingView ()
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation RKGHLoadingView

@synthesize activityIndicator;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        self.backgroundColor = [UIColor grayColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.activityIndicator.hidesWhenStopped = NO;
        [self.activityIndicator startAnimating];
        [self addSubview:self.activityIndicator];
        self.activityIndicator.center = self.center;
    }
    return self;
}

- (void)dealloc {
    [self.activityIndicator removeFromSuperview];
}

@end
