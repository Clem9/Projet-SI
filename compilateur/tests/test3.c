int main()
{ int i, j,k ,r;
i =3 ;
j=4 ;
k=8 ;
r=(i+j)*(i+k/j) ; 
if (k==6){ j=2;}
else
{
	j=1;
}
printf ( r ) ;
while((j==1) || (k<4)){
	k=k+1;
}
printf ( i ) ;
}