//
//  BRPostFormGivenAtViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/31/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRPostFormGivenAtViewController.h"

@interface BRPostFormGivenAtViewController ()

@end

@implementation BRPostFormGivenAtViewController

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

    self.formatter = [[NSDateFormatter alloc] init];
    [self.formatter setDateFormat:@"yyyy-MM-dd"];

    if (![self.parentGivenAtField.text isEqualToString:@"いつ"]) {
        self.datePicker.date = [self.formatter dateFromString:self.parentGivenAtField.text];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelForm:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)onValueChanged:(id)sender
{
    self.parentGivenAtField.text = [self.formatter stringFromDate:self.datePicker.date];
}

@end
