//
//  BRPostFormImageViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/31/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRPostFormImageViewController.h"

@interface BRPostFormImageViewController ()

@end

@implementation BRPostFormImageViewController

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

    self.images = @[
        [UIImage imageNamed:@"intro_1"],
        [UIImage imageNamed:@"intro_2"],
        [UIImage imageNamed:@"intro_3"],
        [UIImage imageNamed:@"intro_4"],
        [UIImage imageNamed:@"intro_1"],
        [UIImage imageNamed:@"intro_2"],
        [UIImage imageNamed:@"intro_3"],
        [UIImage imageNamed:@"intro_4"]
    ];
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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.images count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCollection" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    imageView.image = self.images[indexPath.row];
    
    [cell addSubview:imageView];
    return cell;
}

@end
