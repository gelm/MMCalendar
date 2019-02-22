//
//  MMCalendarProtocol.h
//  MMCalendar
//
//  Created by 各连明 on 2019/2/21.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMCalendarDayItem;
@class MMCalendarMonthView;

@protocol MMCalendarMonthDataSource <NSObject>

@optional
- (NSArray<MMCalendarDayItem *> *)calendarMonthView:(MMCalendarMonthView *)calendarMonthView itemsWithDate:(NSDate *)date;

@end

@protocol MMCalendarMonthDelegate <NSObject>

@optional
- (void)calendarMonthView:(MMCalendarMonthView *)calendarMonthView didSelectedItem:(MMCalendarDayItem *)item;
- (void)calendarMonthView:(MMCalendarMonthView *)calendarMonthView refreshWithItems:(NSArray<MMCalendarDayItem *> *)items;

@end
