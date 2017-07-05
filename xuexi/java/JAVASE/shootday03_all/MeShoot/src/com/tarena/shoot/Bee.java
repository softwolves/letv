package com.tarena.shoot;

import java.util.Random;

/** 小蜜蜂: 是飞行物，也是奖励 */
public class Bee extends FlyingObject implements Award {
	private int xSpeed = 1; //x坐标走步步数
	private int ySpeed = 2; //y坐标走步步数
	private int awardType; //奖励的类型(0或1)
	
	/** 构造方法 */
	public Bee(){
		image = ShootGame.bee; //图片
		width = image.getWidth(); //宽
		height = image.getHeight(); //高
		Random rand = new Random(); //随机数对象
		x = rand.nextInt(ShootGame.WIDTH-this.width); //x:0到(窗口宽-蜜蜂宽)之内的随机数
		y = -this.height; //y:负的蜜蜂的高
		awardType = rand.nextInt(2); //0到1之间的随机数 0代表火力值 1代表命
	}
	
	/** 重写getType() */
	public int getType(){
		return awardType; //返回奖励类型(0或1)
	}

	/** 重写step() */
	public void step(){
		x+=xSpeed; //x+(向左或向右)
		y+=ySpeed; //y+(向下)
		if(x>=ShootGame.WIDTH-this.width){ //x>=(窗口宽-蜜蜂宽)时，x-(向左)
			xSpeed = -1;
		}
		if(x<=0){ //x<=0时，x+(向右)
			xSpeed = 1;
		}
	}

	/** 重写outOfBounds() */
	public boolean outOfBounds(){
		return this.y>=ShootGame.HEIGHT; //蜜蜂的y>=窗口的高，即为越界
	}
}






