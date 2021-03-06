/**
 * 
 */
package model.product;

import java.util.ArrayList;

/**
 * Product Data Access Object
 * Provide interfaces to access database, used for merchandise related features
 * Should be implemented by a Class Product[API]Template, e.g. ProductJDBCTemplate
 * 
 * @author Mithrandir
 *
 */
public interface ProductDAO {
	
	/**
	 * Add new product to database
	 * NOTICE : Not having [id] parameter. id should be automatically generated by database
	 * 
	 * @param price
	 * Probably parsed to numeric type before writing to database, depending on type used in database
	 * @param iconPath
	 * path to an image on server, can be empty
	 * @return
	 * Return newly added product
	 */
	public Product addProduct(String name, String userId, String price,
			String time, String description, String iconPath, String directory);
	
	/**
	 * @return
	 * When successfully deleted product return true.
	 * otherwise return false
	 */
	public boolean deleteProduct(String id);
	
	/**
	 * @return
	 * Return newly updated product
	 */
	public boolean updateProduct(String id, String name, String price,
			String time, String description, String iconPath, String directory);
	
	public boolean updateProductKeepImage(String id, String name, String price,
			String time, String description, String directory);
	
	/**
	 * Search by product name and position (school&campus);
	 * Unspecified parameters will be empty string
	 * 
	 * @return
	 * Return an ArrayList<Product> containing all results;
	 * If no result find, return empty ArrayList<Product> instead of null
	 */
	public ArrayList<Product> searchProduct(String[] keywords);

	public Product getById(String Id);
	
	public ArrayList<Product> getAll();
	
	public ArrayList<Product> searchByDirectory(String directory);
	
	public ArrayList<Product> getByUserId(String userId);
	
}
