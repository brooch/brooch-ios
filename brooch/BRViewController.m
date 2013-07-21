//
//  BRViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/10/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRViewController.h"
#import "BRUser.h"

@interface BRViewController ()

@end

@implementation BRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.helloLabel.text = [[BRUser sharedManager] name];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstViewReturnActionForSegue:(UIStoryboardSegue *)segue
{
    NSLog(@"First view return action invoked.");
}

@end
