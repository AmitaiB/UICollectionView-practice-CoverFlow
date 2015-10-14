//
//  ABCollectionViewLayoutAttributes.m
//  UICollectionView-practice-AFCoverFlow
//
//  Created by Amitai Blickstein on 10/13/15.
//  Copyright © 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import "ABCollectionViewLayoutAttributes.h"

@implementation ABCollectionViewLayoutAttributes

-(id)copyWithZone:(NSZone *)zone {
    ABCollectionViewLayoutAttributes *attributes = [super copyWithZone:zone];
    
    attributes.shouldRasterize = self.shouldRasterize;
//    attributes.maskingValue = self.maskingValue;
    
    return attributes;
}

-(BOOL)isEqual:(ABCollectionViewLayoutAttributes *)object {
    return [super isEqual:object] && (self.shouldRasterize == object.shouldRasterize && self.maskingValue == object.maskingValue);
}

@end
