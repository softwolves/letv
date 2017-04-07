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

	/** 重写step() */
	public void step(){
		y-=speed; //y-(向上)
	}

	/** 重写outOfBounds() */
	public boolean outOfBounds(){
		return this.y<=-this.height; //子弹的y<=负的子弹的高，即为越界
	}
}




