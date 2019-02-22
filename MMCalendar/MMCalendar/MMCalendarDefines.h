//
//  MMCalendarDefines.h
//  MMCalendar
//
//  Created by 各连明 on 2019/2/22.
//  Copyright © 2019年 GELM. All rights reserved.
//

#ifndef MMCalendarDefines_h
#define MMCalendarDefines_h

#define MM_UIColorFromRGB(rgbValue)[UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:1.0]

#define MM_SCREEN_WIDTH  CGRectGetWidth([UIScreen mainScreen].bounds)
#define MM_SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

#define MM_calendarContentHeight 350

#endif /* MMCalendarDefines_h */
