Tips
====

对 MBProgressHUD 做了简单的封装，便于使用。


自动隐藏的文字：

    [CWHUDTips showTips:@"自动隐藏的文字"];
    
显示转菊花的文字：

    [CWHUDTips showLoadingTips:@"加载中..."];
    
隐藏：

    [CWHUDTips hideTips];
    
    
我通常是配合 UIViewController 的扩展使用。