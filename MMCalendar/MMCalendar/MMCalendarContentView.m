//
//  MMCalendarContentView.m
//  MMCalendar
//
//  Created by 各连明 on 2019/2/22.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import "MMCalendarContentView.h"
#import "MMCalendarTool.h"

#import "MMCalendarMonthView.h"
#import "MMCalendarDataProvider.h"

#import "NSDate+MMExtension.h"
#import "MMCalendarDefines.h"

@interface MMCalendarContentView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UILabel *monthLabel;
@property (nonatomic, strong) UIButton *lastMonthButton;
@property (nonatomic, strong) UIButton *nextMonthButton;
@property (nonatomic, strong) UIView *weekView;

@property (nonatomic, strong) MMCalendarDataProvider *dataProvider;
@property (nonatomic, strong) UIScrollView *monthScrollView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) BOOL monthAllowsSelection;

@end

@implementation MMCalendarContentView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
        
        self.delegate = delegate;
        _dataSource = [NSMutableArray arrayWithCapacity:3];
        _monthAllowsSelection = YES;
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    _monthLabel = [MMCalendarTool labelWithTextColor:MM_UIColorFromRGB(0x37003c) font:[UIFont boldSystemFontOfSize:17]];
    _monthLabel.backgroundColor = MM_UIColorFromRGB(0xc2b3c3);
    _monthLabel.frame = CGRectMake(0, 0, MM_SCREEN_WIDTH, 35);
    _monthLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_monthLabel];
    
    _lastMonthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_lastMonthButton setImage:[UIImage imageNamed:@"calendar_lastMonth_icon"] forState:UIControlStateNormal];
    _lastMonthButton.frame = CGRectMake(0, 0, 50, CGRectGetHeight(self.monthLabel.bounds));
    [_lastMonthButton addTarget:self action:@selector(lastMonthAction:) forControlEvents:UIControlEventTouchUpInside];
    _lastMonthButton.exclusiveTouch = YES;
    [self addSubview:_lastMonthButton];
    
    _nextMonthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextMonthButton setImage:[UIImage imageNamed:@"calendar_nextMonth_icon"] forState:UIControlStateNormal];
    _nextMonthButton.frame = CGRectMake(CGRectGetWidth(_monthLabel.bounds) - 50, 0, 50, CGRectGetHeight(_monthLabel.bounds));
    [_nextMonthButton addTarget:self action:@selector(nextMonthAction:) forControlEvents:UIControlEventTouchUpInside];
    _nextMonthButton.exclusiveTouch = YES;
    [self addSubview:_nextMonthButton];
    
    [self addSubview:self.weekView];
    
    _monthScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.weekView.frame), MM_SCREEN_WIDTH, MM_calendarContentHeight - (CGRectGetMaxY(self.weekView.frame)))];
    _monthScrollView.pagingEnabled = YES;
    _monthScrollView.showsVerticalScrollIndicator = NO;
    _monthScrollView.showsHorizontalScrollIndicator = NO;
    _monthScrollView.delegate = self;
    [self addSubview:_monthScrollView];
    [_monthScrollView setContentSize:CGSizeMake(MM_SCREEN_WIDTH * 3, CGRectGetHeight(_monthScrollView.bounds))];
    
    //初始化数据
    NSDate *currentDate = [NSDate new];
    NSDate *lastDate = [currentDate lastMonth];
    NSDate *nextDate = [currentDate nextMonth];
    [_dataSource setArray:@[lastDate,currentDate,nextDate]];
    [self refreshScrollView];
}

- (MMCalendarDataProvider *)dataProvider {
    if(!_dataProvider){
        _dataProvider = [[MMCalendarDataProvider alloc]init];
    }
    return _dataProvider;
}

