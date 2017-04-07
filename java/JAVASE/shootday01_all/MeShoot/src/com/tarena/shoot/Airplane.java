package com.tarena.shoot;
import java.util.Random;

/** 敌机: 是飞行物，也是敌人 */
public class Airplane extends FlyingObject implements Enemy {
	private int speed = 2; //走步的步数
	
	/** 构造方法 */
	public Airplane(){
		image = ShootGame.airplane; //图片
		width = image.getWidth();   //宽
		height = image.getHeight(); //高
		Random rand = new Random(); //随机数对象
		x = rand.nextInt(ShootGame.WIDTH-this.width); //x:0到(窗口宽-敌机宽)之内的随机数
		//y = -this.height; //y:负的敌机的高
		y = 200;
	}
	
	/** 重写getScore() */
	public int getScore(){
		return 5; //打掉一个敌机得5分
	}
}







