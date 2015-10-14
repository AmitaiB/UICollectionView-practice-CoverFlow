//
//  ABCViewController.m
//  UICollectionView-practice-AFCoverFlow
//
//  Created by Amitai Blickstein on 10/13/15.
//  Copyright © 2015 Amitai Blickstein, LLC. All rights reserved.
//

#import "ABCViewController.h"

    //Views
    //cell
    //layout

    //Models
    //photomodel

@interface ABCViewController (Private)

-(void)setupModel;

@end

@implementation ABCViewController
{
        //Array of selection objects
    NSArray *photoModelArray;
    
    UISegmentedControl *layoutChangeSegmentedControl;
    
    
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end









@implementation AFViewController (Private)

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
