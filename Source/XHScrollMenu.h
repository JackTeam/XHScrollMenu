//
//  XHScrollMenu.h
//  XHScrollMenu
//
//  Created by 曾 宪华 on 14-3-8.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHIndicatorView.h"
#import "XHMenu.h"

#define kXHMenuButtonPaddingX 15
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

// DataSource
@property (nonatomic, strong) NSArray *menus;

// select
@property (nonatomic, assign) NSUInteger defaultSelectIndex; // default is 0

// reload dataSource
- (void)reloadData;

@end
