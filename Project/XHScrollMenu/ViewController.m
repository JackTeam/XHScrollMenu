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

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *menus = [[NSMutableArray alloc] initWithCapacity:10];
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
        
        menu.titleColor = [UIColor colorWithWhite:0.141 alpha:1.000];
        menu.titleFont = [UIFont boldSystemFontOfSize:16];
        [menus addObject:menu];
    }
    
    XHScrollMenu *scrollMenu = [[XHScrollMenu alloc] initWithFrame:CGRectMake(0, 44, CGRectGetWidth(self.view.bounds), 36)];
    scrollMenu.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    scrollMenu.delegate = self;
//    scrollMenu.defaultSelectIndex = 2;
    [self.view addSubview:scrollMenu];
    
    scrollMenu.menus = menus;
    
    [scrollMenu reloadData];
    
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
