//
//  UIImage+add.m
//  TWJ
//
//  Created by ydd on 2019/8/9.
//  Copyright © 2019 zlx. All rights reserved.
//

#import "UIImage+add.h"

@implementation UIImage (add)
+ (UIImage *)imageFromColor:(UIColor *)corlor{
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 20.0f, 20.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [corlor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
@end
