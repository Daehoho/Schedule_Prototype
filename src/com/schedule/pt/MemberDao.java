package com.schedule.pt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDao {
	public static final int MEMBER_NONEXISTENT = 0;        
	public static final int MEMBER_EXISTENT = 1;           
	public static final int MEMBER_JOIN_FAIL = 0;          
	public static final int MEMBER_JOIN_SUCCESS = 1;      
	public static final int MEMBER_LOGIN_PW_NO_GOOD = 0; 
	public static final int MEMBER_LOGIN_SUCCESS = 1;      
	public static final int MEMBER_LOGIN_IS_NOT = -1;     
	public static final int MEMBER_KAKAO_IS_NOT = 0;  
	public static final int MEMBER_KAKAO_IS_SUCCESS = 1;  

	private static MemberDao instance = new MemberDao();

	private MemberDao() { }

	public static MemberDao getInstance() {
		return instance;
	}

	public int insertMember(MemberDto dto) {
		int ri = 0;

		Connection connection = null;
		PreparedStatement pstmt = null;
		String query = "insert into s_members values (?, ?, ?, ?)";

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, dto.geteMail());
			pstmt.setString(2, dto.getPw());
			pstmt.setString(3, dto.getName());
			pstmt.setInt(4, dto.getIsKakao());
			pstmt.executeUpdate();
			ri = MemberDao.MEMBER_JOIN_SUCCESS;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return ri;
	}

	public int confirmId (String email) {
		int ri = 0;

		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "select email from s_members where email =?";

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, email);
			set = pstmt.executeQuery();
			if(set.next()) {
				ri = MemberDao.MEMBER_EXISTENT;
			} else {
				ri = MemberDao.MEMBER_NONEXISTENT;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				set.close();
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return ri;
	}

	public int userCheck (String email, String pw) {
		int ri = 0;
		String dbPw;

		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "select pw from s_members where email = ?";

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, email);
			set = pstmt.executeQuery();

			if(set.next()) {
				dbPw = set.getString("pw");
				if(dbPw.equals(pw)) {
					ri = MemberDao.MEMBER_LOGIN_SUCCESS;
				} else {
					ri = MemberDao.MEMBER_LOGIN_PW_NO_GOOD; 
				}
			} else {
				ri = MemberDao.MEMBER_LOGIN_IS_NOT;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				set.close();
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return ri;
	}

	public MemberDto getMember(String email) {
		MemberDto dto = null;
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "select * from s_members where email = ?";

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, email);
			set = pstmt.executeQuery();

			if(set.next()) {
				dto = new MemberDto();
				dto.seteMail(set.getString("email"));
				dto.setPw(set.getString("pw"));
				dto.setName(set.getString("name"));
				dto.setBirth(set.getDate("birth"));
				dto.setAddress(set.getString("address"));
				dto.setIsKakao(set.getInt("isKakao"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				set.close();
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return dto;
	}

	public int updateMember(MemberDto dto) {
		int ri = 0;

		Connection connection = null;
		PreparedStatement pstmt = null;
		String query = "update s_members set pw=?, address=?, birth=?";

		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, dto.getPw());
			pstmt.setString(2, dto.getAddress());
			pstmt.setDate(3, dto.getBirth());
			ri = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				connection.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return ri;
	}
	
	public int confirmKakao (String id) {
		int ri = 0;
		
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet set = null;
		String query = "select email from s_members where email = ?";
		
		try {
			connection = getConnection();
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1,  id);
			set = pstmt.executeQuery();
			
			if(set.next()) {
				ri = MemberDao.MEMBER_KAKAO_IS_SUCCESS;
			} else {
				ri = MemberDao. MEMBER_KAKAO_IS_NOT;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				set.close();
				pstmt.close();
				connection.close();
			} catch(Exception e2) {
				e2.printStackTrace();
			}
		}
		return ri;
	}

	private Connection getConnection() {
		Context context = null;
		DataSource dataSource = null;
		Connection connection = null;
		try {
			context = new InitialContext();
			dataSource = (DataSource)context.lookup("java:comp/env/jdbc/Oracle11g");
			connection = dataSource.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return connection;
	}
}
