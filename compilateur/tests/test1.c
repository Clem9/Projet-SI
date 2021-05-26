int main()
{ 
	int i, j, k, r;
	j = 4;
	k = 8;
	r = (j+k)*(k-k/j); 
	if (k==6)
	{ 
		j=2;
	}
	else
	{
		j=1;
	}
	printf(r);
	while((j==1) || (k<4))
	{
		k = k+1;
	}
	printf(i);
}

