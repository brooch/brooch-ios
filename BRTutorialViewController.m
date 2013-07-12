//
//  BRTutorialViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/12/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRTutorialViewController.h"

@interface BRTutorialViewController ()

@end

@implementation BRTutorialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    self.tutorialImages = @[
        [UIImage imageNamed:@"tutorial_1"],
        [UIImage imageNamed:@"tutorial_2"],
        [UIImage imageNamed:@"tutorial_3"],
        [UIImage imageNamed:@"tutorial_4"]
    ];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.tutorialImages.count, self.scrollView.frame.size.height);
    int scrollWidth = 0;

    for (int i = 0; i < self.tutorialImages.count; i++) {
        CGRect frame;
        frame.size.height = self.scrollView.frame.size.height;
        frame.size.width  = self.scrollView.frame.size.width;
        frame.origin.x    = self.scrollView.frame.origin.x + scrollWidth;
        frame.origin.y    = self.scrollView.frame.origin.y;

        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = [self.tutorialImages objectAtIndex:i];
        imageView.frame = frame;

        [self.scrollView addSubview:imageView];
        [self.scrollView sendSubviewToBack:imageView];

        scrollWidth += self.scrollView.frame.size.width;
    }

    self.pageControll.currentPage = 0;
    self.pageControll.numberOfPages = self.tutorialImages.count;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    self.scrollView     = nil;
    self.pageControll   = nil;
    self.tutorialImages = nil;
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControll.currentPage = page;
}

@end
