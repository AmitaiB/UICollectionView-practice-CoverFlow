//
//  ABCollectionViewCell.m
//  UICollectionView-practice-AFCoverFlow
//
//  Created by Amitai Blickstein on 10/14/15.
//  Copyright © 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import "ABCollectionViewCell.h"
#import "ABCollectionViewLayoutAttributes.h"

@implementation ABCollectionViewCell {
    UIImageView *imageView;
    UIView *maskView;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) return nil;
    
        //Set up our imageView
    imageView = [[UIImageView alloc] initWithFrame:CGRectInset(CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)), 10, 10)];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.clipsToBounds = YES;
    [self.contentView addSubview:imageView];
    
    maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    maskView.backgroundColor = [UIColor blackColor];
    maskView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    maskView.alpha = 0.0f;
    [self.contentView insertSubview:maskView aboveSubview:imageView];
    
        // This will make the rest of the cell outside the imageView appear transparent against a black(?) background.
    self.backgroundColor = [UIColor blackColor];
    
    return self;
}

#pragma mark - Overridden Methods

-(void)prepareForReuse {
    [super prepareForReuse];
    
    [self setImage:nil];
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    maskView.alpha = 0.0f;
    self.layer.shouldRasterize = NO;
    
        //Important check!
    if (![layoutAttributes isKindOfClass:[ABCollectionViewLayoutAttributes class]]) {
        return;
    }
    
    ABCollectionViewLayoutAttributes *castedLayoutAttributes = (ABCollectionViewLayoutAttributes *)layoutAttributes;
    
    self.layer.shouldRasterize = castedLayoutAttributes.shouldRasterize;
    maskView.alpha = castedLayoutAttributes.maskingValue;
}

#pragma mark - Public methods

-(void)setImage:(UIImage *)image {
    [imageView setImage:image];
}

@end
