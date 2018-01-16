//
//  HYSystemMessageVC.m
//  DaCongMing
//
//

#import "HYSystemMessageVC.h"
#import "HYSystemMessageCell.h"
#import "HYPayParterCostViewController.h"
#import "HYMineNetRequest.h"
#import "HYSystemMessageModel.h"

@interface HYSystemMessageVC ()

@end

@implementation HYSystemMessageVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"系统消息";
    [self requestData];
}

- (void)requestData{
    
    [HYMineNetRequest getSystemInfoWithPageNo:1 ComplectionBlock:^(NSArray *datalist) {
       
        if (datalist) {
            
            [datalist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                HYSystemMessageModel *model = [HYSystemMessageModel modelWithDictionary:obj];
                [self.datalist addObject:model];
                
            }];
            
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.datalist.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *systemMessageCellID = @"systemMessageCellID";
    HYSystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:systemMessageCellID];
    if (!cell) {
        cell = [[HYSystemMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:systemMessageCellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.model = self.datalist[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120 * WIDTH_MULTIPLE;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.navigationController pushViewController:[HYPayParterCostViewController new] animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
