//
//  ImageEffect.h
//  effectTab
//
//  Created by bar2 on 12/04/28.
//  Copyright (c) 2012年 bar2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageEffect : NSObject

// 画像のグレースケール化
+ (UIImage *)applyGrayscale:(UIImage *)targetImage;
// 画像のセピア化
+ (UIImage *)applySepia:(UIImage *)targetImage;

@end
