package oo.day02;
//T型类
public class T {
	Cell[] cells; //格子数组
	T(){
		this(0,0);
	}
	T(int row,int col){
		this.cells = new Cell[4];
		this.cells[0] = new Cell(row,col);
		this.cells[1] = new Cell(row,col+1);
		this.cells[2] = new Cell(row,col+2);
		this.cells[3] = new Cell(row+1,col+1);
	}                                         
	
	void drop(){
		for(int i=0;i<this.cells.length;i++){
			this.cells[i].row++;
		}
	}
	void moveLeft(){
		for(int i=0;i<cells.length;i++){
			cells[i].col--;
		}
	}
	void moveRight(){
		for(int i=0;i<cells.length;i++){
			cells[i].col++;
		}
	}
	void print(){ //测试--输出每个格子的行列号
		for(int i=0;i<this.cells.length;i++){
			String str = this.cells[i].getCellInfo();
			System.out.println(str);
		}
	}
}












