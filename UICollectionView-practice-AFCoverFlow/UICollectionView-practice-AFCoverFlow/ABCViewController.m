//
//  ABCViewController.m
//  UICollectionView-practice-AFCoverFlow
//
//  Created by Amitai Blickstein on 10/13/15.
//  Copyright © 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import "ABCViewController.h"

    //Views
#import "ABCollectionViewCell.h"
#import "ABCoverFlowFlowLayout.h"

    //Models
#import "ABPhotoModel.h"

@interface ABCViewController (Private)

-(void)setupModel;

@end

@implementation ABCViewController
{
        //Array of selection objects
    NSArray *photoModelArray;
    
    UISegmentedControl *layoutChangeSegmentedControl;
    
    ABCoverFlowFlowLayout *coolFlowLayout;
    UICollectionViewFlowLayout *boringCollectionViewLayout;
}

static NSString * const cellReuseID = @"CellReuseID";

-(void)loadView {
        //Create our view
    
        //Create our awesome cover flow layout
    coolFlowLayout = [ABCoverFlowFlowLayout new];
    
        //Create a basic flow layout that will accomodate three columsn in portrait
    boringCollectionViewLayout                         = [UICollectionViewFlowLayout new];
    boringCollectionViewLayout.itemSize                = CGSizeMake(120, 120);
    boringCollectionViewLayout.minimumLineSpacing      = 10.0f;
    boringCollectionViewLayout.minimumInteritemSpacing = 10.0f;
    boringCollectionViewLayout.sectionInset            = UIEdgeInsetsZero;

        //Create a new collection view with our flow layout and set the datasource and delegate
    UICollectionView *photoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:boringCollectionViewLayout];
    photoCollectionView.dataSource        = self;
    photoCollectionView.delegate          = self;
    
        //Register our classes
    [photoCollectionView registerClass:[ABCollectionViewCell class] forCellWithReuseIdentifier:cellReuseID];
    
        // Set up the collection view geometry to cover the whole screen in any orientation and other view properties
    photoCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    photoCollectionView.allowsSelection  = NO;
    photoCollectionView.indicatorStyle   = UIScrollViewIndicatorStyleWhite;
    
        // Finally, set our collectionView (since we are a collection view controller, this also sets self.view)
    self.collectionView = photoCollectionView;
    
        // Set up our model
    [self setupModel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
        //Create a segControl in the navBar
    layoutChangeSegmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Boring", @"Cover Flow"]];
    layoutChangeSegmentedControl.selectedSegmentIndex = 0;
    [layoutChangeSegmentedControl addTarget:self action:@selector(layoutChangesSegmentedControlDidChangeValue:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = layoutChangeSegmentedControl;
}

#pragma mark - Helper methods

-(ABPhotoModel *)photoModelForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item >= [photoModelArray count]) return nil;
    
    return photoModelArray[indexPath.item];
}

-(void)configureCell:(ABCollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    [cell setImage:[[self photoModelForIndexPath:indexPath] image]];
}

#pragma mark - === UICollectionViewDataSource ===

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        //An item for each photo.
    return [photoModelArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ABCollectionViewCell *cell = (ABCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellReuseID forIndexPath:indexPath];
    
    // Configure the cell
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (collectionViewLayout == boringCollectionViewLayout) {
            //A basic flow layout that will accomodate three columns in a portrait.
        return UIEdgeInsetsMake(10, 20, 10, 20);
    }
    else
    {
        if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
                //Portrait is the same in either orientation
            return UIEdgeInsetsMake(0, 70, 0, 70);
        }
        else
        {
                //We need to get the height of the main screen to see if we're running on a 4" screen. If so, we need extra side padding.
                //UPDATE: There must be a better way to do this in iOS 9+...
            if (CGRectGetHeight([[UIScreen mainScreen] bounds]) > 480) {
                return UIEdgeInsetsMake(0, 190, 0, 190);
            }
            else
            {
                return UIEdgeInsetsMake(0, 150, 0, 150);
            }
        }
    }
}

#pragma mark - UI Interaction
 
 -(void)layoutChangesSegmentedControlDidChangeValue:(id)sender
 {
         // Change to the alternate layout
     
     if (layoutChangeSegmentedControl.selectedSegmentIndex == 0) {
         [self.collectionView setCollectionViewLayout:boringCollectionViewLayout animated:NO];
     }
     else
     {
         [self.collectionView setCollectionViewLayout:coolFlowLayout animated:NO];
     }
     
         // Invalidate the new layout
     [self.collectionView.collectionViewLayout invalidateLayout];
 }

@end








@implementation ABCViewController (Private)

-(void)setupModel
{
    photoModelArray = @[
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"1.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"2.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"3.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"4.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"5.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"6.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"7.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"8.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"9.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"10.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"11.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"12.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"13.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"17.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"15.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"14.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"16.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"18.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"19.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"21.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"21.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"22.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"23.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"24.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"25.jpg"]],
                        [ABPhotoModel photoModelWithImage:[UIImage imageNamed:@"26.jpg"]]];
}

@end
