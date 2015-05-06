//
//  SearchLocationViewController.m
//  Forecast
//
//  Created by luck-mac on 15/5/6.
//  Copyright (c) 2015年 com.nju.luckymore. All rights reserved.
//

#import "SearchLocationViewController.h"
#import "LocationAPIHelper.h"
#import "MBProgressHUD.h"
@interface SearchLocationViewController ()<UISearchBarDelegate,LocationAPIDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *searchResultArray;
@end

@implementation SearchLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchBar.keyboardAppearance = UIKeyboardAppearanceDark;
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar.text.length > 0) {
        LocationAPIHelper* locationApi = [[LocationAPIHelper alloc] init];
        locationApi.delegate = self;
        [locationApi getLocationInfosWithKeyword:searchBar.text];
        [self.view endEditing:YES];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    [self.presenter dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -LocationAPIDelegate
- (void)receiveLocationInfo:(LocationResultModel *)location {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    _searchResultArray = location.geonames;
    [_tableView reloadData];
}

#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GeonamesModel* model = [GeonamesModel objectWithKeyValues:_searchResultArray[indexPath.row]];
    [_presenter setSelectedLocation:model];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchResultArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GeonamesModel* model = [GeonamesModel objectWithKeyValues:_searchResultArray[indexPath.row]];
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.textLabel setText:model.name];
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
