//
//  ABPhotoModel.m
//  UICollectionView-practice-AFCoverFlow
//
//  Created by Amitai Blickstein on 10/13/15.
//  Copyright © 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import "ABPhotoModel.h"

@implementation ABPhotoModel

+(instancetype)photoModelWithImage:(UIImage *)image {
    ABPhotoModel *model = [ABPhotoModel new];
    
    model.image = image;
    
    return model;
}

@end
