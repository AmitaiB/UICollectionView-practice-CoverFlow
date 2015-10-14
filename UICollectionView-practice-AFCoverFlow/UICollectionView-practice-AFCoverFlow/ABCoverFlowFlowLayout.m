//
//  ABCoverFlowFlowLayout.m
//  UICollectionView-practice-AFCoverFlow
//
//  Created by Amitai Blickstein on 10/14/15.
//  Copyright © 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import "ABCoverFlowFlowLayout.h"
#import "ABCollectionViewLayoutAttributes.h"

/*
 
 All of the math for the cover flow layout was taken from
 https://github.com/mpospese/IntroducingCollectionViews ,
 used with permission of the autor, Mark Pospesel, to whom
 I'm grateful for contributing to the open source community. (AF)
 
 */

#define ACTIVE_DISTANCE         100
#define TRANSLATE_DISTANCE      100
#define ZOOM_FACTOR             0.2f
#define FLOW_OFFSET             40
#define INACTIVE_GREY_VALUE     0.6f

@implementation ABCoverFlowFlowLayout

#pragma mark - Overridden Methods

-(instancetype)init {
    if (!(self = [super init])) return nil;
    
        //Set up our basic properties
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.itemSize = CGSizeMake(180, 180);
    self.minimumLineSpacing = -60; //Gets items up close to one another...
    self.minimumInteritemSpacing = 200; //Makes sure we only have 1 row of items in portrait mode
    
    return self;
}

+(Class)layoutAttributesClass {
    return [ABCollectionViewLayoutAttributes class];
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//    When the user scrolls, the transforms of the cells should be recalculated
    return YES;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
        //First populate an array of the standard attributes...
    NSArray *layoutAttributesArray = [super layoutAttributesForElementsInRect:rect];
    
        //Grabs the rect of the *visible* collectionView.
        //We don't want to call the method in the loop.
    CGRect visibleRect = [self currentlyVisibleRect];
    
    for (UICollectionViewLayoutAttributes *attributes in layoutAttributesArray) {
            //We will only lay out cells that are visible, for performance.
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [self applyLayoutAttributes:attributes forVisibleRect:visibleRect];
        }
    }
    return layoutAttributesArray;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];

    [self applyLayoutAttributes:attributes forVisibleRect:[self currentlyVisibleRect]];
    
    return attributes;
}

//This method provides allows us to define where the collection view will “snap” to.
/**
 1) Use the existing code in layoutAttributesForElementsInRect: to get the attributes for the elements in the proposed rect.
 2) Find the attribute whose item will be closest to the center of the proposed visible rect.
 3) Find out how far away that item will be and,
 4) ...return an adjusted content offset that centers that view.
 */
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);

        //Use the center to find the proposed visible rect.
    CGRect proposedRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);

        //Get the attributes for the cells in that rect.
    NSArray *array = [self layoutAttributesForElementsInRect:proposedRect];
    
        //This loop will find the closest cell to the propsed center of the collection view.
    for (UICollectionViewLayoutAttributes *layoutAttributes in array)
    {
            //We want to skip supplementary views
        if (layoutAttributes.representedElementKind != UICollectionElementCategoryCell) continue;
        
            //Determine if this layout attribute's cell is closer than the closest we have so far.
        CGFloat itemHoritzontalCenter = layoutAttributes.center.x;
        if (fabsf(itemHoritzontalCenter - horizontalCenter) < fabsf(offsetAdjustment))
        {
            offsetAdjustment = itemHoritzontalCenter - horizontalCenter;
        }
    }
    
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

#pragma mark - Helper methods

    // Calculates the rect of the visible part of the  collection view.
-(CGRect)currentlyVisibleRect {
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y, CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds));
    
    return visibleRect;
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes forVisibleRect:(CGRect)visibleRect {
        //Applies the cover flow effect to the given layout attributes.
    
        //We want to skip the supplementary views. (nil == cell.)
    if (attributes.representedElementKind) return;
    
// Calculate the 𝚫x from: visibleRect.center to: attributes.center.
// Then normalize it so we can compare them all. This way, all items further away than the activeDistance get the same transform.
    
    CGFloat distanceFromVisibleRectToItem = CGRectGetMidX(visibleRect) - attributes.center.x;
    CGFloat normalizedDistance = distanceFromVisibleRectToItem / ACTIVE_DISTANCE;
    BOOL isOnTheLeft = distanceFromVisibleRectToItem > 0;
    CATransform3D transform = CATransform3DIdentity;
    
    CGFloat maskAlpha = 0.0f;
    
    if (fabsf(distanceFromVisibleRectToItem) < ACTIVE_DISTANCE) {
            //We're close enough to mid-x to apply the transform.
            //???: Edification: Grok this!
        transform = CATransform3DTranslate(CATransform3DIdentity, (isOnTheLeft? -1 : 1) * FLOW_OFFSET * ABS(distanceFromVisibleRectToItem / TRANSLATE_DISTANCE), 0, (1 - fabsf(normalizedDistance)) * 40000 + (isOnTheLeft? 200 : 0));
        
            //Set the perspective of the transform.
        transform.m34 = -1/(4.6777 * self.itemSize.width);
        
            //Set the zoom factor.
        CGFloat zoom = 1 + ZOOM_FACTOR * (1 - ABS(normalizedDistance));
        transform = CATransform3DRotate(transform, (isOnTheLeft? 1 : -1) * fabsf(normalizedDistance) * 45 * M_PI / 180, 0, 1, 0);
        transform = CATransform3DScale(transform, zoom, zoom, 1);
        attributes.zIndex = 1;
        
        CGFloat ratioToCenter = (ACTIVE_DISTANCE - fabsf(distanceFromVisibleRectToItem)) / ACTIVE_DISTANCE;
            //Interpolate between 0.0f and INACTIVE_GREY_VALUE
        maskAlpha = INACTIVE_GREY_VALUE + ratioToCenter * (-INACTIVE_GREY_VALUE);
    }
    else
    {
            //We're too far away; just apply a standard perspective transform.
        
        transform.m34 = -1/(4.6777 * self.itemSize.width);
        transform = CATransform3DTranslate(transform, (isOnTheLeft? -1 : 1) * FLOW_OFFSET, 0, 0);
        transform = CATransform3DRotate(transform, (isOnTheLeft? 1 : -1) * 45 * M_PI / 180, 0, 1, 0);
        attributes.zIndex = 0;
        
        maskAlpha = INACTIVE_GREY_VALUE;
    }
    
    attributes.transform3D = transform;
    
        //Rasterize the cells for smoother edges.
    [(ABCollectionViewLayoutAttributes *)attributes setShouldRasterize:YES];
        [(ABCollectionViewLayoutAttributes *)attributes
         setMaskingValue:maskAlpha];
    
}

@end
