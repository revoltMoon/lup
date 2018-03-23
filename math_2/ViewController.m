//
//  ViewController.m
//  math_2
//
//  Created by Влад Купряков on 25.02.2018.
//  Copyright © 2018 Влад Купряков. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

float matrix[4][4];
float l[4][4];
float c[4][4];
float u[4][4];
float p[4][4];
double obratnaya[4][4];
double proverka[4][4];
double b[4][1];
double secondB[4][1];
int znak = 1;
double opred = 1;
int ran = 0;
int ourMatrix = 4;

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self zapolnenie];
    [self gauss];
    [self opr];
    [self rang];
    [self showL];
    [self matrixUmn];
    [self findX];
    [self chisloObusl];
}
-(void)zapolnenie{
    for (int i=0; i<ourMatrix; i++) {
        for (int g=0; g<ourMatrix; g++) {
            matrix[i][g] = rand() % 10 + 1;
            c[i][g] = matrix[i][g];
//            NSLog(@"%f", matrix[i][g]);
            p[i][g] = 0;
            l[i][g] = 0;
            u[i][g] = 0;
            proverka[i][g]=0;
        }
    }
    //vector b
    for (int i=0; i<ourMatrix; i++) {
            b[i][0] = rand() % 100 + 1;
        secondB[i][0] = b[i][0];
//        matrix[i][0] = 0;
//        c[i][0] = 0;
//        matrix[i][1] = matrix[i][0];
//        c[i][1] = matrix[i][0];
//        matrix[2][i] = matrix[0][i];
//        c[2][i] = matrix[0][i];
//        matrix[3][i] = matrix[0][i];
//        c[3][i] = matrix[0][i];
    }
//    b[2][0] = b[0][0];
//    secondB[2][0] = secondB[0][0];
//    b[3][0] = b[0][0];
//    secondB[3][0] = secondB[0][0];
    
    
    
    for (int i=0; i<ourMatrix; i++) {
        for (int g=0; g<ourMatrix; g++) {
                NSLog(@"matrix: %f", matrix[i][g]);
            }
        }
    
    //единичная матрица p
    for (int i=0; i<ourMatrix; i++) {
        for (int g=0; g<ourMatrix; g++) {
            if (i==g){
                p[i][g] = 1;
                obratnaya[i][g] = 1;
                NSLog(@"b:  %f", b[i][0]);
            }
            
        }
    }
    NSLog(@"<<<<<<<<>>>>>>>");
}

-(void)gauss{
    double caeff = 0;
        for (int k=0; k<ourMatrix-1; k++) {
            
            [self findMaxInRow:k];
            if ((fabs(c[k][k])<0.000006)&&(fabs(c[k][k+1])>0.000006)) {
                [self virojdennayaDetected:k];
                k = ourMatrix;
            }
            for (int i=k+1; i<ourMatrix; i++) {
                if(fabs(c[k][k])>0.000006)
                {
                caeff = c[i][k]/c[k][k];
                
                l[i][k] = caeff;
                secondB[i][0] = secondB[i][0] - secondB[k][0]*caeff;
                for (int g=k; g<ourMatrix; g++){
                c[i][g] -= c[k][g]*caeff;
                    if (fabs(c[i][g])<0.00006){
                        c[i][g] = 0;
                    }
                
            }
                for (int g=0; g<ourMatrix; g++){
                obratnaya[i][g] -= obratnaya[k][g]*caeff;
                }
        }
      }
    }
    NSLog(@"matrix U");
    double sum = 0;
    for (int h=0; h<ourMatrix; h++) {
        sum = 0;
        for (int y=0; y<ourMatrix; y++){
            sum += c[h][y];
            NSLog(@"c:  %f", c[h][y]);
        }
        if (fabs(sum)<0.000006) {
            if (secondB[h][0]>0.000006) {
                NSLog(@"sistema ne sovmestna");
            } else {
                NSLog(@"sistema sovmestna");
            }
        }
    }
    
    NSLog(@"pryamoy hod ended");
    
    for (int i=0; i<ourMatrix; i++) {
        for (int g=0; g<ourMatrix; g++) {
            u[i][g] = c[i][g];
        }
    }
    
    NSLog(@"matrix C after GAUSS");
    //obratny hod
    for (int k=ourMatrix-1; k>0; k--) {
        for (int i=k-1; i>=0; i--) {
            if(fabs(c[k][k])>0.000006)
            {
            caeff = c[i][k]/c[k][k];
            secondB[i][0] = secondB[i][0] - secondB[k][0]*caeff;
            for (int g=k; g>=0; g--){
                c[i][g] -= c[k][g]*caeff;
                if (fabs(c[i][g])<0.00006){
                    c[i][g] = 0;
                }
               
            }
            for (int g=0; g<ourMatrix; g++){
                obratnaya[i][g] -= obratnaya[k][g]*caeff;
            }
            } else {
                
            }
    }
}
    
    for (int i=0; i<ourMatrix; i++) {
        for (int g=0; g<ourMatrix; g++) {
            if(fabs(c[i][i])>0.000006){
                obratnaya[i][g] = obratnaya[i][g]/c[i][i];
                
            }
        }
    }
    
    
    
    for (int h=0; h<ourMatrix; h++) {
        for (int y=0; y<ourMatrix; y++){
            NSLog(@"c:   %f", c[h][y]);
        }
    }
    
    for (int h=0; h<ourMatrix; h++) {
        for (int y=0; y<ourMatrix; y++){
            NSLog(@"obratnaya:  %f", obratnaya[h][y]);
        }
    }
    NSLog(@"obratny hod ended");
}


