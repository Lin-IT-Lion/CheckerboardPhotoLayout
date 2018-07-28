//
//  CBLayoutHelper.m
//  CBPhotoLayout
//
//  Created by 幸.😳 on 2018/7/28.
//  Copyright © 2018年 林国强. All rights reserved.
//

#import "CBLayoutHelper.h"
#import "CBLayoutUnity.h"

@interface CBLayoutHelperConfig()

@property (nonatomic, assign) CGFloat minWidth;
@property (nonatomic, assign) CGFloat minSpace;
@property (nonatomic, assign) CGFloat overlapRatio;


@end

@implementation CBLayoutHelperConfig

- (instancetype)init {
    
    self = [super init];
    if (self) {
        //不可再修改
        self.minWidth = 40.f;
        self.minSpace = -10.f;
        self.overlapRatio = 1/4.f;
        
        
        //可以修改
        self.spaceRatio = 0;
        self.xOffestRatio = 0.f;
        self.yOffestRatio = 0.f;

        self.canvasFrame = [UIScreen mainScreen].bounds;
    }
    return self;
}

#pragma mark - get & set

- (CGFloat)minWidth {
    return _minWidth <= 0 ? 1 : _minWidth;
}

- (CGFloat)spaceRatio {
    return MIN(1, MAX(-self.overlapRatio, _spaceRatio));
}

- (CGFloat)overlapRatio {
    return MIN(1, ABS(_overlapRatio));
}

- (CGFloat)xOffestRatio {
    return MAX(-1/2.f, MIN(1/2.f, _xOffestRatio));
}

- (CGFloat)yOffestRatio {
    return MAX(-1/2.f, MIN(1/2.f, _yOffestRatio));
}

@end

@interface CBLayoutHelper()

@property (nonatomic, strong, readwrite) CBLayoutHelperConfig *config;

@property (nonatomic, assign, readwrite) CGSize singleSize;

@property (nonatomic, strong, readwrite) NSMutableArray *pointList;

@end

@implementation CBLayoutHelper

+ (instancetype)layoutHelperWithConfig:(CBLayoutHelperConfig *)config {
    
    __kindof CBLayoutHelper *helper = [[[self class] alloc] init];
    
    helper.config = config;
    
    return helper;
}

#pragma mark - public
- (CGRect)loadFrameWithIndex:(NSInteger)index {
    
    return CGRectZero;
}

#pragma mark - private

- (void)resetWithItemSize:(CGSize)size {
    if (size.width <= 0 || size.height <= 0) {
        return;
    }
    
    CGFloat w = self.config.minWidth;
    CGFloat ratio = size.width / w;
    self.singleSize = CGSizeMake(self.config.minWidth, size.height / ratio);
    
    [self clacPointList];
    
}

- (void)clacPointList {
    [self.pointList removeAllObjects];
    
    NSInteger col = ceilf(((self.config.canvasFrame.size.width - self.config.overlapRatio * self.singleSize.width) / (self.singleSize.width - self.config.overlapRatio * self.singleSize.width)) * 2);
    NSInteger row = ceilf(((self.config.canvasFrame.size.height - self.config.overlapRatio * self.singleSize.height) / (self.singleSize.height - self.config.overlapRatio * self.singleSize.height)) * 2);
    
    CGPoint centerPoint = CGPointMake(col/2, row/2);
    CGPoint centerPointLocal = CGPointMake(CGRectGetMidX(self.config.canvasFrame), CGRectGetMidY(self.config.canvasFrame));
    
    
    //间隔
    CGFloat sw = self.config.spaceRatio * self.singleSize.width;
    CGFloat sh = self.config.spaceRatio * self.singleSize.height;
    
    
    //拉伸x
    CGFloat xOffest = self.config.xOffestRatio * self.singleSize.width;
    
    CGFloat yOffest = self.config.yOffestRatio * self.singleSize.height;
    
    for (int r = 0; r < row; r ++) {
        NSMutableArray<NSDictionary *> *rlist = @[].mutableCopy;
        for (int c = 0; c < col; c ++) {
            CGFloat x = 0;
            CGFloat y = 0;
            x = centerPointLocal.x - (centerPoint.x - c) * (self.singleSize.width + sw);
            y = centerPointLocal.y - (centerPoint.y - r) * (self.singleSize.height + sh);
            
//            BOOL isCenterRow = centerPoint.y == r;
//            BOOL isCenterCol = centerPoint.x == c;
            
            x += xOffest * (centerPoint.y - r);
            y += yOffest * (centerPoint.x - c);
            
            NSMutableDictionary *param = @{}.mutableCopy;
            param[@"point"] = NSStringFromCGPoint(CGPointMake(x, y));
            
            [rlist addObject:param];
        }
        [self.pointList addObject:rlist];
    }
    NSLog(@"row %ld col%ld",row,col);
    
    NSLog(@"================================");
    
    NSLog(@"%@",self.pointList);
    
}

#pragma mark - set & get

- (NSMutableArray *)pointList {
    if (!_pointList) {
        _pointList = @[].mutableCopy;
    }
    return _pointList;
}

@end
