/**
 * 
 */
package model.product;

/**
 * @author Mithrandir
 *
 */
public class Product {
	private String id;//自动生成，最大长度11位int
	private String name;//不大于12
	private String userId;//12位
	private String price;//十位，两位小数
	private String time;//每次更改都会更新
	private String description;//不超过255
	private String iconPath;//不超过255
	private String status;
	
	public Product() {

	}
	public Product(String id, String name, String userId, String price, String time, String description,
			String iconPath, String status) {
		super();
		this.id = id;
		this.name = name;
		this.userId = userId;
		this.price = price;
		this.time = time;
		this.description = description;
		this.iconPath = iconPath;
		this.status = status;
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
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getIconPath() {
		return iconPath;
	}
	public void setIconPath(String iconPath) {
		this.iconPath = iconPath;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	@Override
	public String toString() {
		return "Product [id=" + id + ", name=" + name + ", userId=" + userId + ", price=" + price
				+ ", time=" + time + ", description=" + description + ", iconPath=" + iconPath + "]";
	}
	
}
