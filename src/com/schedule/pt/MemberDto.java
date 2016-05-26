package com.schedule.pt;

import java.sql.Date;

public class MemberDto {
  private String eMail;
  private String pw;
  private String name;
  private Date birth;
  private String address; 
  private int isKakao;


  public String geteMail() {
    return eMail;
  }

  public void seteMail(String eMail) {
    this.eMail = eMail;
  }

  public String getPw() {
    return pw;
  }

  public void setPw(String pw) {
    this.pw = pw;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  public Date getBirth() {
    return birth;
  }

  public void setBirth(Date birth) {
    this.birth = birth;
  }

  public String getAddress() {
    return address;
  }

  public void setAddress(String address) {
    this.address = address;
  }

  public int getIsKakao() {
	  return isKakao;
  }

  public void setIsKakao(int isKakao) {
	  this.isKakao = isKakao;
  }
}