- (UIView *)weekView {
    if(!_weekView){
        NSArray *array = @[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
        _weekView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.monthLabel.frame), MM_SCREEN_WIDTH, 25)];
        _weekView.backgroundColor = MM_UIColorFromRGB(0xd8cdd8);
        CGFloat itemWidth = CGRectGetWidth(_weekView.bounds)/array.count;
        for (int i = 0; i < 7; i++) {
            UILabel *weekLabel = [MMCalendarTool labelWithTextColor:[UIColor blackColor] fontSize:12];
            weekLabel.text     = array[i];
            weekLabel.frame    = CGRectMake(itemWidth * i, 0, itemWidth, CGRectGetHeight(_weekView.bounds));
            weekLabel.textAlignment   = NSTextAlignmentCenter;
            [_weekView addSubview:weekLabel];
        }
    }
    return _weekView;
}

- (void)lastMonthAction:(UIButton *)button {
    //动画完成前防止重复点击
    if(!_monthAllowsSelection){
        return;
    }
    _monthAllowsSelection = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.monthAllowsSelection = YES;
    });
    [self scrollToLastMonth:YES];
}

- (void)nextMonthAction:(UIButton *)button {
    if(!_monthAllowsSelection){
        return;
    }
    _monthAllowsSelection = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.monthAllowsSelection = YES;
    });
    [self scrollToNextMonth:YES];
}

- (void)scrollToLastMonth:(BOOL)animated {
    if(animated){
        [_monthScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else{
        [_dataSource removeLastObject];
        NSDate *date = _dataSource.firstObject;
        [_dataSource insertObject:[date lastMonth] atIndex:0];
        [self refreshScrollView];
    }
}

- (void)scrollToNextMonth:(BOOL)animated {
    if(animated){
        [_monthScrollView setContentOffset:CGPointMake(2*MM_SCREEN_WIDTH, 0) animated:YES];
    }else{
        [_dataSource removeObjectAtIndex:0];
        NSDate *date = _dataSource.lastObject;
        [_dataSource addObject:[date nextMonth]];
        [self refreshScrollView];
    }
}

- (void)refreshScrollView {
    if(!_dataSource.count){
        return;
    }
    NSDate *date = _dataSource[1];
    self.monthLabel.text = [NSString stringWithFormat:@"%li年 %li月",[date year],[date month]];
    
    if(!_monthScrollView.subviews.count){
        MMCalendarMonthView *firstMonthView = [MMCalendarMonthView initWithFrame:CGRectMake(0, 0, MM_SCREEN_WIDTH, CGRectGetHeight(_monthScrollView.bounds)) dataSource:self.dataProvider];
        firstMonthView.delegate = _delegate;
        [_monthScrollView addSubview:firstMonthView];
        MMCalendarMonthView *secondMonthView = [MMCalendarMonthView initWithFrame:CGRectMake(MM_SCREEN_WIDTH, 0, MM_SCREEN_WIDTH, CGRectGetHeight(_monthScrollView.bounds)) dataSource:self.dataProvider];
        secondMonthView.delegate = _delegate;
        [_monthScrollView addSubview:secondMonthView];
        MMCalendarMonthView *thirdMonthView = [MMCalendarMonthView initWithFrame:CGRectMake(MM_SCREEN_WIDTH*2, 0, MM_SCREEN_WIDTH, CGRectGetHeight(_monthScrollView.bounds)) dataSource:self.dataProvider];
        thirdMonthView.delegate = _delegate;
        [_monthScrollView addSubview:thirdMonthView];
    }
    
    for(MMCalendarMonthView *monthView in _monthScrollView.subviews){
        NSInteger index = [_monthScrollView.subviews indexOfObject:monthView];
        monthView.currentDate = _dataSource[index];
    }
    [_monthScrollView setContentOffset:CGPointMake(MM_SCREEN_WIDTH, 0)];
    
    MMCalendarMonthView *currentMonthView = [_monthScrollView.subviews objectAtIndex:1];
    [currentMonthView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.contentOffset.x >= 2*MM_SCREEN_WIDTH){
        [self scrollToNextMonth:NO];
    }else if (scrollView.contentOffset.x <= 0){
        [self scrollToLastMonth:NO];
    }
}

- (void)reloadMonthViewWithDate:(NSDate *)date {
    MMCalendarMonthView *currentMonthView = [_monthScrollView.subviews objectAtIndex:1];
    if([date isSameMonthWithDate:currentMonthView.currentDate]){
        [currentMonthView reloadData];
    }
}

@end
