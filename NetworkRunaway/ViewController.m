//
//  ViewController.m
//  NetworkRunaway
//
//  Created by Gary Kagan on 9/18/15.
//  Copyright © 2015 GK. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworkActivityLogger.h>
#import <AFNetworking.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    self.manager = [AFHTTPRequestOperationManager manager];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)download:(id)sender {
    AFHTTPRequestOperation *downloadOperation = [self.manager GET:@"https://www.tailorbrands.com/business-logo-design/img/categories/abstract/apple-logo.png" parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        //
    }];
    [downloadOperation setOutputStream:[NSOutputStream outputStreamToFileAtPath:@"test.png" append:NO]];
    self.downloadButton.enabled = NO;
    self.cancelButton.enabled = YES;
    
    [downloadOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        NSLog(@"Got %lli bytes", totalBytesRead);
    }];
}

- (IBAction)cancel:(id)sender {
    [[self.manager operationQueue] cancelAllOperations];
    self.downloadButton.enabled = YES;
    self.cancelButton.enabled = NO;
}

@end
