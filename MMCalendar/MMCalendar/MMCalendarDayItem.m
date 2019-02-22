//
//  MMCalendarDayItem.m
//  MMCalendar
//
//  Created by 各连明 on 2019/2/21.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import "MMCalendarDayItem.h"
#import "NSDate+MMExtension.h"

@implementation MMCalendarDayItem

- (NSString *)dayString {
    
    if(!_date) return nil;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd"];
    
    NSString *destDateString = [dateFormatter stringFromDate:_date];
    
    return [NSString stringWithFormat:@"%lu",destDateString.integerValue];
}

- (BOOL)isToday {
    if (_date==nil) return NO;
    return [_date isSameDay];
}

@end
