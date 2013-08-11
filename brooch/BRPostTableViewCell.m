//
//  BRPostTableViewCell.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/31/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRPostTableViewCell.h"

@interface BRPostTableViewCell ()

@property (nonatomic) BOOL isOpened;

@end

@implementation BRPostTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)moveSlideView:(int)to
{
    [UIView beginAnimations:nil context:nil];
    
    {
        [UIView setAnimationDuration:0.1];
        CGRect frame = self.slideView.frame;
        frame.origin.x = frame.origin.x + to;
        self.slideView.frame = frame;
    }
    
    [UIView commitAnimations];
}

- (void)showBackgroundView
{
    if (!self.isOpened) {
        [self moveSlideView:40];
        self.isOpened = YES;
    }
}

- (void)hideBackgroundView
{
    if (self.isOpened) {
        [self moveSlideView:-40];
        self.isOpened = NO;
    }
}

- (IBAction)deletePost:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"投稿の削除"
                                                        message:@"本当に削除しますか？"
                                                       delegate:self
                                              cancelButtonTitle:@"いいえ"
                                              otherButtonTitles:@"はい", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            [self hideBackgroundView];
            [self.delegate didPushDeletePostButton:self
                                              post:self.post];
            break;
    }
}

@end
