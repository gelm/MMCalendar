//
//  NSDate+MMExtension.h
//  MMCalendar
//
//  Created by 各连明 on 2019/2/21.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (MMExtension)

- (BOOL)isSameDay;
- (BOOL)isSameMonthWithDate:(NSDate *)date;

- (NSInteger)day;
- (NSInteger)month;
- (NSInteger)year;
- (NSInteger)firstWeekdayInThisMonth;
- (NSInteger)totaldaysInMonth;
- (NSDate *)lastMonth;
- (NSDate *)nextMonth;
+ (NSDate *)componentDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

@end

NS_ASSUME_NONNULL_END
