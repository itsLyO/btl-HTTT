package model;

import java.util.Date;

public class Manager6 extends Employee6 {
    private static final long serialVersionUID = 1L;

    public Manager6() {
        super();
        this.role = "Manager";
    }

    public Manager6(int id, String username, String password, Date dob, String email, String tel, String role, String note, String position) {
        super(id, username, password, dob, email, tel, role, note, position);
    }
}
