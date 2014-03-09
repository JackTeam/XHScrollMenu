//
//  ViewController.m
//  XHScrollMenu
//
//  Created by 曾 宪华 on 14-3-8.
//  Copyright (c) 2014年 曾宪华 QQ群: (142557668) QQ:543413507  Gmail:xhzengAIB@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import "XHMenu.h"
#import "XHScrollMenu.h"

@interface ViewController () <XHScrollMenuDelegate>
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) XHScrollMenu *scrollMenu;
@property (nonatomic, strong) NSMutableArray *menus;
@end

@implementation ViewController

- (NSMutableArray *)menus {
    if (!_menus) {
        _menus = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return _menus;
}

- (void)valueChange:(UISegmentedControl *)segmentedControl {
    if (segmentedControl.selectedSegmentIndex == 0) {
        [self.menus removeObject:[self.menus firstObject]];
    } else {
        XHMenu *menu = [[XHMenu alloc] init];
        menu.title = @"添加的";
        
        menu.titleNormalColor = [UIColor colorWithWhite:0.141 alpha:1.000];
        menu.titleFont = [UIFont boldSystemFontOfSize:16];
        [self.menus addObject:menu];
    }
    self.scrollMenu.menus = self.menus;
    [self.scrollMenu reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@" - ", @" + ", nil]];
    _segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [_segmentedControl addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    CGRect segmentedControlFrame = _segmentedControl.frame;
    segmentedControlFrame.origin = CGPointMake(CGRectGetWidth(self.view.bounds) - CGRectGetWidth(segmentedControlFrame), 100);
    _segmentedControl.frame = segmentedControlFrame;
    [self.view addSubview:self.segmentedControl];
    
    for (int i = 0; i < 20; i ++) {
        XHMenu *menu = [[XHMenu alloc] init];
        
        NSString *title = nil;
        switch (i) {
            case 0:
                title = @"头条";
                break;
            case 1:
                title = @"娱乐";
                break;
            case 2:
                title = @"原创";
                break;
            case 3:
                title = @"汽车";
                break;
            case 4:
                title = @"互联网";
                break;
            case 5:
                title = @"NBA";
                break;
            case 6:
                title = @"时尚";
                break;
            default:
                title = @"热点新闻";
                break;
        }
        menu.title = title;
        
        menu.titleNormalColor = [UIColor colorWithWhite:0.141 alpha:1.000];
        menu.titleFont = [UIFont boldSystemFontOfSize:16];
        [self.menus addObject:menu];
    }
    
    _scrollMenu = [[XHScrollMenu alloc] initWithFrame:CGRectMake(0, 44, CGRectGetWidth(self.view.bounds), 36)];
    _scrollMenu.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    _scrollMenu.delegate = self;
    _scrollMenu.selectedIndex = 3;
    [self.view addSubview:self.scrollMenu];
    
    _scrollMenu.menus = self.menus;
    
    [_scrollMenu performSelector:@selector(reloadData) withObject:nil afterDelay:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollMenuDidSelected:(XHScrollMenu *)scrollMenu menuIndex:(NSUInteger)selectIndex {
    NSLog(@"selectIndex : %d", selectIndex);
}

- (void)scrollMenuDidManagerSelected:(XHScrollMenu *)scrollMenu {
    NSLog(@"scrollMenuDidManagerSelected");
}

@end
