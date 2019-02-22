//
//  MMCalendarManager.h
//  MMCalendar
//
//  Created by 各连明 on 2019/2/22.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMCalendarProtocol.h"
#import "MMCalendarDayItem.h"
#import "MMCalendarMonthView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMCalendarManager : NSObject

- (instancetype)initWithDelegate:(id<MMCalendarMonthDelegate>)delegate;

@property (nonatomic, assign) CGFloat contentOffsetY;//日历起始位置在Y轴上的偏移，默认0
@property (nonatomic, weak) id<MMCalendarMonthDelegate>delegate;

- (void)showCalenderInView:(UIView *)view;
- (void)hide;

- (void)reloadDataWithDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
