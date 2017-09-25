//
//  CClickTextView.m
//  ClickTextViewDemo
//
//  Created by 崔冰 on 2017/9/25.
//  Copyright © 2017年 崔冰. All rights reserved.
//

#import "CClickTextView.h"

@interface CClickTextView ()
@property (strong, nonatomic) NSMutableArray *rectsArray;
@property (strong, nonatomic) NSMutableAttributedString *strContent;
@end

@implementation CClickTextView

- (void)setText:(NSString *)text
{
    [super setText:text];
    self.strContent = [[NSMutableAttributedString alloc] initWithString:text];
    if (self.wholeTextFont) {
        [self.strContent addAttribute:NSFontAttributeName value:self.wholeTextFont range:NSMakeRange(0, text.length)];
    }
    if (self.wholeTextColor) {
        [self.strContent addAttribute:NSForegroundColorAttributeName value:self.wholeTextColor range:NSMakeRange(0, text.length)];
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 8;
    [self.strContent addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, text.length)];
    
}

- (void)setClickText:(NSString *)strClickText ClickTextColor:(UIColor *)color ClickBlock:(ClickTextViewBolck)block
{
    NSRange selectedRange = [self.text rangeOfString:strClickText];
    if (self.text.length < selectedRange.location + selectedRange.length) {
        return;
    }
    
    if (color) {
        [self.strContent addAttribute:NSForegroundColorAttributeName value:color range:selectedRange];
    }
    self.attributedText = self.strContent;

    self.selectedRange = selectedRange;
    
    //获取选中范围内的矩形框
    NSArray *selectionRects = [self selectionRectsForRange:self.selectedTextRange];
    //清空选中范围
    self.selectedRange = NSMakeRange(0, 0);
    //可能会点击的范围数组
    NSMutableArray *selectedArray = [[NSMutableArray alloc] init];
    for (UITextSelectionRect *selectionRect in selectionRects) {
        CGRect rect = selectionRect.rect;
        if (rect.size.width == 0 || rect.size.height == 0) {
            continue;
        }
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        // 存储文字对应的frame，一段文字可能会有两个甚至多个frame，考虑到文字换行问题
        [dic setObject:[NSValue valueWithCGRect:rect] forKey:@"rect"];
        // 存储下划线对应的文字
        [dic setObject:[self.text substringWithRange:selectedRange] forKey:@"content"];
        // 存储相应的回调的block
        [dic setObject:block forKey:@"block"];
        
        [selectedArray addObject:dic];
    }
    // 将可能点击的范围的数组存储到总的数组中
    [self.rectsArray addObject:selectedArray];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    NSArray *selectedArray = [self touchingSpecialWithPoint:point];
    
    if (selectedArray.count) {
        NSDictionary *dic = [selectedArray firstObject];
        ClickTextViewBolck block = dic[@"block"];
        if (block) {
            block(dic[@"content"]);
        }
    }
}

- (NSArray *)touchingSpecialWithPoint:(CGPoint)point
{
    // 从所有的特殊的范围中找到点击的那个点
    for (NSArray *selecedArray in self.rectsArray) {
        for (NSDictionary *dic in selecedArray) {
            CGRect myRect = [dic[@"rect"] CGRectValue];
            if(CGRectContainsPoint(myRect, point) ){
                return selecedArray;
            }
        }
    }
    return nil;
}

- (NSMutableArray *)rectsArray
{
    if (!_rectsArray) {
        _rectsArray = [[NSMutableArray alloc] init];
    }
    return _rectsArray;
}
@end
