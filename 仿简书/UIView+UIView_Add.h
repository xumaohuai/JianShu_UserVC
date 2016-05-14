//
//  UIView+UIView_Add.h
//  仿简书
//
//  Created by 徐茂怀 on 16/5/5.
//  Copyright © 2016年 徐茂怀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (UIView_Add)
//x坐标属性
@property (nonatomic,assign)CGFloat x;
//y坐标
@property (nonatomic,assign)CGFloat y;
//宽度
@property (nonatomic,assign)CGFloat width;
//高度
@property (nonatomic,assign)CGFloat height;
//大小
@property (nonatomic,assign)CGSize size;
//位置
@property (nonatomic,assign)CGPoint origin;
//中心点x
@property (nonatomic,assign)CGFloat centerX;
//中心点y
@property (nonatomic,assign)CGFloat centerY;
//右侧 X
@property (nonatomic,assign)CGFloat rightX;
//底部 Y
@property (nonatomic,assign)CGFloat bottomY;

- (void)layerBordeColor:(UIColor *)color
            borderWidth:(CGFloat)borderWidth
      roundedCornerWith:(CGFloat)cornerRadius;
@end
