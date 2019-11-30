package model.user;

public class User {
	private String id;	//长度为12
	private String name;//不大于7个字符
	private String password;//不大于15，默认为303303303
	private String gender;//不大于2
	private String school;//不大于10
	private String campus;//不大于10
	private String iconPath;//不大于255
	private String telephone;
	
	public User() {
		
	}
	public User(String id, String name, String password, String gender, String school, String campus, String iconPath,
			String telephone) {
		super();
		this.id = id;
		this.name = name;
		this.password = password;
		this.gender = gender;
		this.school = school;
		this.campus = campus;
		this.iconPath = iconPath;
		this.telephone = telephone;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getSchool() {
		return school;
	}
	public void setSchool(String school) {
		this.school = school;
	}
	public String getCampus() {
		return campus;
	}
	public void setCampus(String campus) {
		this.campus = campus;
	}
	public String getIconPath() {
		return iconPath;
	}
	public void setIconPath(String iconPath) {
		this.iconPath = iconPath;
	}
	
	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", password=" + password + ", gender=" + gender
				+ ", school=" + school + ", campus=" + campus + ", iconPath=" + iconPath + "]";
	}
}
