package oo.day01;
//格子类
public class Cell {
	int row; //行号
	int col; //列号
	
	void drop(){ //下落一格
		row++; //行号增1
	}
	void moveLeft(int n){ //左移n格
		col-=n; //列号减n
	}
	String getCellInfo(){ //获取行号和列号
		return row+","+col; //返回行列号
	}
}











