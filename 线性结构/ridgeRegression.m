load('COIL20.mat');
X=[];
Y=[];
for j=0:10:60           %������֤
        for i=1:72:1369
            temp=fea(j+i:j+i+10-1,1:1024);
            X=[X;temp];
            tempY=gnd(j+i:j+i+10-1,1);
            Y=[Y;tempY];
        end             %ѵ����
        I=eye(1024);
        
        W1=inv(X'*X+0.01*I)*(X'*Y);
        W2=inv(X'*X+0.1*I)*(X'*Y);
        W3=inv(X'*X+1*I)*(X'*Y);%ӳ�����

        Xexm=fea(:,:);
        Yexm=gnd(:,:);
        for i=1369:72:1
           Xexm(j+i:j+i+10-1,:)=[];
           Yexm(j+i:j+i+10-1,:)=[];
        end            
                           %��֤��
        cost1=mean(abs(Xexm*W1-Yexm))
        cost2=mean(abs(Xexm*W2-Yexm))
        cost3=mean(abs(Xexm*W3-Yexm))
        if j==0
            finalW1=W1;
            finalW2=W2;
            finalW3=W3;
            fcost1=cost1;
            fcost2=cost2;
            fcost3=cost3;
        end                %��ʼ��ֵ
        if cost1<fcost1
            finalW1=W1;
            fcost1=cost1;
        end
        if cost2<fcost2
            finalW2=W2;
            fcost2=cost2;
        end
        if cost3<fcost3
            finalW3=W3;
            fcost3=cost3;
        end                 %����ֵ�����С���Ǹ�ӳ�����
end
