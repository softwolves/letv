package chat;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;

/**
 * 聊天室服务端
 * TCP通讯的服务端
 * @author Administrator
 *
 */
public class Server {
	/*
	 * ServerSocket是运行在服务端的Socket
	 * 它的作用是:
	 * 1:申请服务端口，客户端就是通过该端口连接到
	 *   服务端的
	 * 2:监听申请的服务端口，一旦客户端连接后，就
	 *   创建一个Socket实例与该客户端交互。  
	 */
	private ServerSocket server;
	/*
	 * 存放着所有客户端输出流的共享集合
	 */
	private List<PrintWriter> allOut;
	
	/**
	 * 构造方法，用来初始化服务端
	 * @throws Exception
	 */
	public Server() throws Exception{
		try {
			/*
			 * 初始化ServerSocket并指定服务端口
			 * 该端口不能与其他应用程序冲突，否则
			 * 会抛出异常。
			 */
			server = new ServerSocket(8088);
			
			allOut = new ArrayList<PrintWriter>();
			
		} catch (Exception e) {
			throw e;
		}
	}
	/**
	 * 向共享集合中添加给定的客户端的输出流
	 * @param out
	 */
	private synchronized void addOut(PrintWriter out){
		allOut.add(out);
	}
	/**
	 * 将给定的客户端的输出流从共享集合中删除
	 * @param out
	 */
	private synchronized void removeOut(PrintWriter out){
		allOut.remove(out);
	}
	/**
	 * 将给定的消息发送给所有客户端
	 * @param message
	 */
	private synchronized void sendMessage(String message){
		for(PrintWriter out : allOut){
			out.println(message);
		}
	}
	
	
	
	/**
	 * 服务端开始工作的方法
	 */
	public void start(){
		try {
			/*
			 * Socket accept()
			 * ServerSocket提供了accept方法，
			 * 该方法用于监听申请的服务端口，直到
			 * 一个客户端连接，然后返回一个Socket
			 * 实例用于与该客户端通讯。
			 * 这个方法是一个阻塞方法，直到客户端连接
			 * 返回继续向下执行。
			 */
			while(true){
				System.out.println("等待客户端连接...");
				Socket socket = server.accept();
				System.out.println("一个客户端连接了!");
				
				ClientHandler handler 
					= new ClientHandler(socket);
				Thread t = new Thread(handler);
				t.start();
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		try {
			Server server = new Server();
			server.start();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 该线程的任务是负责与指定的客户端进行交互
	 * @author Administrator
	 *
	 */
	class ClientHandler implements Runnable{
		/*
		 * 当前线程通过该socket与指定客户端交互
		 */
		private Socket socket;
		//客户端地址信息
		private String host;
		
		public ClientHandler(Socket socket){
			this.socket = socket;
			/*
			 * 通过Socket可以获取远程计算机
			 * 地址信息，对于服务端这边而言，远程
			 * 计算机即客户端。
			 */
			InetAddress address
				= socket.getInetAddress();
			//获取IP地址的字符串形式
			host = address.getHostAddress();
		}
		public void run(){
			PrintWriter pw = null;
			try {
				//通知所有客户端该用户上线
				sendMessage("["+host+"]上线了!");
				
				/*
				 * 通过Socket获取输出流，用于将消息发送
				 * 给客户端
				 */
				OutputStream out
					= socket.getOutputStream();
				OutputStreamWriter osw
					= new OutputStreamWriter(
						out,"UTF-8");
				pw = new PrintWriter(osw,true);
				//将该客户端的输出流存入共享集合
				addOut(pw);
				
				
				
				/*
				 * InputStream getInputStream()
				 * Socket提供的该方法用来获取一个输入流，
				 * 通过该输入流可以读取远端计算机发送过来的
				 * 数据。
				 */
				InputStream in
					= socket.getInputStream();
				
				InputStreamReader isr
					= new InputStreamReader(in,"UTF-8");
				
				BufferedReader br
					= new BufferedReader(isr);
				//读取客户端发送过来的消息
				String message = null;
				/*
				 * 服务端接收客户端发送过来的消息时，由于客户端
				 * 操作系统不同，那么当客户端断开连接时的效果
				 * 也不相同。
				 * 当windows的客户端断开连接后，br.readLine方法
				 * 会抛出异常。
				 * 当linux的客户端断开连接后，br.readLine会返回
				 * null。
				 */
				while((message = br.readLine())!=null){
//					System.out.println(host+"说:"+message);	
//					pw.println(host+"说:"+message);
					sendMessage(host+"说:"+message);
				}
				
				
			} catch (Exception e) {
				
			} finally{
				/*
				 * 客户端与服务端断开后
				 */				
				try {
					//将该客户端的输出流从共享集合中删除
					removeOut(pw);
					//通知所有客户端该用户下线
					sendMessage("["+host+"]下线了!");
					/*
					 * 通讯完毕后，应当将socket
					 * 关闭，以释放底层资源。
					 */
					socket.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
}






