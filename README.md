![image](https://github.com/JackTeam/XHScrollMenu/raw/master/Screenshots/XHScrollMenuContentView.gif)
============
XHScrollMenu is a display column elements， base on NetEase News App.


Completely created using UIKit framework.

Easy to drop into your project.      

You can add this feature to your own project, `Source` is easy-to-use.        

## Requirements ##

XHScrollMenu requires Xcode 5, targeting either iOS 5.0 and above, ARC-enabled.      

## Profile

[CocosPods](http://cocosPods.org) is the recommended methods of installation XHScrollMenu, just add the following line to `Profile`:
```
pod 'XHScrollMenu', '~> 0.1.4'
```

## How to use ##
```objc
NSMutableArray *menus = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 0; i < 20; i ++) {
        XHMenu *menu = [[XHMenu alloc] init];
        
        menu.title = [NSString stringWithFormat:@"Title%d", i];
        
        menu.titleColor = [UIColor colorWithWhite:0.141 alpha:1.000];
        menu.titleFont = [UIFont boldSystemFontOfSize:16];
        [menus addObject:menu];
    }
    
    XHScrollMenu *scrollMenu = [[XHScrollMenu alloc] initWithFrame:CGRectMake(0, 44, CGRectGetWidth(self.view.bounds), 36)];
    scrollMenu.backgroundColor = [UIColor colorWithWhite:0.902 alpha:1.000];
    scrollMenu.delegate = self;
    [self.view addSubview:scrollMenu];
    
    scrollMenu.menus = menus;
    
    [scrollMenu reloadData];
    

if you set default select 2 title item, you need set the property

scrollMenu.defaultSelectIndex = 2;

```
## Lincense ##

`XHScrollMenu` is available under the MIT license. See the LICENSE file for more info.
