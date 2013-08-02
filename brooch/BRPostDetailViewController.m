//
//  BRPostDetailViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/27/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRPostDetailViewController.h"
#import "BRTopViewController.h"

@interface BRPostDetailViewController ()

@property (nonatomic, strong) BRTopViewController *parent;

@end

@implementation BRPostDetailViewController

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
    [self updateViewByCurrentPost];
}

- (void)updateViewByCurrentPost
{
    [UIView beginAnimations:nil context:nil];

    {
        [UIView setAnimationDuration:1.5];
        self.textView.alpha  = 0.0;
        self.textView.text   = self.currentPost.text;
        self.textView.alpha  = 1.0;
        
        self.authorView.alpha = 0.0;
        self.authorView.text  = self.currentPost.author[@"name"];
        self.authorView.alpha = 1.0;

        self.backgroundView.alpha = 0.0;
        self.backgroundView.image = self.currentPost.imageAsUIImage;
        self.backgroundView.alpha = 1.0;
    }

    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BRTopViewController *) parent
{
    if (!_parent) {
        UINavigationController *navi = (UINavigationController *)self.presentingViewController;
        NSArray *controllers = navi.viewControllers;
        BRTopViewController *parent = (BRTopViewController *)[controllers objectAtIndex:0];
        _parent = parent;
    }
    
    return _parent;
}

- (IBAction)closePostDetail:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)showNextPost:(id)sender
{
    if ([[self parent] hasNextPost]) {
        self.currentPost = [[self parent] nextPost];
        [self updateViewByCurrentPost];
    }
}

// なぜかきかない…
- (IBAction)showPrevPost:(id)sender
{
    if ([[self parent] hasPrevPost]) {
        self.currentPost = [[self parent] prevPost];
        [self updateViewByCurrentPost];
    }

}

@end
