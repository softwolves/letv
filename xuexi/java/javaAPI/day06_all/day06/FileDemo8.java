package day06;

import java.io.File;

/**
 * 删除一个含有子项的目录
 * @author Administrator
 *
 */
public class FileDemo8 {
	public static void main(String[] args) {
		/*
		 * 将当前目录下的a目录删除
		 */
		File dir = new File("a");
		deleteFile(dir);
	}
	/**
	 * 将给定的File表示的文件或目录删除
	 * @param f
	 */
	public static void deleteFile(File f){
		if(f.isDirectory()){
			//将该目录下的所有子项删除
			File[] subs = f.listFiles();
			for(File sub : subs){
				deleteFile(sub);
			}
		}
		f.delete();
	}
}
/*
 * 请编写一段代码，不得超过20
 * 要求:计算1+2+3+4+...100
 * 每加一次输出一次结果
 * 最终输出5050
 * 代码中不得出现for,while关键字
 */





