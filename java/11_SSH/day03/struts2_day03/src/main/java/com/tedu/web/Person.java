package com.tedu.web;

public class Person {
	int id;
	String pname;
	String message;
	public Person() {
	}
	
	public Person(int id, String pname, String message) {
		super();
		this.id = id;
		this.pname = pname;
		this.message = message;
	}


	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
	
}
