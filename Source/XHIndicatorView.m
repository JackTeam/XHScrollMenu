//
//  XHIndicatorView.m
//  XHScrollMenu
//
//  Created by 曾 宪华 on 14-3-8.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "XHIndicatorView.h"

@implementation XHIndicatorView

- (void)setIndicatorWidth:(CGFloat)indicatorWidth {
    _indicatorWidth = indicatorWidth;
    CGRect indicatorRect = self.frame;
    indicatorRect.size.width = _indicatorWidth;
    self.frame = indicatorRect;
}

+ (instancetype)initIndicatorView {
    XHIndicatorView *indicatorView = [[XHIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, kXHIndicatorViewHeight)];
    return indicatorView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0.752 green:0.026 blue:0.034 alpha:1.000];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
