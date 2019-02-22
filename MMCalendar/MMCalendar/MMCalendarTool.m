//
//  MMCalendarTool.m
//  MMCalendar
//
//  Created by 各连明 on 2019/2/21.
//  Copyright © 2019年 GELM. All rights reserved.
//

#import "MMCalendarTool.h"

@implementation MMCalendarTool

+ (UILabel *)labelWithTextColor:(UIColor *)textColor fontSize:(CGFloat)fontSize {
    UILabel *label = k_createLabel(CGRectZero, textColor, [UIFont systemFontOfSize:fontSize], nil);
    return label;
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor fontSize:(CGFloat)fontSize fontName:(NSString *)fontName {
    UILabel *label = k_createLabel(CGRectZero, textColor, [UIFont fontWithName:fontName size:fontSize], nil);
    return label;
}

+ (UILabel *)labelWithFrame:(CGRect)frame textColor:(UIColor *)textColor fontSize:(CGFloat)fontSize {
    UILabel *label = k_createLabel(frame, textColor, [UIFont systemFontOfSize:fontSize], nil);
    return label;
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font {
    UILabel *label = k_createLabel(CGRectZero, textColor, font, nil);
    return label;
}

UILabel * k_createLabel(CGRect frame, UIColor *textColor, UIFont *font, NSString *text) {
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = textColor?textColor:[UIColor blackColor];
    label.font = font;
    label.backgroundColor = [UIColor clearColor];
    label.text = text;
    return label;
}

@end
