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

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
}

#pragma mark - Helper methods

    // Calculates the rect of the visible part of the  collection view.
-(CGRect)currentlyVisibleRect {
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x, self.collectionView.contentOffset.y, CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds));
    
    return visibleRect;
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes forVisibleRect:(CGRect)visibleRect {
    
}

@end
