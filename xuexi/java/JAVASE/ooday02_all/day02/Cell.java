package oo.day02;
//格子类
public class Cell {
	int row; //行号
	int col; //列号
	
	Cell(){
		this(0,0);
	}
	Cell(int n){
		this(n,n);
	}
	Cell(int row,int col){
		this.row = row;
		this.col = col;
	}
	
	void drop(){ //下落一格
		row++; //行号增1
	}
	void moveLeft(int n){ //左移n格
		col-=n; //列号减n
	}
	String getCellInfo(){ //获取行号和列号
		return row+","+col; //返回行列号
	}

	void drop(int n){ //下落n格
		row+=n; 
	}
	void moveLeft(){ //左移一格
		col--;
	}
	
}











