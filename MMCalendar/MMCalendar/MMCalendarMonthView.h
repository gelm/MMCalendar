//
//  MMCalendarMonthView.h
//  MMCalendar
//
//  Created by 各连明 on 2019/2/21.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMCalendarProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface MMCalendarMonthView : UIView

+ (instancetype)initWithFrame:(CGRect)frame dataSource:(id<MMCalendarMonthDataSource>)dataSource;

@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, weak) id<MMCalendarMonthDataSource>dataSource;
@property (nonatomic, weak) id<MMCalendarMonthDelegate>delegate;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
