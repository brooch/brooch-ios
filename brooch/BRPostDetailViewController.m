//
//  BRPostDetailViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/27/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRPostDetailViewController.h"
#import "BRTopViewController.h"
#import "BRPostFormViewController.h"

@interface BRPostDetailViewController ()
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

- (void)viewWillAppear:(BOOL)animated
{
    self.backgroundView.image = self.currentPost.imageAsUIImage;
    [self setTextViewText];
    [self setAuthorViewText];
}

- (void)setTextViewText
{
    CGFloat customLineHeight    = 29.0;
    CGFloat customLetterSpacing = 2.8;

    UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:13];

    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    paragrahStyle.minimumLineHeight = customLineHeight;
    paragrahStyle.maximumLineHeight = customLineHeight;
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self.currentPost.text];

    [attributedText addAttribute:NSKernAttributeName
                           value:[NSNumber numberWithFloat:customLetterSpacing]
                           range:NSMakeRange(0, attributedText.length)];
    [attributedText addAttribute:NSParagraphStyleAttributeName
                           value:paragrahStyle
                           range:NSMakeRange(0, attributedText.length)];

    self.textView.font = font;
    self.textView.attributedText = attributedText;
}

- (void)setAuthorViewText
{
    CGFloat customLetterSpacing = 2.8;
    
    UIFont *font = [UIFont fontWithName:@"HiraKakuProN-W3" size:13];
    
    NSMutableParagraphStyle *paragrahStyle = [[NSMutableParagraphStyle alloc] init];
    paragrahStyle.alignment = NSTextAlignmentRight;
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self.currentPost.author[@"name"]];
    
    [attributedText addAttribute:NSKernAttributeName
                           value:[NSNumber numberWithFloat:customLetterSpacing]
                           range:NSMakeRange(0, attributedText.length)];
    [attributedText addAttribute:NSParagraphStyleAttributeName
                           value:paragrahStyle
                           range:NSMakeRange(0, attributedText.length)];
    
    self.authorView.font = font;
    self.authorView.attributedText = attributedText;
}

- (void)updateViewByCurrentPost
{
    [UIView beginAnimations:nil context:nil];

    {
        [UIView setAnimationDuration:1.2];
        self.textView.alpha  = 0.0;
        [self setTextViewText];
        self.textView.alpha  = 1.0;
        
        self.authorView.alpha = 0.0;
        [self setAuthorViewText];
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

- (IBAction)closePostDetail:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)showNextPost:(id)sender
{
    if ([[self topVC] hasNextPost]) {
        self.currentPost = [[self topVC] nextPost];
        [self updateViewByCurrentPost];
    }
}

// なぜかきかない…
- (IBAction)showPrevPost:(id)sender
{
    if ([[self topVC] hasPrevPost]) {
        self.currentPost = [[self topVC] prevPost];
        [self updateViewByCurrentPost];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showPostForm"]) {
        [segue.destinationViewController setPost:self.currentPost];
        [segue.destinationViewController setTopVC:self.topVC];
    }
}

@end
