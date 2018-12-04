//
//  YFCircleProgressView.h
//  Circle
//
//  Created by meorient on 2018/12/3.
//  Copyright © 2018 MYF. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YFCircleProgressView : UIView

/** 分数字体 */
@property (nonatomic, strong) UIFont *font;
/** 分数颜色 */
@property (nonatomic, strong) UIColor *textColor;
/** 渐变色 */
@property (nonatomic, strong) NSMutableArray *shadowColors;
/** 剩余进度颜色 */
@property (nonatomic, strong) UIColor *residueColor;
/** 圆环宽度 */
@property (nonatomic, assign) CGFloat progressWidth;
/** 进度 */
@property (nonatomic, assign) CGFloat progress;
@end

NS_ASSUME_NONNULL_END
