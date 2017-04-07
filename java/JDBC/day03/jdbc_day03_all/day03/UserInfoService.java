package day03;

import java.util.List;
import java.util.Scanner;

import day02.UserInfo;

/**
 * 针对用户操作的业务逻辑类
 * @author Administrator
 *
 */
public class UserInfoService {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		System.out.println("欢迎进入用户管理系统！");
		System.out.println("请输入要操作的序号:");
		System.out.println("1:注册操作");
		System.out.println("2:登录操作");
		System.out.println("3:查看所有用户操作");
		System.out.println("4:分页查看用户信息操作");
		System.out.println("5:修改用户操作");
		System.out.println("6:删除用户操作");
		System.out.println("7:转账操作");
		
		int index = Integer.parseInt(scanner.nextLine());
		switch(index){
			case 1:
				reg();
				break;
			case 2:
				login();
				break;
			case 3:
				showAll();
				break;
			case 4:
				showAllByPage();
				break;
			case 5:
				
			case 6:	
				
			case 7:		
		}
	}
	public static void showAllByPage(){
		Scanner scanner = new Scanner(System.in);
		System.out.println("请输入每页显示的条数:");
		int pageSize = Integer.parseInt(scanner.nextLine());
		System.out.println("请输入要查看的页:");
		int page = Integer.parseInt(scanner.nextLine());
		UserInfoDAO dao = new UserInfoDAO();
		List<UserInfo> list = dao.findAllByPage(page, pageSize);
		for(UserInfo userInfo : list){
			System.out.println(userInfo);
		}
	}
	
	/**
	 * 查看所有用户的业务逻辑
	 */
	public static void showAll(){
		UserInfoDAO dao = new UserInfoDAO();
		List<UserInfo> list = dao.findAll();
		System.out.println("用户共:"+list.size()+"人");
		for(UserInfo userInfo : list){
			System.out.println(userInfo);
		}
	}
	
	/**
	 * 注册功能的业务逻辑
	 */
	public static void reg(){
		Scanner scanner = new Scanner(System.in);
		System.out.println("欢迎注册:");
		System.out.println("请输入用户名:");
		String username = scanner.nextLine();
		System.out.println("请输入密码:");
		String password = scanner.nextLine();
//		System.out.println("请重复密码:");
//		String repassword = scanner.nextLine();
		System.out.println("请输入邮箱:");
		String email = scanner.nextLine();
		
		UserInfo userInfo = new UserInfo();
		userInfo.setUsername(username);
		userInfo.setPassword(password);
		userInfo.setEmail(email);
		userInfo.setAccount(5000);
		
		UserInfoDAO dao = new UserInfoDAO();
		boolean tf = dao.save(userInfo);
		if(tf){
			System.out.println("注册成功!");
		}else{
			System.out.println("注册失败!");
		}
	}
	/**
	 * 登录功能的业务逻辑方法
	 */
	public static void login(){
		
	}
}






