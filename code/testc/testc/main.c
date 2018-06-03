//
//  main.c
//  testc
//
//  Created by Mac on 2018/5/24.
//  Copyright © 2018年 test. All rights reserved.
//

#include <stdio.h>
union data{
    long w;
    float x;
    int y;
    char z;
}beta;
int main(int argc, const char * argv[]) {
// insert code here...
//    unsigned int x = 65535;
//    printf("%d",x);
//    printf("%d\n",x);
//    printf("%d",x);
//    inws();
//    nszxb();
//    struct{
//        int n;
//        int m;
//    }cnum[2]={1,2,3,4};
//    printf("%d\n",cnum[0].m/cnum[0].n*cnum[1].n);
//    printf("%d\n",cnum[0].n);
//    printf("%d\n",cnum[1].n);
//    printf("%d\n",cnum[0].m);
//    printf("%d\n",cnum[1].m);

//    union{
//         char c;
//        char b;
//        unsigned int i[4];
//    }z;
//    z.i[0] = 0x39;
//    z.i[1] = 0x36;
//    z.c = '9';
    
//    printf("%c\n",z.c);
//    printf("%c\n",z.b);
//    for (int j = 0;j < 4; j++) {
//        printf("j %d\n",z.i[j]);
//    }
    
//    char ch[3][4] = {"123","456","78"},*p[3];
//    int i;
//    for (i = 0; i<3; i++) {
//        p[i] = ch[i];
////        printf("%c\n",ch[i][0]);
//    }
//    for (i = 0; i<3; i++) {
////        printf("%d , %s\n",i,p[i]);
//    }
//    static int array[] = {0,1,2,3,4,5,6,7,8,9};
//    int j;
//    add1(array,10);
//    for (j = 0; j<10; j++) {
//        printf("%d",array[j]);
//    }
    
//    zxdata();
    beta.w = 123456;
    beta.y = 888;
    beta.x = 3.14;
    beta.z = 'x';
    
    printf("%d",beta.y);//x 的 ascii
    return 0;
}



void  zxdata(){
    beta.w = 123456;
    beta.y = 888;
    beta.x = 3.14;
    beta.z = 'x';
    
    printf("%c",beta.y);//x 的 ascii
}

 int add1(int a[],int n){
    int i;
    for (i = 0; i < n; i++) {
        a[i]++;
    }
    return a[i];
}

void inws ()
{int a=1,b=2,m=0,n=0,k;k=(n=b>a)||(m=a<b);
//    printf(“%d,%d\n”,k,m);
    printf("%d , %d\n",k,m);
    
//    return 0;
}

int nszxb(){
    int pad;
    int sum = pad = 5;
    int pAd = sum++;
    pAd++;
    ++pAd;
    printf("%d",pad);
    return 0;
}
