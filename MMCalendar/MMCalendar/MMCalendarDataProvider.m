//
//  MMCalendarDataProvider.m
//  MMCalendar
//
//  Created by 各连明 on 2019/2/22.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import "MMCalendarDataProvider.h"
#import "MMCalendarTool.h"
#import "MMCalendarDayItem.h"
#import "NSDate+MMExtension.h"

#define dayCount 42

@implementation MMCalendarDataProvider

- (NSArray<MMCalendarDayItem *> *)calendarMonthView:(MMCalendarMonthView *)calendarMonthView itemsWithDate:(NSDate *)date {
    NSMutableArray *rows = [NSMutableArray arrayWithCapacity:dayCount];
    
    NSInteger daysInLastMonth = [[date lastMonth] totaldaysInMonth];
    NSInteger daysInThisMonth = [date totaldaysInMonth];
    NSInteger firstWeekday    = [date firstWeekdayInThisMonth];
    
    for (int i = 0; i < dayCount; i++) {
        NSInteger year = [date year];
        NSInteger month = [date month];
        
        NSInteger day = 0;
        MMCalendarDayItem *item = [MMCalendarDayItem new];
        if (i < firstWeekday) {
            day = daysInLastMonth - firstWeekday + i + 1;
            item.hidden = YES;
            
            if(month == 1){
                month = 12;
                year -= 1;
            }
            month -= 1;
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            day = i + 1 - firstWeekday - daysInThisMonth;
            item.hidden = YES;
            
            if(month == 12){
                month = 1;
                year += 1;
            }
            month += 1;
            
        }else{
            day = i - firstWeekday + 1;
            item.hidden = NO;
        }
        NSDate *currentDate = [NSDate componentDateWithYear:year month:month day:day];
        item.date = currentDate;
        [rows addObject:item];
    }
    return rows;
}

@end
