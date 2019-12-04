package model.user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import model.product.Product;

@Repository
public class UserJDBCTemplate implements UserDAO {
	
	@Autowired
	private DriverManagerDataSource dataSource; //Auto injected, no need to initalize
	
	public DriverManagerDataSource getDataSource() {
		return dataSource;
	}

	public void setDataSource(DriverManagerDataSource dataSource) {
		this.dataSource = dataSource;
		jdbcTemplateObject = new JdbcTemplate(dataSource);
	}

	private JdbcTemplate jdbcTemplateObject;
	
	@Override
	public User getUserByIdAndPassword(String id, String password) {
		// TODO Auto-generated method stub
		String sql="select * from user where id='"+id+"'"+"and password ='"+password+"'";

		
		 ArrayList<User> list = (ArrayList<User>) jdbcTemplateObject.query(sql, new RowMapper<User>() {

				@Override
				public User mapRow(ResultSet rs, int rowNum) throws SQLException {
					// TODO Auto-generated method stub
					User u=new User();
					
					u.setId(rs.getString("id"));
					u.setCampus(rs.getString("campus"));
					u.setGender(rs.getString("gender"));
					u.setIconPath(rs.getString("iconPath"));
					u.setName(rs.getString("name"));
					u.setPassword(rs.getString("password"));
					u.setSchool(rs.getString("school"));
					u.setTelephone(rs.getString("telephone"));
					return u;
				}
				});
		if(list.isEmpty()) {
			return null;
		} else {
			return list.get(0);
		}
	}

	@Override
	public User addUser(String id, String name, String password, String gender, String school, String campus,
			String iconPath, String telephone) {
		// TODO Auto-generated method stub
		String sql="insert into user(id,name,password,gender,school,campus,iconpath,telephone) " + 
		" values (?,?,?,?,?,?,?,?)";
		jdbcTemplateObject.update(new PreparedStatementCreator() {

			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				// TODO Auto-generated method stub
				PreparedStatement pst=con.prepareStatement(sql);
				pst.setString(1, id);
				pst.setString(2, name);
				pst.setString(3, password);
				pst.setString(4, gender);
				pst.setString(5, school);
				pst.setString(6, campus);
				pst.setString(7, iconPath);
				pst.setString(8, telephone);
				return pst;
			}
		});
		return new User(id, name, password, gender, school, campus, iconPath, telephone);
	}

	@Override
	public boolean updateUser(String id, String name, String password, String gender, String school, String campus,
			String iconPath, String telephone) {
		// TODO Auto-generated method stub
		String sql = String.format("update user set"
				+ " name='%s', password='%s', gender='%s', school='%s', campus='%s', iconPath='%s', telephone='%s'"
				+ " where id='%s'", name, password, gender, school, campus, iconPath, telephone, id);

		jdbcTemplateObject.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				// TODO Auto-generated method stub
				PreparedStatement pst=con.prepareStatement(sql);
				return pst;
			}
		});		
		return true;
	}

	public boolean updateUserKeepImage(String id, String name, String password, String gender, 
			String school, String campus, String telephone) {
		String sql = String.format("update user set"
				+ " name='%s', password='%s', gender='%s', school='%s', campus='%s', telephone='%s'"
				+ " where id='%s'", name, password, gender, school, campus, telephone, id);
		
		jdbcTemplateObject.update(new PreparedStatementCreator() {
			@Override
			public PreparedStatement createPreparedStatement(Connection con) throws SQLException {
				// TODO Auto-generated method stub
				PreparedStatement pst=con.prepareStatement(sql);
				return pst;
			}
		});
		return true;
	}
	
	public User getUserById(String id) {
		String sql="select * from user where id='"+id+"'";
		 ArrayList<User> list = (ArrayList<User>) jdbcTemplateObject.query(sql, new RowMapper<User>() {

				@Override
				public User mapRow(ResultSet rs, int rowNum) throws SQLException {
					// TODO Auto-generated method stub
					User u=new User();
					
					u.setId(rs.getString("id"));
					u.setCampus(rs.getString("campus"));
					u.setGender(rs.getString("gender"));
					u.setIconPath(rs.getString("iconPath"));
					u.setName(rs.getString("name"));
					u.setPassword(rs.getString("password"));
					u.setSchool(rs.getString("school"));
					u.setTelephone(rs.getString("telephone"));
					return u;
				}
				});
		if(list.isEmpty()) {
			return null;
		} else {
			return list.get(0);
		}
	}
}
