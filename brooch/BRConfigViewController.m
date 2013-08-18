//
//  BRConfigViewController.m
//  brooch
//
//  Created by 栗林 健太郎 on 8/12/13.
//  Copyright (c) 2013 栗林 健太郎. All rights reserved.
//

#import "BRConfigViewController.h"
#import "BRConfigWebViewController.h"

@interface BRConfigViewController ()

@end

@implementation BRConfigViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *url;

    if ([[segue identifier] isEqualToString:@"showTerms"]) {
#ifdef DEBUG
        url = @"http://localhost:3000/terms";
#else
        url = @"https://kentaro-brooch.sqale.jp/terms";
#endif
    }

    if ([[segue identifier] isEqualToString:@"showHomePage"]) {
#ifdef DEBUG
        url = @"http://localhost:3000/";
#else
        url = @"https://kentaro-brooch.sqale.jp/";
#endif    
    }

    [[segue destinationViewController] setUrl:url];
}


/* ここからyuriwo追加 */

- (IBAction)signOut:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"サインアウト"
                                                    message:@"サインアウトしますか？"
                                                   delegate:self
                                          cancelButtonTitle:@"いいえ"
                                          otherButtonTitles:@"はい", nil];
    [alert show];
}


//ボタン押下時の処理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //遷移先ViewControllerクラスのインスタンス生成
    BRConfigViewController *signout = [self.storyboard instantiateViewControllerWithIdentifier:@"signout"];
    
    switch (buttonIndex) {
        case 0://押したボタンがいいえなら何もしない
            break;
            
        case 1://押したボタンがはいなら画面遷移
            [self presentModalViewController:signout animated:YES ];
            break;
            
    }
}

/* ここまでyuriwo追加 */

@end
