package com.tarena.shoot;
import java.awt.image.BufferedImage;
/** 飞行物类 */
public abstract class FlyingObject {
	protected BufferedImage image; //图片
	protected int width; //宽
	protected int height; //高
	protected int x; //x坐标
	protected int y; //y坐标
	
	/** 飞行物走一步 */
	public abstract void step();
	
	/** 检查是否出界  返回true表示已越界*/
	public abstract boolean outOfBounds();
}





