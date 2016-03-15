//
//  XHScrollMenu.m
//  XHScrollMenu
//
//  Created by 曾 宪华 on 14-3-8.
//  Copyright (c) 2014年 嗨，我是曾宪华(@xhzengAIB)，曾加入YY Inc.担任高级移动开发工程师，拍立秀App联合创始人，热衷于简洁、而富有理性的事物 QQ:543413507 主页:http://zengxianhua.com All rights reserved.
//

#import "XHScrollMenu.h"

#import "UIScrollView+XHVisibleCenterScroll.h"

#define kXHMenuButtonBaseTag 100

@interface XHScrollMenu () <UIScrollViewDelegate> {
    
}

@property (nonatomic, strong) UIImageView *leftShadowView;
@property (nonatomic, strong) UIImageView *rightShadowView;

@property (nonatomic, strong) UIButton *managerMenusButton;

@property (nonatomic, strong) NSMutableArray *menuButtons;

@end

@implementation XHScrollMenu

#pragma mark - Propertys

- (NSMutableArray *)menuButtons {
    if (!_menuButtons) {
        _menuButtons = [[NSMutableArray alloc] initWithCapacity:self.menus.count];
    }
    return _menuButtons;
}

#pragma mark - Action

- (void)managerMenusButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(scrollMenuDidManagerSelected:)]) {
        [self.delegate scrollMenuDidManagerSelected:self];
    }
}

- (void)menuButtonSelected:(UIButton *)sender {
    [self.menuButtons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (obj == sender) {
            sender.selected = YES;
        } else {
            UIButton *menuButton = obj;
            menuButton.selected = NO;
        }
    }];
    [self setSelectedIndex:sender.tag - kXHMenuButtonBaseTag animated:YES calledDelegate:YES];
}

#pragma mark - Life cycle

- (UIImageView *)getShadowView:(BOOL)isLeft {
    UIImageView *shadowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 7, CGRectGetHeight(self.bounds))];
    shadowImageView.image = [UIImage imageNamed:(isLeft ? @"leftShadow" : @"rightShadow")];
    /** keep this code due with layer shadow
    shadowImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    shadowImageView.layer.shadowOffset = CGSizeMake((isLeft ? 2.5 : -1.5), 0);
    shadowImageView.layer.shadowRadius = 3.2;
    shadowImageView.layer.shadowOpacity = 0.5;
    shadowImageView.layer.shadowPath = [UIBezierPath bezierPathWithRect:shadowImageView.bounds].CGPath;
     */
    
    shadowImageView.hidden = isLeft;
    return shadowImageView;
}

- (void)setup {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _selectedIndex = 0;
    
    CGRect rightShadowViewFrame = CGRectZero;
    if (self.hasShadowForBoth) {
        _leftShadowView = [self getShadowView:YES];
        _leftShadowView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        
        _rightShadowView = [self getShadowView:NO];
        _rightShadowView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        
        rightShadowViewFrame = _rightShadowView.frame;
        rightShadowViewFrame.origin = CGPointMake((self.hasManagerButton ? CGRectGetMinX(_managerMenusButton.frame) : CGRectGetWidth(self.bounds)) - CGRectGetWidth(rightShadowViewFrame), 0);
        _rightShadowView.frame = rightShadowViewFrame;
        
        [self addSubview:self.leftShadowView];
        [self addSubview:self.rightShadowView];
    }
    
    CGFloat height = CGRectGetHeight(self.bounds);
    if (self.hasManagerButton) {
        _managerMenusButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds) - height, 0, height, height)];
        _managerMenusButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        _managerMenusButton.backgroundColor = self.backgroundColor;
        [_managerMenusButton setImage:[UIImage imageNamed:@"managerMenuButton"] forState:UIControlStateNormal];
        [_managerMenusButton addTarget:self action:@selector(managerMenusButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.managerMenusButton];
    }
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((self.hasShadowForBoth ? CGRectGetMaxX(_leftShadowView.frame) : 0), 0, CGRectGetWidth(self.bounds) - (self.hasShadowForBoth ? CGRectGetWidth(rightShadowViewFrame) * 2 : 0) - (self.hasManagerButton ? CGRectGetWidth(_managerMenusButton.frame) : 0), CGRectGetHeight(self.bounds))];
    [_scrollView setScrollsToTop:NO];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    _indicatorView = [XHIndicatorView initIndicatorView];
    _indicatorView.alpha = 0.;
    if (self.indicatorTintColor) {
        _indicatorView.backgroundColor = self.indicatorTintColor;
    }
    [_scrollView addSubview:self.indicatorView];
    
    [self addSubview:self.scrollView];
    [self sendSubviewToBack:self.scrollView];
}

