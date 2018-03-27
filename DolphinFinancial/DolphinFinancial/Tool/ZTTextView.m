//
//  ZTTextView.m
//  FanBookClub
//
//  Created by FDXDZ on 2018/3/1.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "ZTTextView.h"

@implementation ZTTextView

- (instancetype)init{
    self = [super init];
    if (self) {
        // 设置默认字体
        self.font = [UIFont systemFontOfSize:15];
        
        // 设置默认颜色
        self.placeholderColor = [UIColor grayColor];
        
        // 使用通知监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
- (void)textDidChange:(NSNotification *)note
{
    // 会重新调用drawRect:方法
    [self setNeedsDisplay];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)drawRect:(CGRect)rect {
    if (self.hasText) {return;}
    // Drawing code
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    [self.placeholder drawInRect:CGRectMake(5, 7, self.frame.size.width, self.frame.size.height) withAttributes:attrs];
}

// 布局子控件的时候需要重绘
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
    
}
// 设置属性的时候需要重绘，所以需要重写相关属性的set方法
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
    
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    if (text.length) { // 因为是在文本改变的代理方法中判断是否显示placeholder，而通过代码设置text的方式又不会调用文本改变的代理方法，所以再此根据text是否不为空判断是否显示placeholder。
        self.placeholder = @"";
    }
    [self setNeedsDisplay];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    if (attributedText.length) {
        self.placeholder = @"";
    }
    [self setNeedsDisplay];
}

@end