-(void)virojdennayaDetected:(int)row{
    double caeff = 0;
        for (int z = row+1; z<ourMatrix; z++) {
            if (fabs(c[row][z])>0.000006) {
                for (int i=z; i<ourMatrix; i++) {
                    caeff = c[i][z]/c[z-1][z];
                    l[i][z] = caeff;
                    secondB[i][0] -= secondB[z-1][0]*caeff;
                    for (int g=z; g<ourMatrix; g++){
                        c[i][g] -= c[z-1][g]*caeff;
                    }
                    for (int g=0; g<ourMatrix; g++){
                        obratnaya[i][g] -= obratnaya[z][g]*caeff;
                    }
                }
            }
            
        }
    for (int h=0; h<ourMatrix; h++) {
        for (int y=0; y<ourMatrix; y++){
            NSLog(@"c vstretili pr hod:   %f", c[h][y]);
        }
    }
    
    
    for (int k=ourMatrix-2; k>0; k--) {
        for (int i=k+1; i>=0; i--) {
            if(fabs(c[i][k])>0.000006)
            {
                caeff = c[i][k+1]/c[k][k+1];
                secondB[i][0] = secondB[i][0] - secondB[k][0]*caeff;
                for (int g=k+1; g>=0; g--){
                    c[i][g] -= c[k][g]*caeff;
                    if (fabs(c[i][g])<0.00006){
                        c[i][g] = 0;
                    }
                    
                }
                for (int g=0; g<ourMatrix; g++){
                    obratnaya[i][g] -= obratnaya[k][g]*caeff;
                }
            }
        }
    }
    
    
    for (int h=0; h<ourMatrix; h++) {
        for (int y=0; y<ourMatrix; y++){
            NSLog(@"c obratny hod:   %f", c[h][y]);
        }
    }
    
    
    
    
    double x[4][1];
    for (int i=0; i<ourMatrix; i++) {
        x[i][0] = 0;
    }
    for (int i=0; i<ourMatrix; i++) {
        for (int g=0; g<ourMatrix; g++) {
            if (fabs(c[i][g])>0.000006){
                x[i][0] = secondB[i][0]/c[i][g];
                NSLog(@"x nomer: %d", i);
                NSLog(@"x: %f", x[i][0]);
            }
        }
    }
    double proverkaAX[4][1];
    for (int i=0; i<ourMatrix; i++) {
        proverkaAX[i][0] = 0;
    }
    for (int i=0; i<ourMatrix; i++) {
        for (int k=0; k<ourMatrix; k++) {
            proverkaAX[i][0] = b[i][0];
        }
    }
    for (int h=0; h<ourMatrix; h++) {
        NSLog(@"our proverka pri virojdennosti Ax-b: %f", proverkaAX[h][0] - b[h][0]);
    }
    
}

-(void)findMaxInRow:(int)row{

    double max = -1000;
    int maxRow = row;
    for (int i=row; i<ourMatrix; i++) {
        if(max < c[i][row]){
            maxRow = i;
            max = c[i][row];
        }
    }
    if (maxRow!=row){
        znak*=(-1);
        NSLog(@"swap first: %d", row);
        NSLog(@"swap second: %d", maxRow);
        double arrToSwap[ourMatrix];
        double varForSwap = 0;
        //вбиваем текущую строчку, которую потом поменяем с максимальной в столбце
        for (int g=0; g<ourMatrix; g++) {
            arrToSwap[g] = c[row][g];
            c[row][g] = c[maxRow][g];
            c[maxRow][g] = arrToSwap[g];
            
            
            
            arrToSwap[g] = obratnaya[row][g];
            obratnaya[row][g] = obratnaya[maxRow][g];
            obratnaya[maxRow][g] = arrToSwap[g];
            
            
            arrToSwap[g] = p[row][g];
            p[row][g] = p[maxRow][g];
            p[maxRow][g] = arrToSwap[g];
            
            
        }
        
        for (int h=0; h<row; h++) {
            arrToSwap[h] = l[row][h];
            l[row][h] = l[maxRow][h];
            l[maxRow][h] = arrToSwap[h];
        }
        varForSwap = secondB[row][0];
        secondB[row][0] = secondB[maxRow][0];
        secondB[maxRow][0] = varForSwap;
    }
    
}