- (void)setupIndicatorFrame:(CGRect)menuButtonFrame animated:(BOOL)animated callDelegate:(BOOL)called {
    [UIView animateWithDuration:(animated ? 0.15 : 0) delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _indicatorView.frame = CGRectMake(CGRectGetMinX(menuButtonFrame), CGRectGetHeight(self.bounds) - kXHIndicatorViewHeight, CGRectGetWidth(menuButtonFrame), kXHIndicatorViewHeight);
    } completion:^(BOOL finished) {
        if (called) {
            if ([self.delegate respondsToSelector:@selector(scrollMenuDidSelected:menuIndex:)]) {
                [self.delegate scrollMenuDidSelected:self menuIndex:self.selectedIndex];
            }
        }
    }];
}

- (UIButton *)getButtonWithMenu:(XHMenu *)menu {
    CGSize buttonSize = [menu.title sizeWithFont:menu.titleFont constrainedToSize:CGSizeMake(MAXFLOAT, CGRectGetHeight(self.bounds) - 10) lineBreakMode:NSLineBreakByCharWrapping];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonSize.width, CGRectGetHeight(self.bounds))];
    button.titleLabel.textAlignment = UITextAlignmentCenter;
    button.titleLabel.font = menu.titleFont;
    [button setTitle:menu.title forState:UIControlStateNormal];
    if (menu.titleNormalColor)
        [button setTitleColor:menu.titleNormalColor forState:UIControlStateNormal];
    if (menu.titleHighlightedColor)
        [button setTitleColor:menu.titleHighlightedColor forState:UIControlStateHighlighted];
    if (menu.titleSelectedColor)
        [button setTitleColor:menu.titleSelectedColor forState:UIControlStateSelected];
    [button addTarget:self action:@selector(menuButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.hasShadowForBoth = YES;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview) {
        [self setup];
    }
}

#pragma mark - Public

- (CGRect)rectForSelectedItemAtIndex:(NSUInteger)index {
    CGRect rect = ((UIView *)self.menuButtons[index]).frame;
    return rect;
}

- (XHMenuButton *)menuButtonAtIndex:(NSUInteger)index {
    return self.menuButtons[index];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)aniamted calledDelegate:(BOOL)calledDelgate {
    if (_selectedIndex == selectedIndex)
        return;
    UIButton *towardsButton = [self.menuButtons objectAtIndex:selectedIndex];
    towardsButton.selected = YES;
    
    UIButton *prousButton = [self.menuButtons objectAtIndex:_selectedIndex];
    prousButton.selected = (_selectedIndex == selectedIndex && !selectedIndex);
   
    _selectedIndex = selectedIndex;
    UIButton *selectedMenuButton = [self menuButtonAtIndex:_selectedIndex];
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.scrollView scrollRectToVisibleCenteredOn:selectedMenuButton.frame animated:NO];
    } completion:^(BOOL finished) {
        [self setupIndicatorFrame:selectedMenuButton.frame animated:aniamted callDelegate:calledDelgate];
    }];
}

- (void)removeAllButtonSubviews {
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            [((UIButton *)obj) removeFromSuperview];
        }
    }];
    if (self.menuButtons.count)
        [self.menuButtons removeAllObjects];
}

