//
//  LVCDetailViewController.m
//  Loans
//
//  Created by Luis Valdés on 21/8/15.
//  Copyright (c) 2015 Luis Valdés. All rights reserved.
//

#import "LVCDetailViewController.h"

#import "LVCLoan.h"
#import "LVCLocation.h"

#import "LVCImageHelper.h"

#import <AFNetworking/UIImageView+AFNetworking.h>


@interface LVCDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *activityText;
@property (weak, nonatomic) IBOutlet UILabel *locationText;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation LVCDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _configureView];
}

- (void)setLoan:(LVCLoan *)newLoan {
    if (_loan != newLoan) {
        _loan = newLoan;
        
        // Update the view.
        [self _configureView];
    }
}

#pragma mark - Private methods

- (void)_configureView {
    if (!self.loan || !self.isViewLoaded) {
        return;
    }
    NSURL *imageURL = [[LVCImageHelper sharedHelper] URLForImageId:self.loan.imageId withSize:CGRectGetHeight(self.imageView.frame)];
    [self.imageView setImageWithURL:imageURL placeholderImage:nil];
    
    self.titleLabel.text = self.loan.name;
    self.subtitleLabel.text = self.loan.status;
    
    self.activityText.text = [NSString stringWithFormat:@"%@ / %@", self.loan.activity, self.loan.sector];
    self.locationText.text = self.loan.location.title;
    
    [self _addPoint:self.loan.location toMap:self.mapView];
}

- (void)_addPoint:(id<MKAnnotation>)point toMap:(MKMapView *)mapView {
    [mapView removeAnnotations:mapView.annotations];
    [mapView addAnnotation:point];
    [mapView showAnnotations:mapView.annotations animated:NO];
    mapView.camera.altitude *= 5; // Zoom out
}

#pragma mark -


@end
