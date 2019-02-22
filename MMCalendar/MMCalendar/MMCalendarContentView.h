//
//  MMCalendarContentView.h
//  MMCalendar
//
//  Created by 各连明 on 2019/2/22.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMCalendarContentView : UIView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id)delegate;

@property (nonatomic, weak) id delegate;

- (void)reloadMonthViewWithDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
