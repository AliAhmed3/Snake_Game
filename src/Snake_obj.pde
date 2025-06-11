class snakeObj
{
  int d;
  int s;
  boolean isalive = true;
  //constructer
  public snakeObj()
  {
    d= 60;
    s= 100;
    isalive = true;
  }
  
  //setter
  public void setsnake( int isx,int isy)
  {
    d=isx;
    s=isy;
    
  }
  //getter
  public int getx()
  {
    return d;
  }
  
  //getter
  public int gety()
  {
    return s;
  }
 
}
