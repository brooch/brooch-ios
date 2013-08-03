//
//  BRPostFormImageViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/31/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRPostFormImageViewController.h"
#import "BRPostFormViewController.h"

@interface BRPostFormImageViewController ()

@end

@implementation BRPostFormImageViewController

static int imageCount = 6;

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

    [self setBackgroundImageFor:(self.post.imageId || 0)];

    NSMutableArray *images = [@[] mutableCopy];
    NSMutableArray *thumbs = [@[] mutableCopy];

    for (int i = 0; i < imageCount; i++) {
        images[i]  = [UIImage imageNamed:[NSString stringWithFormat:@"image_bg_%d@2x.jpg", i]];
        thumbs[i]  = [UIImage imageNamed:[NSString stringWithFormat:@"image_bg_thumb_%d@2x.png", i]];
    }

    self.images = images;
    self.thumbs = thumbs;
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

- (void)setBackgroundImageFor:(int)imageId
{
    self.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"image_bg_%d@2x.jpg", imageId]];
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
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(2.5, 2.5, 50, 50)];
    imageView.image = self.thumbs[indexPath.row];
    
    [cell addSubview:imageView];
    [cell bringSubviewToFront:imageView];
    cell.backgroundColor = [UIColor whiteColor];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.imagePicker cellForItemAtIndexPath:indexPath];
    [self setCollectionViewCellSelected:cell];

    self.post.imageId = [NSNumber numberWithInt:indexPath.row];
    [self setBackgroundImageFor:indexPath.row];
}

- (void)setCollectionViewCellSelected:(UICollectionViewCell *)selected
{
    for (int i = 0; i < imageCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewCell *cell = [self.imagePicker cellForItemAtIndexPath:indexPath];

        if (cell == selected) {
            cell.backgroundColor = [UIColor yellowColor];
        }
        else {
            cell.backgroundColor = [UIColor whiteColor];
        }
    }
}

@end
