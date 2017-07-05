package oo.day03;
//T型类----子类
public class T extends Tetromino {
	T(){
		this(0,0);
	}
	T(int row,int col){
		super(); //调用父类的无参构造方法---不写则默认
		this.cells[0] = new Cell(row,col);
		this.cells[1] = new Cell(row,col+1);
		super.cells[2] = new Cell(row,col+2);
		super.cells[3] = new Cell(row+1,col+1);
	}                                         
}












