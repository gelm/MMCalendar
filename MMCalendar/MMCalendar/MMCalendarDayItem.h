//
//  MMCalendarDayItem.h
//  MMCalendar
//
//  Created by 各连明 on 2019/2/21.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMCalendarProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMCalendarDayItem : NSObject<MMCalendarDayDataSource>
   
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong, readonly) NSString *dayString;
@property (nonatomic, readonly) BOOL isToday;
@property (nonatomic, assign) BOOL hidden;

@property (nonatomic, strong) NSNumber *round;//轮次
@property (nonatomic, copy) NSString *seasonName;//赛季

@end

NS_ASSUME_NONNULL_END
