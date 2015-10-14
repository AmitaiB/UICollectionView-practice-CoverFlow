//
//  ABCollectionViewLayoutAttributes.h
//  UICollectionView-practice-AFCoverFlow
//
//  Created by Amitai Blickstein on 10/13/15.
//  Copyright © 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes

@property (nonatomic, assign) BOOL shouldRasterize;
@property (nonatomic, strong) CGFloat maskingValue;

@end
