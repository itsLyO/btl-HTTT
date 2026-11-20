package model;

import java.util.Date;

public class Technician6 extends Employee6 {
    private static final long serialVersionUID = 1L;

    public Technician6() {
        super();
        this.role = "Technician";
    }

    public Technician6(int id, String username, String password, Date dob, String email, String tel, String role, String note, String position) {
        super(id, username, password, dob, email, tel, role, note, position);
    }
}
