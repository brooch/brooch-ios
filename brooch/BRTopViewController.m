//
//  BRViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 7/10/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRTopViewController.h"
#import "BRPostDetailViewController.h"
#import "BRUserModel.h"
#import "BRPostModel.h"
#import "BRPostTableViewCell.h"
#import "BRPostFormViewController.h"

@interface BRTopViewController ()

@property (nonatomic) NSInteger currentPostPostion;

@end

@implementation BRTopViewController

static NSString *cellIdentifier = @"postListViewCell";
static NSString *showPostSegueIdentifier = @"showPostDetail";

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"BRPostTableViewCell" bundle:nil]
         forCellReuseIdentifier:cellIdentifier];

    BRUserModel *user = [BRUserModel sharedManager];
    [user posts:@{@"offset": @0, @"limit": @10}
        success:^(NSHTTPURLResponse *response, NSArray *result) {
            NSMutableArray *posts = [@[] mutableCopy];

            for (NSDictionary *post in result) {
                [posts addObject:[[BRPostModel alloc] initWithDictionary:post]];
            }

            self.posts = posts;
            [self.tableView reloadData];
        } failure:^(NSHTTPURLResponse *response, NSDictionary *result) {
            NSLog(@"%@", result);
        } error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIImage *image         = [UIImage imageNamed:@"home_tag_bg@2x.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, image.size.width, image.size.height)];
    UIView  *view          = [[UIView alloc] init];
    UILabel *label         = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 0.0, 310.0, 40.0)];

    view.backgroundColor = [UIColor colorWithPatternImage:image];

    label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"HiraKakuProN-W3" size:14.0];
    label.textColor = [UIColor grayColor];
    label.text = @"all brooches ∵";
    label.backgroundColor = [UIColor clearColor];

    // なんか縦にそろわないのでむりやりframeいじってる…
    CGRect frame = label.frame;
    label.frame = CGRectMake(frame.origin.x, frame.origin.y + 3, frame.size.width, frame.size.height);
    
    [view addSubview:imageView];
    [view addSubview:label];
    [view bringSubviewToFront:label];

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{  
    BRPostModel *post = self.posts[indexPath.row];
    BRPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
        cell = [[BRPostTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    cell.delegate = self;
    cell.post = post;
    cell.textLabel.text = post.text;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:showPostSegueIdentifier sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:showPostSegueIdentifier]) {
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        self.currentPostPostion = path.row;
        BRPostModel *post = self.posts[path.row];

        [segue.destinationViewController setCurrentPost:post];
        [segue.destinationViewController setTopVC:self];
    }

    if ([[segue identifier] isEqualToString:@"showPostForm"]) {
        [segue.destinationViewController setTopVC:self];

        BRPostModel *post = [[BRPostModel alloc] initWithDictionary:@{@"author": [@{@"name":@""} mutableCopy]}];
        [segue.destinationViewController setPost:post];
    }
}

-(void)didPushDeletePostButton:(id)sender
                        post:(BRPostModel *)post
{
    BRUserModel *user = [BRUserModel sharedManager];
    [user deletePost:post
             success:^(NSHTTPURLResponse *response, NSDictionary *result){
                 NSLog(@"deleted");
             } failure:^(NSHTTPURLResponse *response, NSDictionary *result){
                 NSLog(@"%@", result);
             } error:nil];
}

// TODO: ダサいのでiteratorパタンにする
- (BOOL)hasNextPost
{
    return self.currentPostPostion != [self.posts count] - 1;
}

- (BOOL)hasPrevPost
{
    return self.currentPostPostion > 0;
}

- (BRPostModel *)nextPost
{
    BRPostModel *post = self.posts[self.currentPostPostion + 1];
    self.currentPostPostion += 1;
    return post;

}

- (BRPostModel *)prevPost
{
    BRPostModel *post = self.posts[self.currentPostPostion - 1];
    self.currentPostPostion -= 1;
    return post;
    
}

@end
