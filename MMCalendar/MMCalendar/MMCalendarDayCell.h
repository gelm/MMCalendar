//
//  MMCalendarDayCell.h
//  MMCalendar
//
//  Created by 各连明 on 2019/2/21.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMCalendarDayItem;

NS_ASSUME_NONNULL_BEGIN

@interface MMCalendarDayCell : UICollectionViewCell

@property (nonatomic, strong) MMCalendarDayItem *item;

@end

NS_ASSUME_NONNULL_END
