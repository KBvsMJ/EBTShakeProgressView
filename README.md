# EBTShakeProgressView 带有动画抖动的进度view
#使用步骤：
 1:在故事本或者xib上拖一个view,然后将这个view的class改为EBTShakeProgressView，
 然后将这个view托线条出去进行设置这个view的progress属性。
 
 2:
 @property (weak, nonatomic) IBOutlet EBTShakeProgressView *progressView;
  _progressView.progress = 0.78;
  
#效果图
![Image](https://github.com/KBvsMJ/EBTShakeProgressView/blob/master/demo/1.gif)
