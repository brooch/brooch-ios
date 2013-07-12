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

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tutorialImages = @[@"init_page_1.png", @"init_page_2.png", @"init_page_3.png", @"init_page_4.png"];
    
    for (int i = 0; i < [self.tutorialImages count]; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self.tutorialImages objectAtIndex:i]]];

        [self.scrollView addSubview:imageView];
    }

    NSLog(@"%f", self.scrollView.frame.size.height);
    
    self.scrollView.contentSize = CGSizeMake(
        self.scrollView.frame.size.width * [self.tutorialImages count],
        self.scrollView.frame.size.height
    );
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControll.currentPage = page;
}

@end