- (void)reloadData {
    [self removeAllButtonSubviews];
    
    // 为了得到ScrollView的contentSize的宽
    CGFloat contentSizeWidht = 10;
    
    // 校验总文字长度
    CGFloat totalWidth = 10;
    CGFloat totalButtonWidth = 0;
    for (XHMenu *menu in self.menus) {
        NSUInteger index = [self.menus indexOfObject:menu];
        UIButton *menuButton = [self getButtonWithMenu:menu];
        menuButton.tag = kXHMenuButtonBaseTag + index;
        CGRect menuButtonFrame = menuButton.frame;
        if (index) {
            totalWidth += kXHMenuButtonPaddingX + menuButtonFrame.size.width;
        } else {
            totalWidth = kXHMenuButtonStarX;
        }
        totalButtonWidth += menuButtonFrame.size.width;
    }
    
    // 重新布局UI
    for (XHMenu *menu in self.menus) {
        NSUInteger index = [self.menus indexOfObject:menu];
        UIButton *menuButton = [self getButtonWithMenu:menu];
        menuButton.tag = kXHMenuButtonBaseTag + index;
        CGRect menuButtonFrame = menuButton.frame;
        CGFloat buttonX = 0;
        
        // 判断总长度是否为均匀分布
        if (self.shouldUniformizeMenus && totalWidth < CGRectGetWidth(self.scrollView.bounds)) {
            
            CGFloat newPadding = (CGRectGetWidth(self.scrollView.bounds) - totalButtonWidth) / (self.menus.count + 1);
            if (index) {
                buttonX = newPadding + CGRectGetMaxX(((UIButton *)(self.menuButtons[index - 1])).frame);
            } else {
                buttonX = newPadding;
            }
            
        } else {
            
            if (index) {
                buttonX = kXHMenuButtonPaddingX + CGRectGetMaxX(((UIButton *)(self.menuButtons[index - 1])).frame);
            } else {
                buttonX = kXHMenuButtonStarX;
            }
            
        }
        
        // 配置Item的布局
        menuButtonFrame.origin = CGPointMake(buttonX, CGRectGetMidY(self.bounds) - (CGRectGetHeight(menuButtonFrame) / 2.0));
        menuButton.frame = menuButtonFrame;
        [self.scrollView addSubview:menuButton];
        
        // 添加到数据源
        [self.menuButtons addObject:menuButton];
        
        // 为了得到ScrollView的contentSize的宽
        if (index == self.menus.count - 1) {
            contentSizeWidht += CGRectGetMaxX(menuButtonFrame);
        }
        
        // 为了具有默认选中某个Item的功能
        if (self.selectedIndex == index) {
            menuButton.selected = YES;
            // indicator
            _indicatorView.alpha = 1.;
            [self setupIndicatorFrame:menuButtonFrame animated:NO callDelegate:NO];
        }
    }
    [self.scrollView setContentSize:CGSizeMake(contentSizeWidht, CGRectGetHeight(self.scrollView.frame))];
    
    [self setSelectedIndex:self.selectedIndex animated:NO calledDelegate:YES];
}

#pragma mark - UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    CGFloat contentSizeWidth = (NSInteger)scrollView.contentSize.width;
    CGFloat scrollViewWidth = CGRectGetWidth(scrollView.bounds);
    if (contentSizeWidth == scrollViewWidth) {
        self.leftShadowView.hidden = YES;
        self.rightShadowView.hidden = YES;
    } else if (contentSizeWidth <= scrollViewWidth) {
        self.leftShadowView.hidden = YES;
        self.rightShadowView.hidden = YES;
    } else {
        if (contentOffsetX > 0) {
            self.leftShadowView.hidden = NO;
        } else {
            self.leftShadowView.hidden = YES;
        }
        
        if ((contentOffsetX + scrollViewWidth) >= contentSizeWidth) {
            self.rightShadowView.hidden = YES;
        } else {
            self.rightShadowView.hidden = NO;
        }
    }
}

@end
