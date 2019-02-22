//
//  MMCalendarTool.h
//  MMCalendar
//
//  Created by 各连明 on 2019/2/21.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MMCalendarTool : NSObject

+ (UILabel *)labelWithTextColor:(UIColor *)textColor fontSize:(CGFloat)fontSize;
+ (UILabel *)labelWithTextColor:(UIColor *)textColor fontSize:(CGFloat)fontSize fontName:(NSString *)fontName;
+ (UILabel *)labelWithFrame:(CGRect)frame textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize;
+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
