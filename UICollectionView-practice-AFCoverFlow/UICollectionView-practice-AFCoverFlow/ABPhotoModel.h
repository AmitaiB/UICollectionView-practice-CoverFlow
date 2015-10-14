//
//  ABPhotoModel.h
//  UICollectionView-practice-AFCoverFlow
//
//  Created by Amitai Blickstein on 10/13/15.
//  Copyright © 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ABPhotoModel : NSObject

+(instancetype)photoModelWithImage:(UIImage *)image;

@property (nonatomic, strong) UIImage *image;

@end
