//
//  ViewController.m
//  MMCalendar
//
//  Created by 各连明 on 2019/2/21.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import "ViewController.h"
#import "MMCalendar/MMCalendarManager.h"

@interface ViewController ()<MMCalendarMonthDelegate,MMCalendarMonthDataSource>

@property (nonatomic, strong) MMCalendarManager *calendarManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(showCalendar) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"日历" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)showCalendar {
    [self.calendarManager showCalenderInView:self.navigationController.view];
}

- (MMCalendarManager *)calendarManager {
    if(!_calendarManager){
        _calendarManager = [[MMCalendarManager alloc]initWithDelegate:self];
        _calendarManager.contentOffsetY = 64;
    }
    return _calendarManager;
}

@end
