//
//  ViewController01.m
//  Tab
//
//  Created by MAEDA HAJIME on 2014/04/15.
//  Copyright (c) 2014年 MAEDA HAJIME. All rights reserved.
//
//  AppDelegateに宣言した変数に別クラスからアクセスする方法
//  http://blog.guttyo.jp/?p=1187

#import "ViewController01.h"
//#import "AppDelegate.h" // pchファイルで記述

@interface ViewController01 ()

@property (weak, nonatomic) IBOutlet UIImageView *ivImage;

@end

@implementation ViewController01

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ビューの表示前 delegateを使って画像を読んでいる
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // 画像表示
    AppDelegate *ad = [UIApplication sharedApplication].delegate;
    self.ivImage.image = [ad getImage];
    
//    NSString *str = [NSString stringWithFormat:@"Image0%d.png", ad.idxImage];
//    
//    self.ivImage.image = [UIImage imageNamed:str];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// 画像変更セグメント変更時 %02d
- (IBAction)selectSegmented:(UISegmentedControl *)sender {

    //NSLog(@"%ld, %@", (long)sender.tag, str);
    
    // AppDelegateに宣言した変数に別クラスからアクセスする方法
    // AppDelegateに画像インデックス番号退避
    AppDelegate *ad = [UIApplication sharedApplication].delegate;
    ad.idxImage = sender.selectedSegmentIndex;
    
    // 画像の表示
//    NSString *str = [NSString stringWithFormat:@"Image0%d.png", sender.selectedSegmentIndex];
//    self.ivImage.image = [UIImage imageNamed:str];
    
    // 画像の表示
    self.ivImage.image = [ad getImage];
    
    // ①バッチ表示
    self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", ad.idxImage];

}
@end
