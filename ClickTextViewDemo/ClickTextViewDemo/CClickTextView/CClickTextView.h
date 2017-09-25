//
//  CClickTextView.h
//  ClickTextViewDemo
//
//  Created by 崔冰 on 2017/9/25.
//  Copyright © 2017年 崔冰. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickTextViewBolck)(NSString *strClickText);

@interface CClickTextView : UITextView
//整段文字的颜色
@property (strong, nonatomic) UIColor *wholeTextColor;
//整段文字的字体
@property (strong, nonatomic) UIFont *wholeTextFont;

/**
 配置可点击文案

 @param strClickText 可点击的文字
 @param color 可点击文字的颜色
 @param block 点击的回调
 */
- (void)setClickText:(NSString *)strClickText ClickTextColor:(UIColor *)color ClickBlock:(ClickTextViewBolck)block;
@end
