package day02;

//数据类型的演示
public class DataTypeDemo {
	public static void main(String[] args) {
		
		
		/*
		 * 数据类型转换的练习:
		 * 1.声明整型变量a并赋值为250
		 *     声明长整型变量b并赋值为a
		 *     声明整型变量c并赋值为b
		 *   声明长整型变量d并赋值为250
		 *   声明浮点型变量e并赋值为250，输出e的值
		 * 2.声明长整型变量f并赋值为100亿
		 *     声明整型变量g并赋值为f，输出g的值
		 *   声明浮点型变量h并赋值为25.98
		 *     声明整型变量i并赋值为h，输出i的值
		 * 3.声明byte型变量b1和b2，并分别赋值为5和6
		 *   声明byte型变量b3并赋值为b1+b2
		 */
		
		/*
		//基本类型间的转换
		int a=5;
		long b=a; //自动类型转换(小到大)
		int c=(int)b; //强制类型转换(大到小)
		
		long d=5; //自动类型转换
		double e=5; //自动类型转换
		System.out.println(e);
		
		long f=10000000000L;
		int g=(int)f;
		System.out.println(g); //强转有可能溢出
		
		double h=25.987;
		int i=(int)h;
		System.out.println(i); //强转有可能会丢失精度
		
		byte b1=5; //整数直接量可以直接赋值给byte,short,char，但不能超范围
		byte b2=6;
		byte b3=(byte)(b1+b2); //编译错误，byte,short,char参与运算时，一律先转为int再运算了，而将int赋值给byte时必须强转
		System.out.println(b3);
		*/
		
		/*
		 * boolean、char的练习:
		 * 1.声明布尔型变量b1并赋值为true
		 *   声明布尔型变量b2并赋值为false
		 *   声明布尔型变量b3并赋值为250------???
		 * 2.声明字符型变量c1并赋值为字符女
		 *   声明字符型变量c2并赋值为字符f
		 *   声明字符型变量c3并赋值为字符6
		 *   声明字符型变量c4并赋值为空格符
		 *   声明字符型变量c5并赋值为中国------???
		 *   声明字符型变量c6并赋值为空--------???
		 *   声明字符型变量c7并赋值为65，输出c7的值
		 *   输出2+2的值，输出2+'2'的值，输出'2'+'2'的值
		 *   声明字符型变量c8并赋值为字符\，输出c8的值           
		 */
		
		/*
		//5.char:字符型，2个字节
		char c1='男';
		char c2='m';
		char c3='5';
		char c4=' ';
		//char c5=女; //编译错误，必须放在一对单引号中
		//char c6=''; //编译错误，必须有字符
		//char c7='男性'; //编译错误，只能有一个字符
		
		char c8=97; //正确，数值必须在0到65535之间
		System.out.println(c8); //a，因为c8的类型为char，所以会以对应的字符形式输出
		
		System.out.println(2+2); //4
		System.out.println('2'+'2'); //100，'2'的码50，加上，'2'的码50
		
		char c9='\\';
		System.out.println(c9); //\
		*/
		
		/*
		//4.boolean:布尔型，1个字节，只能取值为true和false
		boolean b1=true; //true为布尔型的直接量
		boolean b2=false; //false为布尔型的直接量
		//boolean b3=250; //编译错误，数据类型不匹配
		*/
		
		
		
		
		
		
		
		
		/*
		 * int、long、double的练习:
		 * 1.声明整型变量a并赋值为250
		 *   声明整型变量b并赋值为100亿----------???
		 *   输出5/2的值，输出2/5的值
		 *   声明整型变量c并赋值为2147483647(int的最大值)
		 *     在c本身基础之上增1，输出c的值
		 * 2.声明长整型变量d并赋值为100亿--------???
		 *   声明长整型变量e并赋值为100亿L
		 *   声明长整型变量f并赋值为10亿*2*10L，输出f的值
		 *   声明长整型变量g并赋值为10亿*3*10L，输出g的值
		 *   声明长整型变量h并赋值为10亿L*3*10，输出h的值
		 *   声明长整型变量i并赋值为
		 *     System.currentTimeMillis()，输出i的值
		 * 3.声明浮点型变量j并赋值为3.14
		 *   声明浮点型变量k和l，并分别赋值为6.0和4.9
		 *     输出k-l的值
		 */
		
		
		
		/*
		//3.double:浮点型，8个字节，很大很大很大
		double a=3.14159; //3.14159为浮点型直接量，默认为double型
		float b=3.14159F; //3.14159F为float型直接量
		
		double c=3.0;
		double d=2.9;
		System.out.println(c-d); //0.10000000000000009，舍入误差
		*/
		
		/*
		//2.long:长整型，8个字节，很大很大很大
		long a=250L; //250L为长整型直接量
		//long b=10000000000; //编译错误，100亿默认为int型，但超范围了
		long c=10000000000L; //正确
		
		long d=1000000000*2*10L;
		System.out.println(d); //200亿
		long e=1000000000*3*10L;
		System.out.println(e); //溢出
		long f=1000000000L*3*10; //建议若有可能溢出，将L写在第一个数字之后
		System.out.println(f); //300亿
		
		//获取自1970.1.1零时到此时此刻的毫秒数
		long g=System.currentTimeMillis();
		System.out.println(g);
		*/
		
		/*
		//1.int:整型，4个字节，-21个多亿到21个多亿
		int a=250; //250为整数直接量，默认为int型
		//int b=10000000000; //编译错误，100亿默认为int型，但超范围了
		
		System.out.println(5/2); //2，小数位被舍弃了
		System.out.println(2/5); //0，小数位被舍弃了
		
		int c=2147483647; //int的最大值
		c=c+1; //在c本身基础之上增1
		System.out.println(c); //溢出为-2147483648，是需要避免的
		*/
	}
}















