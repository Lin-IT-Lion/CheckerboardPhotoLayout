//
//  CBLayoutUnity.m
//  CBPhotoLayout
//
//  Created by 幸.😳 on 2018/7/28.
//  Copyright © 2018年 林国强. All rights reserved.
//

#import "CBLayoutUnity.h"

@implementation CBLayoutUnity

@end

CGFloat clacDiagonal(CGRect frame) {
    return sqrt(pow(CGRectGetWidth(frame),2) + pow(CGRectGetHeight(frame),2));
}
