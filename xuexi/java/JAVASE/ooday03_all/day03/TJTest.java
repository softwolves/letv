package oo.day03;
//T类与J类的测试类
public class TJTest {
	public static void main(String[] args) {
		Tetromino o1 = new T(2,5); //向上造型
		printWall(o1); //先造型后传值
		
		J o2 = new J(1,7);
		printWall(o2); //传值的同时自动造型
	}
	
	//打墙+打T型
	public static void printWall(Tetromino t){
		Cell[] cells = t.cells; //获取t型的cells并存储在cells引用中
		
		for(int i=0;i<20;i++){
			for(int j=0;j<10;j++){
				
				boolean flag = false; //1.假设打-
				for(int k=0;k<cells.length;k++){
					if(i==cells[k].row && j==cells[k].col){
						flag = true; //2.改为打*
						break;
					}
				}
				if(flag){ //3.判断得结果
					System.out.print("* ");
				}else{
					System.out.print("- ");
				}
				
			}
			System.out.println();
		}
	}


}














