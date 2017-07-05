package chat;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

/**
 * 聊天室客户端
 * TCP通讯的客户端
 * 
 * /sbin/ifconfig
 * 
 * ipconfig
 * @author Administrator
 *
 */
public class Client {
	/*
	 * Socket 套接字
	 * 封装了TCP协议。 
	 */
	private Socket socket;
	/**
	 * 构造方法，用于初始化客户端，若初始化过程
	 * 出现错误会抛出异常
	 * @throws Exception
	 */
	public Client() throws Exception{
		try {
			/*
			 * 初始化Socket需要传入两个参数:
			 * 1:远程计算机的IP地址
			 * 2:服务端应用程序在服务器上申请
			 *   的端口
			 * 我们是通过IP地址找到服务器的计算机，
			 * 在通过端口找到该机器上的服务端应用
			 * 程序的。这个端口不是客户端决定的，
			 * 而是服务端决定的。  
			 * 
			 * 实例化Socket的过程就是连接的过程。
			 * 若服务端没有响应，这里会抛出异常。
			 */
			socket = new Socket(
				"localhost",8088	
			);
		} catch (Exception e) {
			throw e;
		}
	}
	/**
	 * 客户端开始工作的方法
	 */
	public void start(){
		try {
			//启动用于接收服务端发送消息的线程
			ServerHandler handler
				= new ServerHandler();
			Thread t = new Thread(handler);
			t.start();
			
			
			Scanner scanner 
				= new Scanner(System.in);
			/*
			 * OutputStream getOutputStream()
			 * 通过Socket获取输出流，用来将数据发送
			 * 至服务端
			 */
			OutputStream out
				= socket.getOutputStream();
			
			OutputStreamWriter osw
				= new OutputStreamWriter(
					out,"UTF-8"	
				);
			
			PrintWriter pw
				= new PrintWriter(osw,true);
			String message = null;
			while(true){
				message = scanner.nextLine();
				pw.println(message);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		try {
			Client client = new Client();
			client.start();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 该线程任务是用来接收服务端发送过来的消息
	 * 并输出到客户端的控制台上。
	 * @author Administrator
	 *
	 */
	class ServerHandler implements Runnable{
		public void run(){
			try {
				BufferedReader br 
					= new BufferedReader(
						new InputStreamReader(
							socket.getInputStream(),"UTF-8"	
						)	
					);
				
				String message = null;
				while((message = br.readLine())!=null){
					System.out.println(message);
				}
				
			} catch (Exception e) {
				// TODO: handle exception
			}
		}
	}
}








