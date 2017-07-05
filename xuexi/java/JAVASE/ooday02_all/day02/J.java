package oo.day02;
//J型类
public class J {
	Cell[] cells;
	J(){
		this(0,0);
	}
	J(int row,int col){
		cells = new Cell[4];
		cells[0] = new Cell(row,col);
		cells[1] = new Cell(row,col+1);
		cells[2] = new Cell(row,col+2);
		cells[3] = new Cell(row+1,col+2);
	}
	
	void drop(){
		for(int i=0;i<cells.length;i++){
			cells[i].row++;
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
		for(int i=0;i<cells.length;i++){
			String str = cells[i].getCellInfo();
			System.out.println(str);
		}
	}
}










