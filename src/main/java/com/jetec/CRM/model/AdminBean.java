package com.jetec.CRM.model;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.util.Collection;
import java.util.List;


@Entity
@Table(name = "admin")
public class AdminBean  implements UserDetails {
	final  static  String SESSIONID = "user";


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer adminid;
    private String name;
    private String phone;
    private String 	email;
    private String address;//
    private String password;//
    private String 	state;//
    private String 	position;//職位
    private String department;//部門	
    private String 	director;//主管
    private String 	dutyDay;//到職日

	@Transient
	private String permit;


	public String getPermit() {
		return permit;
	}

	public void setPermit(String permit) {
		this.permit = permit;
	}

	@OneToMany(targetEntity = AdminMailBean.class ,mappedBy = "adminid", cascade = CascadeType.ALL)
	private List<AdminMailBean> mail;
	//@他人

	@OneToMany(targetEntity = BillboardAdviceBean.class ,mappedBy = "adviceto", cascade = CascadeType.ALL)
	private List<BillboardAdviceBean> advice;

	@OneToMany(targetEntity = BillboardTopBean.class ,mappedBy = "adminid", cascade = CascadeType.ALL)
	private List<BillboardTopBean> top;

	@OneToMany(targetEntity = MarketStateBean.class ,mappedBy = "adminid", cascade = CascadeType.ALL)
	private List<MarketStateBean> marketstate;

	public List<MarketStateBean> getMarketstate() {
		return marketstate;
	}

	public void setMarketstate(List<MarketStateBean> marketstate) {
		this.marketstate = marketstate;
	}

	public List<BillboardTopBean> getTop() {
		return top;
	}
	public void setTop(List<BillboardTopBean> top) {
		this.top = top;
	}
	public List<BillboardAdviceBean> getAdvice() {
		return advice;
	}
	public void setAdvice(List<BillboardAdviceBean> advice) {
		this.advice = advice;
	}
	public String getDutyDay() {
		return dutyDay;
	}
	public void setDutyDay(String dutyDay) {
		this.dutyDay = dutyDay;
	}
	public List<AdminMailBean> getMail() {
		return mail;
	}
	public void setMail(List<AdminMailBean> mail) {
		this.mail = mail;
	}
	public Integer getAdminid() {
		return adminid;
	}
	public void setAdminid(Integer adminid) {
		this.adminid = adminid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhone() {
		StringBuffer sb = new StringBuffer(phone);
		if(sb.length()>9) {
			sb.insert(4, "-");
			sb.insert(8, "-");
		}
		return sb.toString();
	}
	public void setPhone(String phone) {	
		phone = phone.replace("-", "");
		phone = phone.replace("(", "");
		phone = phone.replace(")", "");	
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}




	public void setPassword(String password) {
		this.password = password;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}

	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getDirector() {
		return director;
	}
	public void setDirector(String director) {
		this.director = director;
	}


	public void setAuthorities(Collection<? extends GrantedAuthority> authorities) {
		this.authorities = authorities;
	}


	@Transient
	private Collection<? extends GrantedAuthority> authorities;
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	public String getPassword() {
		return password;
	}

	@Override
	public String getUsername() {
		return email;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}



	@Override
	public String toString() {
		return "AdminBean{" +
				"adminid=" + adminid +
				", name='" + name + '\'' +
				", phone='" + phone + '\'' +
				", email='" + email + '\'' +
				", address='" + address + '\'' +
				", password='" + password + '\'' +
				", state='" + state + '\'' +
				", position='" + position + '\'' +
				", department='" + department + '\'' +
				", director='" + director + '\'' +
				", dutyDay='" + dutyDay + '\'' +
				", permit=" + permit +
				", top=" + top +
				", marketstate=" + marketstate +
				'}';
	}
}
