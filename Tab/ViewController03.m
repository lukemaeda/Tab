//
//  ViewController03.m
//  Tab
//
//  Created by MAEDA HAJIME on 2014/04/15.
//  Copyright (c) 2014年 MAEDA HAJIME. All rights reserved.
//
//
//  AppDelegateに宣言した変数に別クラスからアクセスする方法
//  http://blog.guttyo.jp/?p=1187

#import "ViewController03.h"

@interface ViewController03 ()

@property (weak, nonatomic) IBOutlet UIImageView *ivImage;

@end

@implementation ViewController03

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

// ビューの表示前
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // 画像表示
//    AppDelegate *ad = [UIApplication sharedApplication].delegate;
//    
//    NSString *str = [NSString stringWithFormat:@"Image0%d.png", ad.idxImage];
//    
//    self.ivImage.image = [UIImage imageNamed:str];
    
    // AppDelegateに宣言した変数に別クラスからアクセスする方法
    // AppDelegateに画像インデックス番号退避
    AppDelegate *ad = [UIApplication sharedApplication].delegate;
    //self.ivImage.image = [ad getImage];
    
    // ImageEffect セピアクラス + applyGrayscale: メソッド
    self.ivImage.image = [ImageEffect applySepia:[ad getImage]];
    
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

@end
