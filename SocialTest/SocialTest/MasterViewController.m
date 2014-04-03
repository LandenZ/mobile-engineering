//
//  MasterViewController.m
//  SocialTest
//
//  Created by Landen Zackery on 4/3/14.
//  Copyright (c) 2014 A Guy and A Computer. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}

@property (nonatomic) NSURLSession *session;

@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //creates a view to show a loading message and spinning activity wheel while
    //getting data from webservice and formatting
    //apple rules require you to provide this feedback
    self.loadingView = [[UIView alloc] initWithFrame:self.view.frame];
    [self.loadingView setBackgroundColor:[UIColor lightGrayColor]];
    
    UIActivityIndicatorView *actInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [actInd setFrame:CGRectMake((self.loadingView.frame.size.width / 2 - 10), (self.loadingView.frame.size.height / 2 - 10), 20, 20)];
    
    UILabel *lblLoading = [[UILabel alloc] initWithFrame:CGRectMake((self.loadingView.frame.size.width / 2 - 30), (self.loadingView.frame.size.height / 2 - 5), 80, 30)];
    lblLoading.text = @"Loading";
    
    [self.loadingView addSubview:actInd];
    [self.loadingView addSubview:lblLoading];
    
    [actInd startAnimating];

    [self.tableView addSubview:_loadingView];
    
    //register nib with the custom UITableViewCell in it so it can be later used
    UINib *nib = [UINib nibWithNibName:@"DealDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"DealDetailCell"];
    
    //initialize object array if it is not initialized
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    
    //if objects array does not have any elements, call webservice to get json
    //response
    if ([_objects count] == 0) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:config
                                                     delegate:nil
                                                delegateQueue:nil];
        
        [self fetchFeed];
    }
    
}

-(void)fetchFeed
{
    NSString *requestString = @"http://sheltered-bastion-2512.herokuapp.com/feed.json";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:req
                                                     completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        [self convertFeedToDealDetails:jsonObject];
        
        //force the main thread to reload the table view with the data from the webservice
        dispatch_async(dispatch_get_main_queue(), ^
        {
            [self.tableView reloadData];
            
            //removes loading view
            [self.loadingView removeFromSuperview];
        });
                                                         
    }];
    [dataTask resume];
}

-(void)convertFeedToDealDetails:(NSDictionary *)jsonDictionary
{
    for (NSDictionary *entry in jsonDictionary) {
        DealDetail *deal = [DealDetail getDealFromDictionaryEntry:entry];
        [_objects addObject:deal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DealDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DealDetailCell" forIndexPath:indexPath];
    
    DealDetail *deal = _objects[indexPath.row];

    cell.titleLabel.text = deal.title;
    cell.dealImageView.image = deal.dealPic;
    cell.locationLabel.text = deal.location;
    cell.userImageView.image = deal.userPic;
    cell.userLabel.text = deal.userName;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DealDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DealDetailCell"];
    
    return cell.bounds.size.height;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier: @"showDetail" sender: self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DealDetail *deal = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:deal];
    }
}

@end
