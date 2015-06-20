//
//  AppDelegate.h
//  Tab
//
//  Created by MAEDA HAJIME on 2014/04/15.
//  Copyright (c) 2014年 MAEDA HAJIME. All rights reserved.
//
//  AppDelegateに宣言した変数に別クラスからアクセスする方法
//  http://blog.guttyo.jp/?p=1187


#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// 画像インデックス番号（アプリ共通）
// AppDelegateに変数をおいておくとどのクラスからもアクセスしやすくて便利
@property (assign, nonatomic) int idxImage;

// 画像の取得
- (UIImage *)getImage;

@end
