package day06;

import java.io.File;
import java.io.FileFilter;

/**
 * 获取一个目录下的部分内容。
 * (获取满足条件的部分内容)
 * @author Administrator
 *
 */
public class FileDemo7 {
	public static void main(String[] args) {
		/*
		 * 获取当前目录下名字以"."开头的子项
		 */
		File dir = new File(".");
		MyFilter filter = new MyFilter();
		
		/*
		 * 使用匿名内部类形式创建一个获取当前目录
		 * 下所有文件的过滤器。
		 */
		FileFilter filter1 = new FileFilter(){
			public boolean accept(File file){
				return file.isFile();
			}
		};
		
		/*
		 * 重载的listFiles方法会将会将所有子项都
		 * 经过一次过滤器，但是该方法只会将满足过滤器
		 * accept方法的子项返回。
		 */
		File[] subs = dir.listFiles(filter1);
		for(File sub : subs){
			System.out.println(sub.getName());
		}
	}
}
class MyFilter implements FileFilter{

	public boolean accept(File file) {
		//过滤条件:名字是以"."开头
		String name = file.getName();
		System.out.println("正在过滤:"+name);
		return name.startsWith(".");
	}
	
}







