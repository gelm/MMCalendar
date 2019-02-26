//
//  MMCalendarDayCell.m
//  MMCalendar
//
//  Created by 各连明 on 2019/2/21.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import "MMCalendarDayCell.h"
#import "MMCalendarTool.h"

#import "MMCalendarDayItem.h"
#import "MMCalendarDefines.h"

@interface MMCalendarDayCell ()

@property (nonatomic, strong) UIView *todayView;
@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation MMCalendarDayCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _todayView = [[UIView alloc]init];
        _todayView.backgroundColor = [UIColor redColor];
        _todayView.layer.cornerRadius = 26/2;
        [self.contentView addSubview:_todayView];
        
        _textLabel = [MMCalendarTool labelWithTextColor:MM_UIColorFromRGB(0x666666) fontSize:14];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_textLabel];
    }
    return self;
}

- (void)setItem:(MMCalendarDayItem *)item {
    _item = item;
    
    _textLabel.text = item.dayString;
    self.contentView.hidden = item.hidden;
    
    _todayView.hidden = !item.isToday;
    _textLabel.textColor = item.isToday?[UIColor whiteColor]:MM_UIColorFromRGB(0x666666);
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);

    _todayView.frame = (CGRect){0,0,26,26};
    _todayView.center = CGPointMake(width/2, height/2);
    _textLabel.frame = CGRectMake(0, 0, width, height);
}

@end
