//
//  ImageEffect.m
//  effectTab
//
//  Created by bar2 on 12/04/28.
//  Copyright (c) 2012年 bar2. All rights reserved.
//

#import "ImageEffect.h"

enum {
	GRAY_SCALE,
	SEPIA
};

@implementation ImageEffect

// 画像のグレースケール化
+ (UIImage *)applyGrayscale:(UIImage *)targetImage
{
	return [ImageEffect applyEffect:targetImage
							 effect:GRAY_SCALE];
}

// 画像のセピア化
+ (UIImage *)applySepia:(UIImage *)targetImage
{
	return [ImageEffect applyEffect:targetImage
							 effect:SEPIA];
}

// 画像への効果適用
+ (UIImage *)applyEffect:(UIImage *)anImage
				  effect:(int)effect
{
	//--------------------------------------------
	// 画像情報の取得
	//--------------------------------------------
	
	CGImageRef imr = anImage.CGImage;
	
	// (幅、高さ)
	size_t width  = CGImageGetWidth(imr);
	size_t height = CGImageGetHeight(imr);
//	NSLog(@"%ld, %ld", cgWidth, cgHeight);
	
	// (RGBα各要素の構成ビット)
	// 　1バイト = 8ビット
	size_t bitsPerComponent = CGImageGetBitsPerComponent(imr);
//	NSLog(@"%ld", bitsPerComponent);
	
	// (ピクセル全体の構成ビット)
	// 　8ビットがRGBA分：8 x 4 = 32ビット
	size_t bitsPerPixel = CGImageGetBitsPerPixel(imr);
//	NSLog(@"%ld", bitsPerPixel);
	
	// (横1ライン分のデータの構成バイト)
	// 　width x 4
	size_t bytesPerRow = CGImageGetBytesPerRow(imr);
//	NSLog(@"%ld", bytesPerRow);
	
	// (色空間)
	CGColorSpaceRef colorSpace = CGImageGetColorSpace(imr);
	
	// (Bitmap情報)
	CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imr);
	
	// (画像のピクセル間補完の有無)
	bool shouldInterpolate = CGImageGetShouldInterpolate(imr);
	
	// (表示装置による補正)
	CGColorRenderingIntent intent = CGImageGetRenderingIntent(imr);
	
	// (データプロバイダよりビットマップデータ)
	CGDataProviderRef dp      = CGImageGetDataProvider(imr);
	CFDataRef         data    = CGDataProviderCopyData(dp);
	UInt8             *buffer = (UInt8 *)CFDataGetBytePtr(data);
	
	// 1ピクセルずつ画像を処理
	for (NSUInteger y = 0; y < height; y++) {
		for (NSUInteger x = 0; x < width; x++) {
			// RGBAの4つ値をもっているので、1ピクセルごとに*4してずらす
			UInt8 *tmp = buffer + y * bytesPerRow + x * 4;
			
			// RGB値を取得
			UInt8 red   = *(tmp + 0);
			UInt8 green = *(tmp + 1);
			UInt8 blue  = *(tmp + 2);
			
			// 輝度計算
			// ・RGBの各々の値の差をなくし、明るさ(輝度 y)の差だけにする。
			// 　y = (77 * r + 28 * g + 151 * b) / 256
			UInt8 brightness = (77 * red + 28 * green + 151 * blue) / 256;
			
			// エフェクト
			switch (effect) {
				case GRAY_SCALE:
					*(tmp + 0) = brightness;
					*(tmp + 1) = brightness;
					*(tmp + 2) = brightness;
					break;
				case SEPIA:
					*(tmp + 0) = brightness;
					*(tmp + 1) = brightness * 0.7;
					*(tmp + 2) = brightness * 0.4;
					break;
				default:
					break;
			}
		}
	}
		
	// 効果を与えたデータ生成
	CFDataRef effectedData =
		CFDataCreate(NULL, buffer, CFDataGetLength(data));
	
	// 効果を与えたデータプロバイダを生成
	CGDataProviderRef effectedDataProvider =
		CGDataProviderCreateWithCFData(effectedData);
	
	// 画像を生成
	CGImageRef effectedCgImage =
		CGImageCreate(width,
					  height,
					  bitsPerComponent,
					  bitsPerPixel,
					  bytesPerRow,
					  colorSpace,
					  bitmapInfo,
					  effectedDataProvider,
					  NULL,
					  shouldInterpolate,
					  intent);
	
	UIImage *ret = [UIImage imageWithCGImage:effectedCgImage];

	// データの解放
	CGImageRelease(effectedCgImage);
	CFRelease(effectedDataProvider);
	CFRelease(effectedData);
	CFRelease(data);
	
	return ret;
}

@end
