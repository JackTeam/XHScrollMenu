//
//  XHScrollMenu.h
//  XHScrollMenu
//
//  Created by 曾 宪华 on 14-3-8.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHIndicatorView.h"
#import "XHMenu.h"
#import "XHMenuButton.h"

#define kXHMenuButtonPaddingX 30
#define kXHMenuButtonStarX 8

@class XHScrollMenu;

@protocol XHScrollMenuDelegate <NSObject>

- (void)scrollMenuDidSelected:(XHScrollMenu *)scrollMenu menuIndex:(NSUInteger)selectIndex;
- (void)scrollMenuDidManagerSelected:(XHScrollMenu *)scrollMenu;

@end

@interface XHScrollMenu : UIView

@property (nonatomic, assign) id <XHScrollMenuDelegate> delegate;

// UI
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) XHIndicatorView *indicatorView;

// Default is NO
@property (nonatomic, assign) BOOL hasManagerButton;

// Default is YES
@property (nonatomic, assign) BOOL hasShadowForBoth;

// XHIndicatorView Color
@property (nonatomic, strong) UIColor *indicatorTintColor;

// DataSource
@property (nonatomic, strong) NSArray *menus;

// select
@property (nonatomic, assign) NSUInteger selectedIndex; // default is 0

// 当menu数较少时，是否均匀摆放button使之占满整个宽度。默认是no;
@property (nonatomic, assign) BOOL shouldUniformizeMenus;


- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)aniamted calledDelegate:(BOOL)calledDelgate;

- (CGRect)rectForSelectedItemAtIndex:(NSUInteger)index;

- (XHMenuButton *)menuButtonAtIndex:(NSUInteger)index;

// reload dataSource
- (void)reloadData;

@end
