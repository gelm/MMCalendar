//
//  MMCalendarManager.m
//  MMCalendar
//
//  Created by 各连明 on 2019/2/22.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import "MMCalendarManager.h"
#import "MMCalendarContentView.h"
#import "MMCalendarTool.h"
#import "MMCalendarDefines.h"

@interface MMCalendarManager ()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) MMCalendarContentView *contentView;

@end

@implementation MMCalendarManager

- (instancetype)initWithDelegate:(id<MMCalendarMonthDelegate>)delegate {
    self = [super init];
    if(self){
        self.delegate = delegate;
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor clearColor];
        
        _contentView = [[MMCalendarContentView alloc]initWithFrame:CGRectZero delegate:_delegate];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickBackView:)];
        [_backView addGestureRecognizer:tap];
    }
    return self;
}

- (void)clickBackView:(UITapGestureRecognizer *)gesture {
    CGPoint location = [gesture locationInView:_backView];
    if(!CGRectContainsPoint(_contentView.frame, location)){
        [self hide];
    }
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY {
    _contentOffsetY = contentOffsetY;
    CGRect frame = _contentView.frame;
    frame.origin.y = contentOffsetY;
    _contentView.frame = frame;
}

- (void)showCalenderInView:(UIView *)view {
    _backView.frame = view.bounds;
    [view addSubview:_backView];
    
    _contentView.frame = CGRectMake(0, _contentOffsetY, CGRectGetWidth(view.bounds), 0);
    [view addSubview:_contentView];
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.contentView.frame;
        frame.size.height = MM_calendarContentHeight;
        self.contentView.frame = frame;
        
        self.backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.15];
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.contentView.frame;
        frame.size.height = 0;
        self.contentView.frame = frame;
        
        self.backView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
        [self.backView removeFromSuperview];
    }];
}

- (void)reloadDataWithDate:(NSDate *)date {
    [_contentView reloadMonthViewWithDate:date];
}

@end
