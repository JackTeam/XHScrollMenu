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
        
        if (i / 5) {
            menu.title = [NSString stringWithFormat:@"长长标题"];
        } else {
            menu.title = [NSString stringWithFormat:@"标题"];
        }
        
        menu.titleColor = [UIColor blackColor];
        menu.titleFont = [UIFont systemFontOfSize:16];
        [menus addObject:menu];
    }
    
    XHScrollMenu *scrollMenu = [[XHScrollMenu alloc] initWithFrame:CGRectMake(0, 44, CGRectGetWidth(self.view.bounds), 35)];
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
