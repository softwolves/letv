package demo;

public class Foo {
	
	@MyLove
	public void f(){
		System.out.println("f");
 	}
	
	public String test(){
		System.out.println("Hello");
		return "World!";
	}	
	public void test(int n){
		System.out.println("test(int)");
	}

	public void test2(){
		System.out.println("test2"); 
	}
}
