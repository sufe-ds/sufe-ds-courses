以求  $x^{2} - 3 = 0$  的正根为例

(1) 建立原函数程序  
(2) 建立导函数程序

![](https://cdn-mineru.openxlab.org.cn/result/2025-12-07/d3ee55ea-01e9-452d-bae2-9ded389f529f/c00c5edc306027baedf2e54f35bd080aeee4e0ac8f84507141f9d1c2d0506990.jpg)

(3) Zibian_Newton函数已经编好  
(4) 建立主程序文件

1 - f=@yuanhanshu;%f就像指针一样指向原函数  
2 - f Dao = @daohanshu; %同样，f Dao表示导函数  
3 - [x,iteration] = Zibian_Newton(10,f,f_dao,0.5e-10);%其中0.5e-10表示0.5*10^(-10)

(5) 大家自行思考如何求负根  
(6) 注意: 这介绍的只是一种编程方式, 供初学者学习。有更方便快捷的编程方式, 在后面展示。

编写求根的函数文件，任给  $a$  ，以求  $x^{2} - a = 0$  的正根为例

(1) 建立原函数程序

![](https://cdn-mineru.openxlab.org.cn/result/2025-12-07/d3ee55ea-01e9-452d-bae2-9ded389f529f/cde206b63814aa916e9a35702568726d055deae3bcea4e688cf3c978418892ae.jpg)

(2) 建立导函数程序

![](https://cdn-mineru.openxlab.org.cn/result/2025-12-07/d3ee55ea-01e9-452d-bae2-9ded389f529f/84bfcda9a121436d51fb1322c8ed08bd43657145c81a5554cff64dc1236b7061.jpg)

(3) Zibian_Newton函数已经编好

(4) 建立主程序文件

![](https://cdn-mineru.openxlab.org.cn/result/2025-12-07/d3ee55ea-01e9-452d-bae2-9ded389f529f/8ea82edcc168caf73553d7b38afd4e2aea5449d58f1386d5a19fb491fdbebeb6.jpg)

编写求根的函数文件，任给  $a$ ，以求  $x^{2} - a = 0$  的正根为例，更加便捷的方式如下：

```matlab
function[x,iteration]  $\equiv$  qiu_zhenggen2(a)   
f  $\coloneqq$  @x)x^2-a;   
f_dao  $\coloneqq$  @x)2\*x;   
[x,iteration]=Zibian_Newton(10,f,fdao,0.5e-10);%其中0.5e-10表示0.5\*10^(-10)   
end
```

对本次作业，大家能编写求正根的程序就可以了。如果想同时求出正负两个根，大家可以自己思考。

# 附录-Zibian_newton函数matlab代码

```matlab
function[x,iteration]  $\equiv$  Zibian_Newton(x0，f，f_dao,tol)   
 $\%$  牛顿法求函数f(x)的零点   
 $\%$  x0为初值，f为目标求解函数，f_dao为f的导数   
 $\%$  tol为精度(tolerance)要求，比如10^(-10)   
 $\%$  x为最终解   
 $\%$  iteration  $=$  [n x fx]用于记录每次的迭代过程，n表示第n次迭代   
 $n = 0$  ：  $\%$  迭代次数   
 $x = x0$  ：  $\% x0$  为初值   
fx=f(x)；  $\% x$  处的函数值   
fx_dao=f_dao(x)；  $\% x$  处的导数值   
iteration=[n x fx]；  $\%$  记录迭代过程   
while abs(fx)>tol  $\% f(x)$  的绝对值>tol   
 $n = n + 1$  ：  $\%$  迭代次数+1   
 $x = x - fx / fx\_dao$  ：  $\%$  牛顿法进行迭代fromx_k tox_k+1   
fx=f(x);   
fx_dao=f_dao(x);   
iteration  $=$  [iteration;n x fx];   
end
```