-(void)chisloObusl{
    double obusl = 0;
    double sumA=0;
    double summinusA=0;
    double max1 = 0;
    double max2 = 0;
    for (int i=0; i<ourMatrix; i++) {
        sumA=0;
        summinusA=0;
        for (int g=0; g<ourMatrix; g++) {
            sumA+=fabs(matrix[i][g]);
            summinusA+=fabs(obratnaya[i][g]);
        }
        if (sumA > max1) {
            max1 = sumA;
        }
        if (summinusA > max2) {
            max2 = summinusA;
        }
    }
    
    
    obusl = max1 * max2;
    NSLog(@"obuslovl: %f", obusl);
}

-(void)opr{
    for (int i=0; i<ourMatrix; i++) {
        for (int g=0; g<ourMatrix; g++) {
            if (i==g){
                opred*=c[i][g];
            }
        }
    }
    opred*=znak;
    NSLog(@"opredelitel: %f", opred);
}

-(void)rang{
    for (int i=0; i<ourMatrix; i++) {
        for (int g=0; g<ourMatrix; g++) {
            if (i==g) {
                if (fabs(c[i][g]) > 0.00006) {
                    ran+=1;
                }
            }
        }
    }
    NSLog(@"rang: %d", ran);
}

-(void)showL{
    
    for (int i=0; i<ourMatrix; i++) {
        for (int g=0; g<ourMatrix; g++) {
            if (i==g){
                l[i][g] = 1;
            }
        }
    }
    
    for (int h=0; h<ourMatrix; h++) {
        for (int y=0; y<ourMatrix; y++){
            NSLog(@"U:   %f", u[h][y]);
        }
    }
    
    
    for (int h=0; h<ourMatrix; h++) {
        for (int y=0; y<ourMatrix; y++){
            NSLog(@"our L: %f", l[h][y]);
        }
    }
}


-(void)matrixUmn{
//    for (int i=0; i<ourMatrix; i++) {
//        for (int g=0; g<ourMatrix; g++) {
//            for (int k=0; k<ourMatrix; k++) {
//                proverka[i][g] += l[i][k]*u[k][g];
//            }
//        }
//    }

//    for (int i=0; i<ourMatrix; i++) {
//        for (int g=0; g<ourMatrix; g++) {
//            for (int k=0; k<ourMatrix; k++) {
//                proverka[i][g] += p[i][k]*matrix[k][g];
//            }
//        }
//    }
    
        for (int i=0; i<ourMatrix; i++) {
            for (int g=0; g<ourMatrix; g++) {
                for (int k=0; k<ourMatrix; k++) {
                    proverka[i][g] += matrix[i][k]*obratnaya[k][g];
                }
            }
        }
    
    
    for (int h=0; h<ourMatrix; h++) {
        for (int y=0; y<ourMatrix; y++){
            NSLog(@"our proverka: %f", proverka[h][y]);
        }
    }
}
-(void)findX{
    double x[4][1];
    for (int i=0; i<ourMatrix; i++) {
        x[i][0] = 0;
    }
    for (int i=0; i<ourMatrix; i++) {
        for (int g=0; g<ourMatrix; g++) {
            if ((i==g)&&(fabs(c[i][g])>0.000006)){
                x[i][0] = secondB[i][0]/c[i][g];
                NSLog(@"x: %f", x[i][0]);
            }
        }
    }
    double proverkaAX[4][1];
    for (int i=0; i<ourMatrix; i++) {
        proverkaAX[i][0] = 0;
    }
    for (int i=0; i<ourMatrix; i++) {
            for (int k=0; k<ourMatrix; k++) {
                proverkaAX[i][0] += matrix[i][k]*x[k][0];
            }
    }
    for (int h=0; h<ourMatrix; h++) {
        NSLog(@"our proverka Ax-b: %f", proverkaAX[h][0] - b[h][0]);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    @end
    
