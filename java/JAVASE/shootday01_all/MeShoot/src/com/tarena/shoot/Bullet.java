package com.tarena.shoot;

/** 子弹: 是飞行物 */
public class Bullet extends FlyingObject {
	private int speed = 3; //走步的步数
	
	/** 构造方法  x:根据英雄机位置计算  y:根据英雄机位置计算 */
	public Bullet(int x,int y){
		image = ShootGame.bullet; //图片
		width = image.getWidth();   //宽
		height = image.getHeight(); //高
		this.x = x; //子弹的x
		this.y = y; //子弹的y
	}
}




