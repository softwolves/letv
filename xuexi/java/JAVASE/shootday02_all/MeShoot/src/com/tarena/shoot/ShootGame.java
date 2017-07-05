package com.tarena.shoot;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Graphics;
import java.util.Random;
import java.util.Timer;
import java.util.TimerTask;
import java.util.Arrays;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

/** 主程序类 */
public class ShootGame extends JPanel {
	public static final int WIDTH = 400;  //窗口宽
	public static final int HEIGHT = 654; //窗口高
	
	public static BufferedImage background; //背景图
	public static BufferedImage start;      //启动图
	public static BufferedImage pause;      //暂停图
	public static BufferedImage gameover;   //游戏结束图
	public static BufferedImage airplane;   //敌机
	public static BufferedImage bee;        //小蜜蜂
	public static BufferedImage bullet;     //子弹
	public static BufferedImage hero0;      //英雄机0
	public static BufferedImage hero1;      //英雄机1
	
	private Hero hero = new Hero(); //英雄机对象
	private FlyingObject[] flyings = {}; //敌人(敌机+小蜜蜂)数组对象
	private Bullet[] bullets = {}; //子弹数组对象
	
	static{ //初始化静态资源(图片)
		try{
			background = ImageIO.read(ShootGame.class.getResource("background.png"));
			start = ImageIO.read(ShootGame.class.getResource("start.png"));
			pause = ImageIO.read(ShootGame.class.getResource("pause.png"));
			gameover = ImageIO.read(ShootGame.class.getResource("gameover.png"));
			airplane = ImageIO.read(ShootGame.class.getResource("airplane.png"));
			bee = ImageIO.read(ShootGame.class.getResource("bee.png"));
			bullet = ImageIO.read(ShootGame.class.getResource("bullet.png"));
			hero0 = ImageIO.read(ShootGame.class.getResource("hero0.png"));
			hero1 = ImageIO.read(ShootGame.class.getResource("hero1.png"));
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	/** 生成敌人(敌机+小蜜蜂)对象 */
	public FlyingObject nextOne(){
		Random rand = new Random(); //创建随机数对象
		int type = rand.nextInt(20); //生成0到19之间的随机数
		if(type < 4){ //随机数<4时返回蜜蜂对象
			return new Bee();
		}else{ //随机数为4到19之间时返回敌机对象
			return new Airplane();
		}
	}
	
	int flyEnteredIndex = 0; //敌人入场计数
	/** 敌人(敌机+小蜜蜂)入场 */
	public void enterAction(){ //10毫秒走一次
		flyEnteredIndex++; //每10毫秒加1
		if(flyEnteredIndex%40==0){ //每400(10*40)毫秒走一次
			FlyingObject one = nextOne(); //获取敌人(敌机+小蜜蜂)对象
			flyings = Arrays.copyOf(flyings,flyings.length+1); //扩容
			flyings[flyings.length-1] = one; //将生成的敌人对象添加到数组的最后一个元素上
		}
	}
	
	/** 飞行物(敌机、小蜜蜂、子弹、英雄机)走一步 */
	public void stepAction(){ //10毫秒走一次
		hero.step(); //英雄机走一步
		for(int i=0;i<flyings.length;i++){ //遍历所有敌人
			flyings[i].step(); //敌人走一步
		}
		for(int i=0;i<bullets.length;i++){ //遍历所有子弹
			bullets[i].step(); //子弹走一步
		}
	}
	
	int shootIndex = 0; //子弹入场计数
	/** 子弹入场(英雄机发射子弹) */
	public void shootAction(){ //10毫秒走一次
		shootIndex++; //每10毫秒加1
		if(shootIndex%30==0){ //每300(10*30)毫秒走一次
			Bullet[] bs = hero.shoot(); //获取子弹对象
			bullets = Arrays.copyOf(bullets,bullets.length+bs.length); //扩容(bs有几个元素就扩大几个容量)
			System.arraycopy(bs,0,bullets,bullets.length-bs.length,bs.length); //数组的追加
		}
	}
	
	/** 删除越界的敌人(敌机+小蜜蜂)和子弹 */
	public void outOfBoundsAction(){
		int index = 0; //1.不越界敌人数组的下标  2.不越界敌人的个数
		FlyingObject[] flyingLives = new FlyingObject[flyings.length]; //不越界敌人数组
		for(int i=0;i<flyings.length;i++){ //遍历所有敌人
			FlyingObject f = flyings[i]; //获取每一个敌人
			if(!f.outOfBounds()){ //若不越界
				flyingLives[index] = f; //将不越界的敌人对象添加到不越界敌人数组中
				index++; //1.不越界敌人数组下标增一 2.不越界敌人个数增一
			}
		}
		flyings = Arrays.copyOf(flyingLives,index); //将不越界的敌人复制到flyings中，index为不越界敌人的个数，即flyings的新长度
		
		index = 0; //归零
		Bullet[] bulletLives = new Bullet[bullets.length]; //不越界子弹数组
		for(int i=0;i<bullets.length;i++){ //遍历所有子弹
			Bullet b = bullets[i]; //获取每一个子弹
			if(!b.outOfBounds()){ //若不越界
				bulletLives[index] = b; //将不越界的子弹对象添加到不越界子弹数组中
				index++; //1.不越界子弹数组下标增一  2.不越界子弹个数增一
			}
		}
		bullets = Arrays.copyOf(bulletLives, index); //将不越界的子弹复制到bullets中，index为不越界子弹的个数，即bullets的新长度
	}
	
	/** 启动程序的执行 */
	public void action(){
		//创建侦听器对象
		MouseAdapter l = new MouseAdapter(){
			/** 重写鼠标移动事件 */
			public void mouseMoved(MouseEvent e){
				int x = e.getX(); //获取鼠标的x坐标
				int y = e.getY(); //获取鼠标的y坐标
				hero.moveTo(x, y); //英雄机随着鼠标移动
			}
		};
		this.addMouseListener(l); //处理鼠标操作事件
		this.addMouseMotionListener(l); //处理鼠标滑动事件
		
		Timer timer = new Timer(); //创建定时器对象
		int intervel = 10; //时间间隔(以毫秒为单位)
		timer.schedule(new TimerTask(){
			public void run(){ //10毫秒走一次--定时干的那个事
				enterAction(); //敌人(敌机+小蜜蜂)入场
				stepAction();  //飞行物走一步
				shootAction(); //子弹入场(英雄机发射子弹)
				outOfBoundsAction(); //删除越界的敌人(敌机+小蜜蜂)和子弹
				repaint(); //重画--调用paint()方法
			}
		},intervel,intervel);
	}
	
	/** 重写paint() g:画笔 */
	public void paint(Graphics g){
		g.drawImage(background,0,0,null); //画背景图
		paintHero(g); //画英雄机对象
		paintFlyingObjects(g); //画敌人(敌机+小蜜蜂)对象
		paintBullets(g); //画子弹对象
	}
	/** 画英雄机对象 */
	public void paintHero(Graphics g){
		g.drawImage(hero.image,hero.x,hero.y,null); //画英雄机对象
	}
	/** 画敌人(敌机+小蜜蜂)对象 */
	public void paintFlyingObjects(Graphics g){
		for(int i=0;i<flyings.length;i++){ //遍历敌人(敌机+小蜜蜂)数组
			FlyingObject f = flyings[i]; //获取每一个敌人
			g.drawImage(f.image,f.x,f.y,null); //画敌人(敌机+小蜜蜂)对象
		}
	}
	/** 画子弹对象 */
	public void paintBullets(Graphics g){
		for(int i=0;i<bullets.length;i++){ //遍历子弹数组
			Bullet b = bullets[i]; //获取每一个子弹
			g.drawImage(b.image,b.x,b.y,null); //画子弹对象
		}
	}
	
	public static void main(String[] args) {
		JFrame frame = new JFrame("Fly"); //窗口
		ShootGame game = new ShootGame(); //面板
		frame.add(game); //将面板添加到窗口上
		frame.setSize(WIDTH, HEIGHT); //设置窗口宽和高
		frame.setAlwaysOnTop(true); //设置一直在最上面
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE); //设置默认关闭操作(关闭窗口时退出程序)
		frame.setLocationRelativeTo(null); //设置窗口居中显示
		frame.setVisible(true); //1.设置窗口可见  2.尽快调用paint()方法
		
		game.action(); //启动程序的执行
	}
}




























