//
//  ViewController.m
//  TableViewTest
//
//  Created by zty on 16/8/22.
//  Copyright © 2016年 zty. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "GLImageCell.h"
#import "Method3Cell.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //方法四
//    UINib *firstNib = [UINib nibWithNibName:@"Method3Cell" bundle:nil];
//    [_tableView registerNib:firstNib forCellReuseIdentifier:@"Method3"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 77;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 77;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //不使用复用
//    GLImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLImageCell123"];

    static int times = 0;  //只在程序第一次运行的时候编译
    
    //方法一
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"qwer"];
    
    //方法二
    GLImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GLImageCell"];
    
    //方法三
//    Method3Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"method3"];
    
    //方法四
//    Method3Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"Method3" forIndexPath:indexPath];
    
    if (cell == nil) {
        //不使用复用
//        cell = [[GLImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GLImageCell123"];
        
        //方法一
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"qwer"];
    
        //方法二(xib)，在GLImageCell.xib文件中identifier中输入GLImageCell，在GLImageCell.m中复写initWithStyle reuseIdentifier方法
        cell = [[GLImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GLImageCell"];
        
        //方法三(xib)
//        cell = [[[NSBundle mainBundle]loadNibNamed:@"Method3Cell" owner:self options:nil]lastObject];
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        [tableView registerNib:[UINib nibWithNibName:@"Method3Cell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"method3"];
        

        times++;
        NSLog(@"time : %d",times);
    }
    
    //第二种输出
    NSLog(@"＋＋＋＋＋＋＋＋＋before:%@",cell.textLabel.text);
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSLog(@"－－－－－－－－－after:%@",cell.textLabel.text);
    
    return cell;
    //打开xcode7，最上面一栏点击help  再点击  Documentation and API Reference
    //dequeueReusableCellWithIdentifier 这个方法
    /*
     第二行起是关键，翻看官方文档中关于方法dequeueReusableCellWithIdentifier:的说明：
     
     For performance reasons, a table view’s data source should generally reuse UITableViewCell objects when it assigns cells to rows in its tableView:cellForRowAtIndexPath: method. A table view maintains a queue or list of UITableViewCell objects that the data source has marked for reuse. Call this method from your data source object when asked to provide a new cell for the table view. This method dequeues an existing cell if one is available or creates a new one using the class or nib file you previously registered. If no cell is available for reuse and you did not register a class or nib file, this method returns nil.
     
     If you registered a class for the specified identifier and a new cell must be created, this method initializes the cell by calling its initWithStyle:reuseIdentifier: method. For nib-based cells, this method loads the cell object from the provided nib file. If an existing cell was available for reuse, this method calls the cell’s prepareForReuse method instead.
     
     翻译一下 大意就是：
     
     出于性能的原因，一个表视图的数据源应该采用可复用的表视图单元对象。一个表视图维护着一个可复用单元的队列或者列表。当要显示一个新的单元的时候就调用这个方法，这个方法会出列一个已经存在的单元。假如没有可以复用的单元那么就返回nil。
     
     说实话不大清楚。还是从表视图的生命周期来说，一开始可复用队列为空，调用dequeueReusableCellWithIdentifier：肯定返回nil。然后就调用initWithStyle:reuseIdentifier:方法来产生并且标识复用记号的表视图单元。满屏显示的时候，滚动表视图，一侧的单元就会被移出屏幕，此时这个单元进入可复用单元队列，然后调用prepareForReuse方法准备一个即将出列的单元， dequeueReusableCellWithIdentifier:从可复用单元队列里出列一个可复用单元。
     
     表视图里可能有不同类型的单元，复用是在相同类型单元里发生的。至于队列里有多少单元，这个系统自己控制，如果内存紧张，就会动态释放掉一些，当条件改善的时候，就会重新获取这些单元便于复用。一个极端的情况，可复用的单元没有了，那么又会调用initWithStyle:reuseIdentifier:来产生新的单元。理解表视图的机制，不能把思维定在严格的队列机制里，它有些动态的因素需要考虑。
     
     此外在if语句下面的操作算是翻新，if语句里的操作应该是新造。
     */
    
    
    //方式一  输出为1,2,3,4,5,6,7,8,9
    //方式二  输出为1,2,3,4,5,6,7,8,9
    //方式三  输出为1 (不管你怎么滑动就是1)
    //方式四  输出为       就是不输出
    
    /* 方式3的第二种输出
    2016-09-08 16:49:18.066 TableViewTest[43861:2739078] time : 1
    2016-09-08 16:49:18.068 TableViewTest[43861:2739078] ＋＋＋＋＋＋＋＋＋before:(null)
    2016-09-08 16:49:18.068 TableViewTest[43861:2739078] －－－－－－－－－after:0
    2016-09-08 16:49:18.071 TableViewTest[43861:2739078] ＋＋＋＋＋＋＋＋＋before:(null)
    2016-09-08 16:49:18.071 TableViewTest[43861:2739078] －－－－－－－－－after:1
    2016-09-08 16:49:18.072 TableViewTest[43861:2739078] ＋＋＋＋＋＋＋＋＋before:(null)
    2016-09-08 16:49:18.072 TableViewTest[43861:2739078] －－－－－－－－－after:2
    2016-09-08 16:49:18.072 TableViewTest[43861:2739078] ＋＋＋＋＋＋＋＋＋before:(null)
    2016-09-08 16:49:18.073 TableViewTest[43861:2739078] －－－－－－－－－after:3
    2016-09-08 16:49:18.073 TableViewTest[43861:2739078] ＋＋＋＋＋＋＋＋＋before:(null)
    2016-09-08 16:49:18.073 TableViewTest[43861:2739078] －－－－－－－－－after:4
    2016-09-08 16:49:18.074 TableViewTest[43861:2739078] ＋＋＋＋＋＋＋＋＋before:(null)
    2016-09-08 16:49:18.098 TableViewTest[43861:2739078] －－－－－－－－－after:5
    2016-09-08 16:49:18.099 TableViewTest[43861:2739078] ＋＋＋＋＋＋＋＋＋before:(null)
    2016-09-08 16:49:18.099 TableViewTest[43861:2739078] －－－－－－－－－after:6
    2016-09-08 16:49:18.100 TableViewTest[43861:2739078] ＋＋＋＋＋＋＋＋＋before:(null)
    2016-09-08 16:49:18.100 TableViewTest[43861:2739078] －－－－－－－－－after:7
    2016-09-08 16:49:18.101 TableViewTest[43861:2739078] ＋＋＋＋＋＋＋＋＋before:(null)
    2016-09-08 16:49:18.101 TableViewTest[43861:2739078] －－－－－－－－－after:8
    2016-09-08 16:49:19.966 TableViewTest[43861:2739078] ＋＋＋＋＋＋＋＋＋before:(null)
    2016-09-08 16:49:19.966 TableViewTest[43861:2739078] －－－－－－－－－after:9
    2016-09-08 16:49:32.542 TableViewTest[43861:2739078] ＋＋＋＋＋＋＋＋＋before:(null)
    2016-09-08 16:49:32.543 TableViewTest[43861:2739078] －－－－－－－－－after:10
    2016-09-08 16:49:37.408 TableViewTest[43861:2739078] ＋＋＋＋＋＋＋＋＋before:1
    2016-09-08 16:49:37.409 TableViewTest[43861:2739078] －－－－－－－－－after:11
     */
    
    /*方式1的第二种输出
     2016-09-08 16:53:31.731 TableViewTest[43916:2742025] time : 1
     2016-09-08 16:53:31.734 TableViewTest[43916:2742025] ＋＋＋＋＋＋＋＋＋before:(null)
     2016-09-08 16:53:31.735 TableViewTest[43916:2742025] －－－－－－－－－after:0
     2016-09-08 16:53:31.736 TableViewTest[43916:2742025] time : 2
     2016-09-08 16:53:31.736 TableViewTest[43916:2742025] ＋＋＋＋＋＋＋＋＋before:(null)
     2016-09-08 16:53:31.737 TableViewTest[43916:2742025] －－－－－－－－－after:1
     2016-09-08 16:53:31.737 TableViewTest[43916:2742025] time : 3
     2016-09-08 16:53:31.738 TableViewTest[43916:2742025] ＋＋＋＋＋＋＋＋＋before:(null)
     2016-09-08 16:53:31.738 TableViewTest[43916:2742025] －－－－－－－－－after:2
     2016-09-08 16:53:31.738 TableViewTest[43916:2742025] time : 4
     2016-09-08 16:53:31.738 TableViewTest[43916:2742025] ＋＋＋＋＋＋＋＋＋before:(null)
     2016-09-08 16:53:31.739 TableViewTest[43916:2742025] －－－－－－－－－after:3
     2016-09-08 16:53:31.739 TableViewTest[43916:2742025] time : 5
     2016-09-08 16:53:31.740 TableViewTest[43916:2742025] ＋＋＋＋＋＋＋＋＋before:(null)
     2016-09-08 16:53:31.740 TableViewTest[43916:2742025] －－－－－－－－－after:4
     2016-09-08 16:53:31.740 TableViewTest[43916:2742025] time : 6
     2016-09-08 16:53:31.741 TableViewTest[43916:2742025] ＋＋＋＋＋＋＋＋＋before:(null)
     2016-09-08 16:53:31.741 TableViewTest[43916:2742025] －－－－－－－－－after:5
     2016-09-08 16:53:31.742 TableViewTest[43916:2742025] time : 7
     2016-09-08 16:53:31.742 TableViewTest[43916:2742025] ＋＋＋＋＋＋＋＋＋before:(null)
     2016-09-08 16:53:31.742 TableViewTest[43916:2742025] －－－－－－－－－after:6
     2016-09-08 16:53:31.743 TableViewTest[43916:2742025] time : 8
     2016-09-08 16:53:31.743 TableViewTest[43916:2742025] ＋＋＋＋＋＋＋＋＋before:(null)
     2016-09-08 16:53:31.744 TableViewTest[43916:2742025] －－－－－－－－－after:7
     2016-09-08 16:53:31.744 TableViewTest[43916:2742025] time : 9
     2016-09-08 16:53:31.745 TableViewTest[43916:2742025] ＋＋＋＋＋＋＋＋＋before:(null)
     2016-09-08 16:53:31.745 TableViewTest[43916:2742025] －－－－－－－－－after:8
     2016-09-08 16:53:38.519 TableViewTest[43916:2742025] time : 10
     2016-09-08 16:53:38.519 TableViewTest[43916:2742025] ＋＋＋＋＋＋＋＋＋before:(null)
     2016-09-08 16:53:38.519 TableViewTest[43916:2742025] －－－－－－－－－after:9
     2016-09-08 16:53:38.604 TableViewTest[43916:2742025] ＋＋＋＋＋＋＋＋＋before:0
     2016-09-08 16:53:38.605 TableViewTest[43916:2742025] －－－－－－－－－after:10
     2016-09-08 16:53:38.688 TableViewTest[43916:2742025] ＋＋＋＋＋＋＋＋＋before:1
     2016-09-08 16:53:38.689 TableViewTest[43916:2742025] －－－－－－－－－after:11
     2016-09-08 16:53:38.740 TableViewTest[43916:2742025] ＋＋＋＋＋＋＋＋＋before:2
     2016-09-08 16:53:38.740 TableViewTest[43916:2742025] －－－－－－－－－after:12
     2016-09-08 16:53:38.808 TableViewTest[43916:2742025] ＋＋＋＋＋＋＋＋＋before:3
     2016-09-08 16:53:38.808 TableViewTest[43916:2742025] －－－－－－－－－after:13
    */
//    方法3中，可复用的cell的text从1开始，从xib中创建的第一个cell，它的identify还没有注册，所以identify值没有，不能复用。复用是从第二个单元格开始
//    方法1中，可复用的cell从第一个单元格开始
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
