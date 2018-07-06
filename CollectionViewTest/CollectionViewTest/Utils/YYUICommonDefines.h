//
//  YYUICommonDefines.h
//  CollectionViewTest
//
//  Created by 杨赟 on 2018/7/5.
//  Copyright © 2018年 杨赟. All rights reserved.
//

#ifndef YYUICommonDefines_h
#define YYUICommonDefines_h

#pragma mark - 变量-设备相关

// 操作系统版本号
#define IOS_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue])

// 是否横竖屏
// 用户界面横屏了才会返回YES
#define IS_LANDSCAPE UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])
// 无论支不支持横屏，只要设备横屏了，就会返回YES
#define IS_DEVICE_LANDSCAPE UIDeviceOrientationIsLandscape([[UIDevice currentDevice] orientation])

// 屏幕宽度，会根据横竖屏的变化而变化
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

// 屏幕宽度，跟横竖屏无关
#define DEVICE_WIDTH (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

// 屏幕高度，会根据横竖屏的变化而变化
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

// 屏幕高度，跟横竖屏无关
#define DEVICE_HEIGHT (IS_LANDSCAPE ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)


// 是否Retina
#define IS_RETINASCREEN ([[UIScreen mainScreen] scale] >= 2.0)


#pragma mark - 字体
#define MSFontName_DinAlternate         @"DIN Alternate"//din alternate 字体名称，目前用于数字显示
#define MSFontName_PingFangSCMedium     @"PingFangSC-Medium"//PingFangSC-Medium字体，系统自带
#define MSFontName_PingFangSCRegular    @"PingFangSC-Regular"//PingFangSC-Regular字体，系统自带

#define YYFontWithName(s, name) [UIFont fontWithName:name size:s]
#define YYFont_TextRegular(s) YYFontWithName(s, MSFontName_PingFangSCRegular)


#endif /* YYUICommonDefines_h */
