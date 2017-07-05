package com.tarena.shoot;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.Graphics;

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
	
	ShootGame(){
		flyings = new FlyingObject[2];
		flyings[0] = new Airplane();
		flyings[1] = new Bee();
		bullets = new Bullet[1];
		bullets[0] = new Bullet(100,200);
	}
	
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
	}
}




























