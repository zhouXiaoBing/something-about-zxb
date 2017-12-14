##6、【理解】常见结构体
#### 1、【理解】NSPoint和CGPoint的使用
 * CGPoint和NSPoint是同义的
 * `typedef CGPoint NSPoint;`
```objc
CGPoint的定义
struct CGPoint {
  CGFloat x;
  CGFloat y;
};
typedef struct CGPoint CGPoint;
typedef double CGFloat;
```
`CGPoint代表的是二维平面中的一个点,可以使用CGPointMake和NSMakePoint函数创建CGPoint.`
#### 2、【理解】NSSize和CGSize的使用
 * CGSize和NSSize是同义的
 * typedef CGSize NSSize;
```objc
CGSize的定义
struct CGSize {
  CGFloat width;
  CGFloat height;
};
typedef struct CGSize CGSize;
```
`CGSize代表的是二维平面中的某个物体的尺寸(宽度和高度)
可以使用CGSizeMake和NSMakeSize函数创建CGSize`

#### 3、【理解】NSRect和CGRect的使用
 * CGRect和NSRect是同义的
 * typedef CGRect NSRect;
```objc
CGRect的定义
struct CGRect {
  CGPoint origin;
  CGSize size;
};
typedef struct CGRect CGRect;
```
`CGRect代表的是二维平面中的某个物体的位置和尺寸
可以使用CGRectMake和NSMakeRect函数创建CGRect`

